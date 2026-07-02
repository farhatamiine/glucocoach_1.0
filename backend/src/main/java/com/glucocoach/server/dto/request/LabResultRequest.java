package com.glucocoach.server.dto.request;

import java.time.LocalDate;

import com.glucocoach.server.domain.enums.LabResultType;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class LabResultRequest {

    @NotNull(message = "Type is required")
    private LabResultType type;

    @Schema(description = "Analyte name — required when type is CUSTOM")
    private String customName;

    @NotNull(message = "Value is required")
    private Double value;

    @NotBlank(message = "Unit is required")
    @Schema(description = "Measurement unit, e.g. \"%\", \"g/L\", \"mg/dL\", \"mmol/L\", \"mL/min\", \"mUI/L\"")
    private String unit;

    @NotNull(message = "Date is required")
    private LocalDate date;

    private Double referenceLow;

    private Double referenceHigh;

    private String note;
}
