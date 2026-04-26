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

import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.MealMapper;
import com.glucocoach.server.repository.MealRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class MealServiceTest {

    @Mock
    private MealRepository mealRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private MealMapper mealMapper;

    @InjectMocks
    private MealService mealService;

    private Meal meal;
    private User user;
    private MealResponse mealResponse;
    private MealRequest mealRequest;
    private final String userEmail = "john@example.com";

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .firstName("John")
                .lastName("Doe")
                .email(userEmail)
                .birthDate(LocalDate.of(1990, 1, 15))
                .build();

        meal = Meal.builder()
                .id(1L)
                .name("CheeseCake")
                .carbs(20.0)
                .timestamp(LocalDateTime.now())
                .user(user)
                .build();

        mealRequest = new MealRequest();
        mealRequest.setCarbs(20.0);
        mealRequest.setName("CheeseCake");
        mealRequest.setTimestamp(meal.getTimestamp());

        mealResponse = new MealResponse();
        mealResponse.setId(1L);
        mealResponse.setCarbs(20.0);
        mealResponse.setName("CheeseCake");
        mealResponse.setUserId(user.getId());
        mealResponse.setTimestamp(meal.getTimestamp());
    }

    @Test
    void getAll_shouldReturnListOfMealResponses() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByUserIdOrderByTimestampDesc(user.getId())).thenReturn(List.of(meal));
        when(mealMapper.toResponse(meal)).thenReturn(mealResponse);

        // Act
        List<MealResponse> result = mealService.getAll(userEmail);

        // Assert
        assertThat(result).hasSize(1);
        assertThat(result.get(0).getName()).isEqualTo("CheeseCake");
        verify(userRepository).findByEmail(userEmail);
        verify(mealRepository).findByUserIdOrderByTimestampDesc(user.getId());
    }

    @Test
    void getById_shouldReturnMealResponse_whenMealExists() {
        // Arrange
        Long mealId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.of(meal));
        when(mealMapper.toResponse(meal)).thenReturn(mealResponse);

        // Act
        MealResponse result = mealService.getById(mealId, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(mealId);
        verify(mealRepository).findByIdAndUserId(mealId, user.getId());
    }

    @Test
    void getById_shouldThrowException_whenMealDoesNotExist() {
        // Arrange
        Long mealId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> mealService.getById(mealId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Meal not found");
    }

    @Test
    void create_shouldSaveAndReturnMealResponse() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealMapper.toEntity(mealRequest)).thenReturn(meal);
        when(mealRepository.save(any(Meal.class))).thenReturn(meal);
        when(mealMapper.toResponse(meal)).thenReturn(mealResponse);

        // Act
        MealResponse result = mealService.create(mealRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getName()).isEqualTo("CheeseCake");
        verify(mealRepository).save(any(Meal.class));
    }

    @Test
    void update_shouldUpdateExistingMeal() {
        // Arrange
        Long mealId = 1L;
        MealRequest updateRequest = new MealRequest();
        updateRequest.setName("Updated Meal");
        updateRequest.setCarbs(30.0);
        updateRequest.setTimestamp(LocalDateTime.now());

        MealResponse updatedResponse = new MealResponse();
        updatedResponse.setId(mealId);
        updatedResponse.setName("Updated Meal");
        updatedResponse.setCarbs(30.0);

        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.of(meal));
        when(mealRepository.save(any(Meal.class))).thenReturn(meal);
        when(mealMapper.toResponse(meal)).thenReturn(updatedResponse);

        // Act
        MealResponse result = mealService.update(mealId, updateRequest, userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getName()).isEqualTo("Updated Meal");
        verify(mealRepository).save(meal);
    }

    @Test
    void delete_shouldRemoveMeal_whenMealExists() {
        // Arrange
        Long mealId = 1L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.of(meal));

        // Act
        mealService.delete(mealId, userEmail);

        // Assert
        verify(mealRepository).delete(meal);
    }

    @Test
    void delete_shouldThrowException_whenMealDoesNotExist() {
        // Arrange
        Long mealId = 99L;
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(mealRepository.findByIdAndUserId(mealId, user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> mealService.delete(mealId, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(mealRepository, never()).delete(any(Meal.class));
    }

    @Test
    void getUser_shouldThrowException_whenUserNotFound() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> mealService.getAll(userEmail))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessage("User not found");
    }
}
