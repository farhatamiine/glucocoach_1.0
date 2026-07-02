package com.glucocoach.server.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.glucocoach.server.domain.enums.LabResultType;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/** Catalog row for the lab-result "add" form — one per {@link LabResultType}. */
@Data
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
@Schema(description = "Analyte catalog entry: default unit and informational reference bounds "
        + "for the lab-result add form. Units stay editable per row.")
public class LabAnalyteResponse {

    @Schema(example = "HBA1C")
    private String code;

    @Schema(example = "HbA1c")
    private String displayName;

    @Schema(example = "%")
    private String defaultUnit;

    @Schema(example = "Glycemic control")
    private String category;

    @Schema(example = "4.0")
    private Double referenceLow;

    @Schema(example = "6.0")
    private Double referenceHigh;

    public static LabAnalyteResponse from(LabResultType type) {
        return LabAnalyteResponse.builder()
                .code(type.name())
                .displayName(type.getDisplayName())
                .defaultUnit(type.getDefaultUnit())
                .category(type.getCategory())
                .referenceLow(type.getReferenceLow())
                .referenceHigh(type.getReferenceHigh())
                .build();
    }
}
