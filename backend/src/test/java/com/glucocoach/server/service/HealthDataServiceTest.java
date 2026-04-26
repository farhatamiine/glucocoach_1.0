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

import com.glucocoach.server.domain.HealthData;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.HealthDataRequest;
import com.glucocoach.server.dto.response.HealthDataResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.HealthDataMapper;
import com.glucocoach.server.repository.HealthDataRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class HealthDataServiceTest {

    @Mock
    private HealthDataRepository healthDataRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private HealthDataMapper healthDataMapper;

    @InjectMocks
    private HealthDataService healthDataService;

    private User user;
    private HealthData healthData;
    private HealthDataRequest healthDataRequest;
    private HealthDataResponse healthDataResponse;
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

        healthData = HealthData.builder()
                .id(1L)
                .weight(75.5)
                .heartRate(72)
                .bloodPressure("120/80")
                .date(LocalDate.now())
                .user(user)
                .build();

        healthDataRequest = new HealthDataRequest();
        healthDataRequest.setWeight(75.5);
        healthDataRequest.setHeartRate(72);
        healthDataRequest.setBloodPressure("120/80");
        healthDataRequest.setDate(healthData.getDate());

        healthDataResponse = new HealthDataResponse();
        healthDataResponse.setId(1L);
        healthDataResponse.setWeight(75.5);
        healthDataResponse.setHeartRate(72);
        healthDataResponse.setBloodPressure("120/80");
        healthDataResponse.setDate(healthData.getDate());
        healthDataResponse.setUserId(user.getId());
    }

    @Test
    void getAll_shouldReturnListOfHealthDataResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(healthDataRepository.findByUserIdOrderByDateDesc(user.getId())).thenReturn(List.of(healthData));
        when(healthDataMapper.toResponse(healthData)).thenReturn(healthDataResponse);

        // Act
        List<HealthDataResponse> result = healthDataService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
        verify(healthDataRepository).findByUserIdOrderByDateDesc(user.getId());
    }

    @Test
    void create_shouldSaveAndReturnHealthDataResponse() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(healthDataMapper.toEntity(healthDataRequest)).thenReturn(healthData);
        when(healthDataRepository.save(any(HealthData.class))).thenReturn(healthData);
        when(healthDataMapper.toResponse(healthData)).thenReturn(healthDataResponse);

        // Act
        HealthDataResponse result = healthDataService.create(healthDataRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(healthDataRepository).save(any(HealthData.class));
    }

    @Test
    void delete_shouldRemoveHealthData_whenExists() {
        // Arrange
        Long dataId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(healthDataRepository.findByIdAndUserId(dataId, user.getId())).thenReturn(Optional.of(healthData));

        // Act
        healthDataService.delete(dataId, userEmail);

        // Assert
        verify(healthDataRepository).delete(healthData);
    }

    @Test
    void delete_shouldThrowException_whenDoesNotExist() {
        // Arrange
        Long dataId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(healthDataRepository.findByIdAndUserId(dataId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> healthDataService.delete(dataId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(healthDataRepository, never()).delete(any(HealthData.class));
    }
}
