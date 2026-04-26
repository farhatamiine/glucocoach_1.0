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

import com.glucocoach.server.domain.LaboAnalysis;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.LaboAnalysisRequest;
import com.glucocoach.server.dto.response.LaboAnalysisResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.LaboAnalysisMapper;
import com.glucocoach.server.repository.LaboAnalysisRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class LaboAnalysisServiceTest {

    @Mock
    private LaboAnalysisRepository laboAnalysisRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private LaboAnalysisMapper laboAnalysisMapper;

    @InjectMocks
    private LaboAnalysisService laboAnalysisService;

    private User user;
    private LaboAnalysis labo;
    private LaboAnalysisRequest laboRequest;
    private LaboAnalysisResponse laboResponse;
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

        labo = LaboAnalysis.builder()
                .id(1L)
                .hba1c(6.5)
                .cholesterol(180.0)
                .triglycerides(120.0)
                .date(LocalDate.now())
                .user(user)
                .build();

        laboRequest = new LaboAnalysisRequest();
        laboRequest.setHba1c(6.5);
        laboRequest.setCholesterol(180.0);
        laboRequest.setTriglycerides(120.0);
        laboRequest.setDate(labo.getDate());

        laboResponse = new LaboAnalysisResponse();
        laboResponse.setId(1L);
        laboResponse.setHba1c(6.5);
        laboResponse.setCholesterol(180.0);
        laboResponse.setTriglycerides(120.0);
        laboResponse.setDate(labo.getDate());
        laboResponse.setUserId(user.getId());
    }

    @Test
    void getAll_shouldReturnListOfLaboResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(laboAnalysisRepository.findByUserIdOrderByDateDesc(user.getId())).thenReturn(List.of(labo));
        when(laboAnalysisMapper.toResponse(labo)).thenReturn(laboResponse);

        // Act
        List<LaboAnalysisResponse> result = laboAnalysisService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
        verify(laboAnalysisRepository).findByUserIdOrderByDateDesc(user.getId());
    }

    @Test
    void create_shouldSaveAndReturnLaboResponse() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(laboAnalysisMapper.toEntity(laboRequest)).thenReturn(labo);
        when(laboAnalysisRepository.save(any(LaboAnalysis.class))).thenReturn(labo);
        when(laboAnalysisMapper.toResponse(labo)).thenReturn(laboResponse);

        // Act
        LaboAnalysisResponse result = laboAnalysisService.create(laboRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(laboAnalysisRepository).save(any(LaboAnalysis.class));
    }

    @Test
    void update_shouldUpdateExistingLabo() {
        // Arrange
        Long laboId = 1L;
        LaboAnalysisRequest updateRequest = new LaboAnalysisRequest();
        updateRequest.setHba1c(7.0);
        updateRequest.setDate(LocalDate.now());

        LaboAnalysisResponse updatedResponse = new LaboAnalysisResponse();
        updatedResponse.setId(laboId);
        updatedResponse.setHba1c(7.0);

        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(laboAnalysisRepository.findByIdAndUserId(laboId, user.getId())).thenReturn(Optional.of(labo));
        when(laboAnalysisRepository.save(any(LaboAnalysis.class))).thenReturn(labo);
        when(laboAnalysisMapper.toResponse(labo)).thenReturn(updatedResponse);

        // Act
        LaboAnalysisResponse result = laboAnalysisService.update(laboId, updateRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getHba1c()).isEqualTo(7.0);
        verify(laboAnalysisRepository).save(labo);
    }

    @Test
    void delete_shouldRemoveLabo_whenExists() {
        // Arrange
        Long laboId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(laboAnalysisRepository.findByIdAndUserId(laboId, user.getId())).thenReturn(Optional.of(labo));

        // Act
        laboAnalysisService.delete(laboId, userEmail);

        // Assert
        verify(laboAnalysisRepository).delete(labo);
    }

    @Test
    void delete_shouldThrowException_whenDoesNotExist() {
        // Arrange
        Long laboId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(laboAnalysisRepository.findByIdAndUserId(laboId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> laboAnalysisService.delete(laboId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(laboAnalysisRepository, never()).delete(any(LaboAnalysis.class));
    }
}
