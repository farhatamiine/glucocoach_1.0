package com.glucocoach.server.service;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.UserRequest;
import com.glucocoach.server.dto.response.UserResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.UserMapper;
import com.glucocoach.server.repository.UserRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private UserMapper userMapper;

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
}
