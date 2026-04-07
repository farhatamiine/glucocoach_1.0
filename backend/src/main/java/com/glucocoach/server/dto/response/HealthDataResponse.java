package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class HealthDataResponse {
    private Long id;
    private Double weight;
    private Integer heartRate;
    private String bloodPressure;
    private LocalDate date;
    private Long userId;
}
