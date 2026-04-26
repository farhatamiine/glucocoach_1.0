package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.Instant;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.glucocoach.server.domain.RefreshToken;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ForgetPasswordRequest;
import com.glucocoach.server.dto.request.LoginRequest;
import com.glucocoach.server.dto.request.RefreshRequest;
import com.glucocoach.server.dto.request.RegisterRequest;
import com.glucocoach.server.dto.request.ResetPasswordRequest;
import com.glucocoach.server.dto.response.AuthResponse;
import com.glucocoach.server.exception.DuplicateEmailException;
import com.glucocoach.server.exception.UnauthorizedException;
import com.glucocoach.server.repository.RefreshTokenRepository;
import com.glucocoach.server.repository.UserRepository;
import com.glucocoach.server.security.JwtService;

@ExtendWith(MockitoExtension.class)
public class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private JwtService jwtService;

    @Mock
    private PasswordEncoder passwordEncoder;

    @Mock
    private RefreshTokenRepository refreshTokenRepository;

    @InjectMocks
    private AuthService authService;

    private User user;
    private final String email = "test@example.com";
    private final String password = "password";

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email(email)
                .password("encoded_password")
                .build();
    }

    @Test
    void register_shouldCreateUserAndReturnTokens() {
        // Arrange
        RegisterRequest request = new RegisterRequest();
        request.setEmail(email);
        request.setPassword(password);
        request.setFirstName("John");
        request.setLastName("Doe");

        when(userRepository.existsByEmail(email)).thenReturn(false);
        when(passwordEncoder.encode(password)).thenReturn("encoded_password");
        when(jwtService.generateToken(email)).thenReturn("access_token");
        when(jwtService.generateRefreshToken(email)).thenReturn("refresh_token");

        // Act
        AuthResponse result = authService.register(request);

        // Assert
        assertThat(result.getAccessToken()).isEqualTo("access_token");
        assertThat(result.getRefreshToken()).isEqualTo("refresh_token");
        verify(userRepository).save(any(User.class));
        verify(refreshTokenRepository).save(any(RefreshToken.class));
    }

    @Test
    void register_shouldThrowException_whenEmailExists() {
        // Arrange
        RegisterRequest request = new RegisterRequest();
        request.setEmail(email);

        when(userRepository.existsByEmail(email)).thenReturn(true);

        // Act & Assert
        assertThatThrownBy(() -> authService.register(request))
                .isInstanceOf(DuplicateEmailException.class);
        verify(userRepository, never()).save(any());
    }

    @Test
    void login_shouldReturnTokens_whenCredentialsAreValid() {
        // Arrange
        LoginRequest request = new LoginRequest();
        request.setEmail(email);
        request.setPassword(password);

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));
        when(passwordEncoder.matches(password, user.getPassword())).thenReturn(true);
        when(jwtService.generateToken(email)).thenReturn("access_token");
        when(jwtService.generateRefreshToken(email)).thenReturn("refresh_token");

        // Act
        AuthResponse result = authService.login(request);

        // Assert
        assertThat(result.getAccessToken()).isEqualTo("access_token");
        verify(refreshTokenRepository).deleteByUser(user);
        verify(refreshTokenRepository).save(any(RefreshToken.class));
    }

    @Test
    void login_shouldThrowException_whenPasswordInvalid() {
        // Arrange
        LoginRequest request = new LoginRequest();
        request.setEmail(email);
        request.setPassword("wrong");

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("wrong", user.getPassword())).thenReturn(false);

        // Act & Assert
        assertThatThrownBy(() -> authService.login(request))
                .isInstanceOf(UnauthorizedException.class);
    }

    @Test
    void refresh_shouldReturnNewTokens_whenTokenValid() {
        // Arrange
        String oldRefreshToken = "old_token";
        RefreshRequest request = new RefreshRequest();
        request.setRefreshToken(oldRefreshToken);

        RefreshToken storedToken = RefreshToken.builder()
                .token(oldRefreshToken)
                .expiresAt(Instant.now().plusSeconds(3600))
                .user(user)
                .build();

        when(refreshTokenRepository.findByToken(oldRefreshToken)).thenReturn(Optional.of(storedToken));
        when(jwtService.generateToken(email)).thenReturn("new_access");
        when(jwtService.generateRefreshToken(email)).thenReturn("new_refresh");

        // Act
        AuthResponse result = authService.refresh(request);

        // Assert
        assertThat(result.getAccessToken()).isEqualTo("new_access");
        verify(refreshTokenRepository).delete(storedToken);
        verify(refreshTokenRepository).save(any(RefreshToken.class));
    }

    @Test
    void refresh_shouldThrowException_whenTokenExpired() {
        // Arrange
        String oldRefreshToken = "expired_token";
        RefreshRequest request = new RefreshRequest();
        request.setRefreshToken(oldRefreshToken);

        RefreshToken expiredToken = RefreshToken.builder()
                .token(oldRefreshToken)
                .expiresAt(Instant.now().minusSeconds(3600))
                .user(user)
                .build();

        when(refreshTokenRepository.findByToken(oldRefreshToken)).thenReturn(Optional.of(expiredToken));

        // Act & Assert
        assertThatThrownBy(() -> authService.refresh(request))
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("expired");
        verify(refreshTokenRepository).delete(expiredToken);
    }

    @Test
    void logout_shouldDeleteToken_whenFound() {
        // Arrange
        String token = "logout_token";
        RefreshRequest request = new RefreshRequest();
        request.setRefreshToken(token);
        RefreshToken refreshToken = RefreshToken.builder().token(token).build();

        when(refreshTokenRepository.findByToken(token)).thenReturn(Optional.of(refreshToken));

        // Act
        authService.logout(request);

        // Assert
        verify(refreshTokenRepository).delete(refreshToken);
    }

    @Test
    void forgetPassword_shouldGenerateToken_whenUserExists() {
        // Arrange
        ForgetPasswordRequest request = new ForgetPasswordRequest();
        request.setEmail(email);

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));

        // Act
        String token = authService.forgetPassword(request);

        // Assert
        assertThat(token).isNotBlank();
        assertThat(user.getResetToken()).isEqualTo(token);
        assertThat(user.getResetTokenExpiresAt()).isAfter(Instant.now());
        verify(userRepository).save(user);
    }

    @Test
    void resetPassword_shouldUpdatePassword_whenTokenValid() {
        // Arrange
        String token = "valid_token";
        user.setResetToken(token);
        user.setResetTokenExpiresAt(Instant.now().plusSeconds(3600));

        ResetPasswordRequest request = new ResetPasswordRequest();
        request.setToken(token);
        request.setNewPassword("new_secret");

        when(userRepository.findByResetToken(token)).thenReturn(Optional.of(user));
        when(passwordEncoder.encode("new_secret")).thenReturn("new_encoded_password");

        // Act
        authService.resetPassword(request);

        // Assert
        assertThat(user.getPassword()).isEqualTo("new_encoded_password");
        assertThat(user.getResetToken()).isNull();
        verify(userRepository).save(user);
    }

    @Test
    void resetPassword_shouldThrowException_whenTokenExpired() {
        // Arrange
        String token = "expired_token";
        user.setResetToken(token);
        user.setResetTokenExpiresAt(Instant.now().minusSeconds(3600));

        ResetPasswordRequest request = new ResetPasswordRequest();
        request.setToken(token);

        when(userRepository.findByResetToken(token)).thenReturn(Optional.of(user));

        // Act & Assert
        assertThatThrownBy(() -> authService.resetPassword(request))
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("expired");
    }
}
