package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.BasalRequest;
import com.glucocoach.server.dto.response.BasalResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.BasalMapper;
import com.glucocoach.server.repository.BasalRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class BasalServiceTest {

    @Mock
    private BasalRepository basalRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private BasalMapper basalMapper;

    @InjectMocks
    private BasalService basalService;

    private User user;
    private Basal basal;
    private BasalRequest basalRequest;
    private BasalResponse basalResponse;
    private final String userEmail = "john@example.com";

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email(userEmail)
                .firstName("John")
                .lastName("Doe")
                .birthDate(LocalDate.of(1990, 1, 1))
                .build();

        basal = Basal.builder()
                .id(1L)
                .amount(10.0)
                .injectedAt(LocalDateTime.now())
                .user(user)
                .build();

        basalRequest = new BasalRequest();
        basalRequest.setAmount(10.0);
        basalRequest.setInjectedAt(basal.getInjectedAt());

        basalResponse = new BasalResponse();
        basalResponse.setId(1L);
        basalResponse.setAmount(10.0);
        basalResponse.setInjectedAt(basal.getInjectedAt());
        basalResponse.setUserId(user.getId());
    }

    @Test
    void getAll_shouldReturnListOfBasalResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(basalRepository.findByUserIdOrderByInjectedAtDesc(user.getId())).thenReturn(List.of(basal));
        when(basalMapper.toResponse(basal)).thenReturn(basalResponse);

        // Act
        List<BasalResponse> result = basalService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
        verify(basalRepository).findByUserIdOrderByInjectedAtDesc(user.getId());
    }

    @Test
    void create_shouldSaveAndReturnBasalResponse() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(basalMapper.toEntity(basalRequest)).thenReturn(basal);
        when(basalRepository.save(any(Basal.class))).thenReturn(basal);
        when(basalMapper.toResponse(basal)).thenReturn(basalResponse);

        // Act
        BasalResponse result = basalService.create(basalRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(basalRepository).save(any(Basal.class));
    }

    @Test
    void delete_shouldRemoveBasal_whenExists() {
        // Arrange
        Long basalId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(basalRepository.findByIdAndUserId(basalId, user.getId())).thenReturn(Optional.of(basal));

        // Act
        basalService.delete(basalId, userEmail);

        // Assert
        verify(basalRepository).delete(basal);
    }

    @Test
    void delete_shouldThrowException_whenDoesNotExist() {
        // Arrange
        Long basalId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(basalRepository.findByIdAndUserId(basalId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> basalService.delete(basalId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(basalRepository, never()).delete(any(Basal.class));
    }
}
