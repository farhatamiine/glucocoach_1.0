package com.glucocoach.server.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ChangePasswordRequest;
import com.glucocoach.server.dto.request.UserRequest;
import com.glucocoach.server.dto.response.UserResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.exception.UnauthorizedException;
import com.glucocoach.server.mapper.UserMapper;
import com.glucocoach.server.repository.RefreshTokenRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    // ── GET ME ────────────────────────────────────────────────────────────────
    // Called by GET /api/users/me
    // email comes from the JWT via SecurityContextHolder in the controller
    public UserResponse getMe(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found with email: " + email));
        return userMapper.toResponse(user);
    }

    // ── UPDATE ME ─────────────────────────────────────────────────────────────
    // Called by PUT /api/users/me
    // Only updates firstName, lastName, birthDate — email/password have dedicated flows
    @Transactional
    public UserResponse updateMe(String email, UserRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found with email: " + email));

        user.setFirstName(request.getFirstName());
        user.setLastName(request.getLastName());
        user.setBirthDate(request.getBirthDate());

        return userMapper.toResponse(userRepository.save(user));
    }

    // ── DELETE ME ─────────────────────────────────────────────────────────────
    // Called by DELETE /api/users/me
    // Cascade = ALL on the User → Profile relation means Profile is auto-deleted
    // RefreshToken has no cascade, but deleteByUser in the repo handles it
    @Transactional
    public void deleteMe(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found with email: " + email));
        userRepository.delete(user);
    }

    @Transactional
    public void changePassword(String email, ChangePasswordRequest request) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (!passwordEncoder.matches(request.getOldPassword(), user.getPassword())) {
            throw new UnauthorizedException("Invalid old password");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
        refreshTokenRepository.deleteByUser(user);
    }
}
