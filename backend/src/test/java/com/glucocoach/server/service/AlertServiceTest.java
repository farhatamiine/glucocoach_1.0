package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.AlertMapper;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class AlertServiceTest {

    @Mock
    private AlertRepository alertRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private AlertMapper alertMapper;

    @InjectMocks
    private AlertService alertService;

    private User user;
    private Alert alert;
    private AlertRequest alertRequest;
    private AlertResponse alertResponse;
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

        alert = Alert.builder()
                .id(1L)
                .thresholdLow(70.0)
                .thresholdHigh(180.0)
                .notifyVia(NotifyVia.EMAIL)
                .active(true)
                .user(user)
                .build();

        alertRequest = new AlertRequest();
        alertRequest.setThresholdLow(70.0);
        alertRequest.setThresholdHigh(180.0);
        alertRequest.setNotifyVia(NotifyVia.EMAIL);
        alertRequest.setActive(true);

        alertResponse = new AlertResponse();
        alertResponse.setId(1L);
        alertResponse.setThresholdLow(70.0);
        alertResponse.setThresholdHigh(180.0);
        alertResponse.setNotifyVia(NotifyVia.EMAIL);
        alertResponse.setActive(true);
        alertResponse.setUserId(user.getId());
    }

    @Test
    void getAll_shouldReturnListOfAlertResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertRepository.findByUserId(user.getId())).thenReturn(List.of(alert));
        when(alertMapper.toResponse(alert)).thenReturn(alertResponse);

        // Act
        List<AlertResponse> result = alertService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
        verify(alertRepository).findByUserId(user.getId());
    }

    @Test
    void create_shouldSaveAndReturnAlertResponse() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertMapper.toEntity(alertRequest)).thenReturn(alert);
        when(alertRepository.save(any(Alert.class))).thenReturn(alert);
        when(alertMapper.toResponse(alert)).thenReturn(alertResponse);

        // Act
        AlertResponse result = alertService.create(alertRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(alertRepository).save(any(Alert.class));
    }

    @Test
    void update_shouldUpdateExistingAlert() {
        // Arrange
        Long alertId = 1L;
        AlertRequest updateRequest = new AlertRequest();
        updateRequest.setThresholdLow(80.0);
        updateRequest.setThresholdHigh(200.0);
        updateRequest.setNotifyVia(NotifyVia.SMS);
        updateRequest.setActive(false);

        AlertResponse updatedResponse = new AlertResponse();
        updatedResponse.setId(alertId);
        updatedResponse.setThresholdLow(80.0);
        updatedResponse.setThresholdHigh(200.0);

        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertRepository.findByIdAndUserId(alertId, user.getId())).thenReturn(Optional.of(alert));
        when(alertRepository.save(any(Alert.class))).thenReturn(alert);
        when(alertMapper.toResponse(alert)).thenReturn(updatedResponse);

        // Act
        AlertResponse result = alertService.update(alertId, updateRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getThresholdLow()).isEqualTo(80.0);
        verify(alertRepository).save(alert);
    }

    @Test
    void update_shouldThrowException_whenAlertDoesNotExist() {
        // Arrange
        Long alertId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertRepository.findByIdAndUserId(alertId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> alertService.update(alertId, alertRequest, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
    }

    @Test
    void delete_shouldRemoveAlert_whenAlertExists() {
        // Arrange
        Long alertId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertRepository.findByIdAndUserId(alertId, user.getId())).thenReturn(Optional.of(alert));

        // Act
        alertService.delete(alertId, userEmail);

        // Assert
        verify(alertRepository).delete(alert);
    }

    @Test
    void delete_shouldThrowException_whenAlertDoesNotExist() {
        // Arrange
        Long alertId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(alertRepository.findByIdAndUserId(alertId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> alertService.delete(alertId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(alertRepository, never()).delete(any(Alert.class));
    }
}
