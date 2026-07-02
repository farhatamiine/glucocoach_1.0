package com.glucocoach.server.dto.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * Aggregate insulin statistics computed from bolus + basal entries over the
 * last {@code days} local calendar days. Raw numbers only — no dosing advice.
 */
@Data
@Builder
@Schema(description = "Aggregate insulin statistics over the last `days` local calendar days, "
        + "computed from bolus and basal entries. Raw numbers only.")
public class InsulinSummaryResponse {

    @Schema(description = "Window length in days", example = "90")
    private int days;

    @Schema(description = "Average total daily dose: basal + bolus units per day", example = "42.0")
    private Double totalDailyDoseAvg;

    @Schema(description = "Average basal units per day", example = "22.0")
    private Double basalUnitsAvg;

    @Schema(description = "Average bolus units per day", example = "20.0")
    private Double bolusUnitsAvg;

    @Schema(description = "Basal share of total units (%)", example = "52.0")
    private Double basalPct;

    @Schema(description = "Bolus share of total units (%)", example = "48.0")
    private Double bolusPct;

    @Schema(description = "Number of correction boluses in the window", example = "31")
    private long correctionBolusCount;

    @Schema(description = "Number of meal boluses in the window", example = "95")
    private long mealBolusCount;

    @Schema(description = "Correction share of bolus units (%)", example = "35.0")
    private Double correctionUnitsPct;

    @Schema(description = "Average daily dose per kg of body weight; null when no weight is recorded",
            example = "0.6", nullable = true)
    private Double unitsPerKgPerDay;
}
