package com.glucocoach.server.dto.request;

import java.time.LocalDate;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

@Data
public class HealthDataRequest {

    @Positive(message = "Weight must be positive")
    private Double weight;

    @Positive(message = "Heart rate must be positive")
    private Integer heartRate;

    // Format: "120/80"
    private String bloodPressure;

    @NotNull(message = "Date is required")
    private LocalDate date;
}
