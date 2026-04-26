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

import com.glucocoach.server.domain.Bolus;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.BolusType;
import com.glucocoach.server.dto.request.BolusRequest;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.BolusMapper;
import com.glucocoach.server.repository.BolusRepository;
import com.glucocoach.server.repository.MealRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class BolusServiceTest {

    @Mock
    private BolusRepository bolusRepository;

    @Mock
    private MealRepository mealRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private BolusMapper bolusMapper;

    @InjectMocks
    private BolusService bolusService;

    private User user;
    private Bolus bolus;
    private BolusRequest bolusRequest;
    private BolusResponse bolusResponse;
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

        bolus = Bolus.builder()
                .id(1L)
                .amount(5.0)
                .bolusType(BolusType.CORRECTION)
                .timestamp(LocalDateTime.now())
                .user(user)
                .build();

        bolusRequest = new BolusRequest();
        bolusRequest.setAmount(5.0);
        bolusRequest.setBolusType(BolusType.CORRECTION);
        bolusRequest.setTimestamp(bolus.getTimestamp());

        bolusResponse = new BolusResponse();
        bolusResponse.setId(1L);
        bolusResponse.setAmount(5.0);
        bolusResponse.setBolusType(BolusType.CORRECTION);
        bolusResponse.setTimestamp(bolus.getTimestamp());
        bolusResponse.setUserId(user.getId());
    }

    @Test
    void getAll_shouldReturnListOfBolusResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusRepository.findByUserIdOrderByTimestampDesc(user.getId())).thenReturn(List.of(bolus));
        when(bolusMapper.toResponse(bolus)).thenReturn(bolusResponse);

        // Act
        List<BolusResponse> result = bolusService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
        verify(bolusRepository).findByUserIdOrderByTimestampDesc(user.getId());
    }

    @Test
    void create_shouldSaveAndReturnBolusResponse_whenNoMealId() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusMapper.toEntity(bolusRequest)).thenReturn(bolus);
        when(bolusRepository.save(any(Bolus.class))).thenReturn(bolus);
        when(bolusMapper.toResponse(bolus)).thenReturn(bolusResponse);

        // Act
        BolusResponse result = bolusService.create(bolusRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(bolusRepository).save(any(Bolus.class));
        verify(mealRepository, never()).findByIdAndUserId(any(), any());
    }

    @Test
    void create_shouldSaveWithMeal_whenMealIdProvided() {
        // Arrange
        Long mealId = 10L;
        bolusRequest.setMealId(mealId);
        bolusRequest.setBolusType(BolusType.MEAL);
        
        Meal meal = Meal.builder().id(mealId).user(user).build();
        
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusMapper.toEntity(bolusRequest)).thenReturn(bolus);
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.of(meal));
        when(bolusRepository.save(any(Bolus.class))).thenReturn(bolus);
        when(bolusMapper.toResponse(bolus)).thenReturn(bolusResponse);

        // Act
        bolusService.create(bolusRequest, userEmail);

        // Assert
        verify(mealRepository).findByIdAndUserId(mealId, user.getId());
        verify(bolusRepository).save(any(Bolus.class));
    }

    @Test
    void create_shouldThrowException_whenMealNotFound() {
        // Arrange
        Long mealId = 99L;
        bolusRequest.setMealId(mealId);
        
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusMapper.toEntity(bolusRequest)).thenReturn(bolus);
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> bolusService.create(bolusRequest, userEmail))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Meal not found");
        
        verify(bolusRepository, never()).save(any());
    }

    @Test
    void delete_shouldRemoveBolus_whenExists() {
        // Arrange
        Long bolusId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusRepository.findByIdAndUserId(bolusId, user.getId())).thenReturn(Optional.of(bolus));

        // Act
        bolusService.delete(bolusId, userEmail);

        // Assert
        verify(bolusRepository).delete(bolus);
    }

    @Test
    void delete_shouldThrowException_whenDoesNotExist() {
        // Arrange
        Long bolusId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(bolusRepository.findByIdAndUserId(bolusId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> bolusService.delete(bolusId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(bolusRepository, never()).delete(any(Bolus.class));
    }
}
