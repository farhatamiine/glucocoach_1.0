package com.glucocoach.server.dto.response;

import java.time.LocalDate;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import lombok.Data;

/**
 * One row per local calendar day — same bucketing as
 * {@link GlucoseSummaryResponse#getTirByDay()}, so {@code tir} here matches
 * {@code tirByDay} for the same date.
 */
@Data
@Builder
@Schema(description = "Per-local-day glucose summary row. Days are bucketed with the "
        + "same tz-based boundary as tirByDay; rows are sorted by date ascending and "
        + "only days with at least one reading are included.")
public class DailyGlucoseSummaryResponse {

    @Schema(description = "Local calendar day (in the requested tz)", example = "2026-06-24")
    private LocalDate date;

    @Schema(description = "Average glucose that day (mg/dL)", example = "154.0")
    private Double average;

    @Schema(description = "% of readings 70–180 mg/dL", example = "57.0")
    private Double tir;

    @Schema(description = "% of readings below 70 mg/dL", example = "5.0")
    private Double tbr;

    @Schema(description = "% of readings above 180 mg/dL", example = "38.0")
    private Double tar;

    @Schema(description = "Number of CGM readings that day", example = "268")
    private long readings;
}
