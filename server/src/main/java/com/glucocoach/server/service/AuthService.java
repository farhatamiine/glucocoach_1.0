package com.glucocoach.server.service;

import java.time.Instant;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.RefreshToken;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.LoginRequest;
import com.glucocoach.server.dto.request.RefreshRequest;
import com.glucocoach.server.dto.request.RegisterRequest;
import com.glucocoach.server.dto.response.AuthResponse;
import com.glucocoach.server.exception.DuplicateEmailException;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.exception.UnauthorizedException;
import com.glucocoach.server.repository.RefreshTokenRepository;
import com.glucocoach.server.repository.UserRepository;
import com.glucocoach.server.security.JwtService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;
    private final RefreshTokenRepository refreshTokenRepository;

    // ── REGISTER ─────────────────────────────────────────────────────────────
    @Transactional
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.getEmail())) {
            throw new DuplicateEmailException("Email already in use: " + request.getEmail());
        }

        // Build and save the User with ALL fields from RegisterRequest
        User user = User.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .birthDate(request.getBirthDate())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .build();
        userRepository.save(user);

        // Generate tokens and save refresh token linked to the user
        String accessToken = jwtService.generateToken(user.getEmail());
        String refreshToken = jwtService.generateRefreshToken(user.getEmail());

        refreshTokenRepository.save(RefreshToken.builder()
                .token(refreshToken)
                .expiresAt(Instant.now().plusMillis(604800000))
                .user(user)   // ← was missing: links token to the user row (FK user_id)
                .build());

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }

    // ── LOGIN ─────────────────────────────────────────────────────────────────
    @Transactional
    public AuthResponse login(LoginRequest request) {
        User user = userRepository
                .findByEmail(request.getEmail())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found with email: " + request.getEmail()));

        if (!passwordEncoder.matches(request.getPassword(), user.getPassword())) {
            throw new UnauthorizedException("Invalid password");
        }

        // Delete any existing refresh token for this user (one token per user)
        refreshTokenRepository.deleteByUser(user);
        // flush() forces Hibernate to send the DELETE to the DB immediately.
        // Without this, Hibernate batches the DELETE + INSERT together and the DB
        // sees the INSERT first → UNIQUE constraint violation on user_id.
        refreshTokenRepository.flush();

        String accessToken = jwtService.generateToken(user.getEmail());
        String refreshToken = jwtService.generateRefreshToken(user.getEmail());

        refreshTokenRepository.save(RefreshToken.builder()
                .token(refreshToken)
                .expiresAt(Instant.now().plusMillis(604800000))
                .user(user)
                .build());

        return AuthResponse.builder()
                .accessToken(accessToken)
                .refreshToken(refreshToken)
                .build();
    }

    // ── REFRESH ───────────────────────────────────────────────────────────────
    // Client sends the refresh token → gets a new access token + new refresh token
    // The old refresh token is deleted (rotation: one-time use)
    @Transactional
    public AuthResponse refresh(RefreshRequest request) {
        RefreshToken stored = refreshTokenRepository
                .findByToken(request.getRefreshToken())
                .orElseThrow(() -> new UnauthorizedException("Refresh token not found"));

        // Check if the refresh token has expired
        if (stored.getExpiresAt().isBefore(Instant.now())) {
            refreshTokenRepository.delete(stored);   // clean up expired token
            throw new UnauthorizedException("Refresh token has expired, please log in again");
        }

        User user = stored.getUser();

        // Delete the old refresh token (rotation — prevents reuse)
        refreshTokenRepository.delete(stored);
        refreshTokenRepository.flush(); // same reason as login — force DELETE before INSERT

        // Issue brand new tokens
        String newAccessToken = jwtService.generateToken(user.getEmail());
        String newRefreshToken = jwtService.generateRefreshToken(user.getEmail());

        refreshTokenRepository.save(RefreshToken.builder()
                .token(newRefreshToken)
                .expiresAt(Instant.now().plusMillis(604800000))
                .user(user)
                .build());

        return AuthResponse.builder()
                .accessToken(newAccessToken)
                .refreshToken(newRefreshToken)
                .build();
    }

    // ── LOGOUT ────────────────────────────────────────────────────────────────
    // Client sends their refresh token → it is deleted from the DB
    // The access token will expire naturally (stateless — we don't blacklist it)
    @Transactional
    public void logout(RefreshRequest request) {
        refreshTokenRepository.findByToken(request.getRefreshToken())
                .ifPresent(refreshTokenRepository::delete);
        // ifPresent: if token doesn't exist we do nothing (idempotent logout)
    }
}
