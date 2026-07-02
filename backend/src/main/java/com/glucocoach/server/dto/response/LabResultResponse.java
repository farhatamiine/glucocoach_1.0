package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.glucocoach.server.domain.enums.LabResultType;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class LabResultResponse {
    private Long id;
    private LabResultType type;
    private String customName;
    private Double value;
    private String unit;
    private LocalDate date;
    private Double referenceLow;
    private Double referenceHigh;
    private String note;
    private Long userId;
}
