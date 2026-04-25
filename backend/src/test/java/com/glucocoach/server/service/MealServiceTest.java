package com.glucocoach.server.service;

import java.time.LocalDate;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.mapper.MealMapper;
import com.glucocoach.server.repository.MealRepository;

@ExtendWith(MockitoExtension.class)
public class MealServiceTest {

    @Mock
    private MealRepository mealRepository;

    @Mock
    private MealMapper mealMapper;

    @Mock
    private MealService mealService;

    private Meal meal;
    private User user;
    private MealResponse mealResponse;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .firstName("John")
                .lastName("Doe")
                .email("john@example.com")
                .birthDate(LocalDate.of(1990, 1, 15))
                .build();

        meal = Meal.builder()
                .id(1L)
                .name("CheeseCake")
                .carbs(20.0)
                .user(user)
                .build();

        mealResponse = new MealResponse();
        mealResponse.setCarbs(20.0);
        mealResponse.setName("Cheesecake");
        mealResponse.setUserId(user.getId());
    }
}
