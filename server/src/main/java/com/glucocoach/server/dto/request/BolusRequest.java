package com.glucocoach.server.dto.request;

import java.time.LocalDateTime;

import com.glucocoach.server.domain.enums.BolusType;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

@Data
public class BolusRequest {

    @NotNull(message = "Amount is required")
    @Positive(message = "Amount must be positive")
    private Double amount;

    @NotNull(message = "Bolus type is required")
    private BolusType bolusType;

    @NotNull(message = "Timestamp is required")
    private LocalDateTime timestamp;

    // Optional — only provided when bolusType is MEAL
    // If null, the bolus is a standalone correction
    private Long mealId;
}
