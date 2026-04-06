package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class LaboAnalysisResponse {
    private Long id;
    private Double hba1c;
    private Double cholesterol;
    private Double triglycerides;
    private LocalDate date;
    private Long userId;
}
