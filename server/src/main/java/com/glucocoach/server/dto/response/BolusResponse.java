package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;

import com.glucocoach.server.domain.enums.BolusType;
import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class BolusResponse {
    private Long id;
    private Double amount;
    private BolusType bolusType;
    private LocalDateTime timestamp;
    private Long mealId;   // null when bolusType is CORRECTION
    private Long userId;
}
