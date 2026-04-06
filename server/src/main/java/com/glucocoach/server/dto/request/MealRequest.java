package com.glucocoach.server.dto.request;

import java.time.LocalDateTime;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

@Data
public class MealRequest {

    @NotBlank(message = "Meal name is required")
    private String name;

    @NotNull(message = "Carbs amount is required")
    @Positive(message = "Carbs must be positive")
    private Double carbs;

    @NotNull(message = "Timestamp is required")
    private LocalDateTime timestamp;
}
