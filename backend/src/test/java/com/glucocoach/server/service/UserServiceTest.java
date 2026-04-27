package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ChangePasswordRequest;
import com.glucocoach.server.dto.request.UserRequest;
import com.glucocoach.server.dto.response.UserResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.exception.UnauthorizedException;
import com.glucocoach.server.mapper.UserMapper;
import com.glucocoach.server.repository.RefreshTokenRepository;
import com.glucocoach.server.repository.UserRepository;
import org.springframework.security.crypto.password.PasswordEncoder;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private RefreshTokenRepository refreshTokenRepository;

    @Mock
    private UserMapper userMapper;

    @Mock
    private PasswordEncoder passwordEncoder;

    @InjectMocks
    private UserService userService;

    private User user;
    private UserResponse userResponse;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .firstName("John")
                .lastName("Doe")
                .email("john@example.com")
                .password("old_encoded_password")
                .birthDate(LocalDate.of(1990, 1, 15))
                .build();

        userResponse = new UserResponse();
        userResponse.setId(1L);
        userResponse.setFirstName("John");
        userResponse.setLastName("Doe");
        userResponse.setEmail("john@example.com");
        userResponse.setBirthDate(LocalDate.of(1990, 1, 15));
    }

    // ── getMe ─────────────────────────────────────────────────────────────────

    @Test
    void getMe_shouldReturnUserResponse_whenUserExists() {
        when(userRepository.findByEmail("john@example.com")).thenReturn(Optional.of(user));
        when(userMapper.toResponse(user)).thenReturn(userResponse);

        UserResponse result = userService.getMe("john@example.com");

        assertThat(result.getEmail()).isEqualTo("john@example.com");
        assertThat(result.getFirstName()).isEqualTo("John");
        verify(userRepository).findByEmail("john@example.com");
        verify(userMapper).toResponse(user);
    }

    @Test
    void getMe_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        when(userRepository.findByEmail("missing@example.com")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.getMe("missing@example.com"))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("missing@example.com");
    }

    // ── updateMe ──────────────────────────────────────────────────────────────

    @Test
    void updateMe_shouldUpdateFieldsAndReturnResponse_whenUserExists() {
        UserRequest request = new UserRequest();
        request.setFirstName("Jane");
        request.setLastName("Smith");
        request.setBirthDate(LocalDate.of(1995, 6, 20));

        User updatedUser = User.builder()
                .id(1L)
                .firstName("Jane")
                .lastName("Smith")
                .email("john@example.com")
                .birthDate(LocalDate.of(1995, 6, 20))
                .build();

        UserResponse updatedResponse = new UserResponse();
        updatedResponse.setFirstName("Jane");
        updatedResponse.setLastName("Smith");
        updatedResponse.setBirthDate(LocalDate.of(1995, 6, 20));

        when(userRepository.findByEmail("john@example.com")).thenReturn(Optional.of(user));
        when(userRepository.save(user)).thenReturn(updatedUser);
        when(userMapper.toResponse(updatedUser)).thenReturn(updatedResponse);

        UserResponse result = userService.updateMe("john@example.com", request);

        assertThat(result.getFirstName()).isEqualTo("Jane");
        assertThat(result.getLastName()).isEqualTo("Smith");
        verify(userRepository).save(user);
    }

    @Test
    void updateMe_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        UserRequest request = new UserRequest();
        request.setFirstName("Jane");
        request.setLastName("Smith");
        request.setBirthDate(LocalDate.of(1995, 6, 20));

        when(userRepository.findByEmail("missing@example.com")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.updateMe("missing@example.com", request))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("missing@example.com");

        verify(userRepository, never()).save(any());
    }

    // ── deleteMe ──────────────────────────────────────────────────────────────

    @Test
    void deleteMe_shouldDeleteUser_whenUserExists() {
        when(userRepository.findByEmail("john@example.com")).thenReturn(Optional.of(user));

        userService.deleteMe("john@example.com");

        verify(userRepository).delete(user);
    }

    @Test
    void deleteMe_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        when(userRepository.findByEmail("missing@example.com")).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.deleteMe("missing@example.com"))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("missing@example.com");

        verify(userRepository, never()).delete(any());
    }

    // ── changePassword ────────────────────────────────────────────────────────

    @Test
    void changePassword_shouldUpdatePassword_whenOldPasswordValid() {
        // Arrange
        String email = "john@example.com";
        ChangePasswordRequest request = new ChangePasswordRequest();
        request.setOldPassword("old_secret");
        request.setNewPassword("new_secret");

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("old_secret", user.getPassword())).thenReturn(true);
        when(passwordEncoder.encode("new_secret")).thenReturn("encoded_new_secret");

        // Act
        userService.changePassword(email, request);

        // Assert
        assertThat(user.getPassword()).isEqualTo("encoded_new_secret");
        verify(userRepository).save(user);
        verify(refreshTokenRepository).deleteByUser(user);
    }

    @Test
    void changePassword_shouldThrowUnauthorizedException_whenOldPasswordInvalid() {
        // Arrange
        String email = "john@example.com";
        ChangePasswordRequest request = new ChangePasswordRequest();
        request.setOldPassword("wrong_secret");

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));
        when(passwordEncoder.matches("wrong_secret", user.getPassword())).thenReturn(false);

        // Act & Assert
        assertThatThrownBy(() -> userService.changePassword(email, request))
                .isInstanceOf(UnauthorizedException.class)
                .hasMessageContaining("Invalid old password");

        verify(userRepository, never()).save(any());
    }

    // ── saveFcmToken ──────────────────────────────────────────────────────────

    @Test
    void saveFcmToken_shouldSetTokenAndSave_whenUserExists() {
        // Arrange
        String email = "john@example.com";
        String fcmToken = "test_fcm_token_123";

        when(userRepository.findByEmail(email)).thenReturn(Optional.of(user));

        // Act
        userService.saveFcmToken(email, fcmToken);

        // Assert
        assertThat(user.getFcmToken()).isEqualTo(fcmToken);
        verify(userRepository).save(user);
    }

    @Test
    void saveFcmToken_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        // Arrange
        String email = "missing@example.com";
        String fcmToken = "test_fcm_token_123";

        when(userRepository.findByEmail(email)).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> userService.saveFcmToken(email, fcmToken))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining(email);

        verify(userRepository, never()).save(any());
    }

    // ── clearFcmToken ─────────────────────────────────────────────────────────

    @Test
    void clearFcmToken_shouldNullifyTokenAndSave_whenUserExists() {
        user.setFcmToken("stale-token");
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));

        userService.clearFcmToken(1L);

        assertThat(user.getFcmToken()).isNull();
        verify(userRepository).save(user);
    }

    @Test
    void clearFcmToken_shouldThrowResourceNotFoundException_whenUserDoesNotExist() {
        when(userRepository.findById(99L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> userService.clearFcmToken(99L))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("99");

        verify(userRepository, never()).save(any());
    }
}
