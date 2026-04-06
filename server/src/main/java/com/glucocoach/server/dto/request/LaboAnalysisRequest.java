package com.glucocoach.server.dto.request;

import java.time.LocalDate;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Data;

@Data
public class LaboAnalysisRequest {

    @Positive(message = "HbA1c must be positive")
    private Double hba1c;

    @Positive(message = "Cholesterol must be positive")
    private Double cholesterol;

    @Positive(message = "Triglycerides must be positive")
    private Double triglycerides;

    @NotNull(message = "Date is required")
    private LocalDate date;
}
