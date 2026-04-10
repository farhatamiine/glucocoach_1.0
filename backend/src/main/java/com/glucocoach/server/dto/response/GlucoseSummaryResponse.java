package com.glucocoach.server.dto.response;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class GlucoseSummaryResponse {

    // ─── Meta ──────────────────────────────────────────────────────────────────
    private int dataPoints;
    private int daysAnalyzed;

    // ─── Core Statistics ───────────────────────────────────────────────────────
    private Double average;
    private Double stdDev;
    private Double cv;
    private Double gmi;

    // ─── Time in Range ─────────────────────────────────────────────────────────
    /** % of readings between 70–180 mg/dL */
    private Double tir;
    /** % of readings below 70 mg/dL */
    private Double tbr;
    /** % of readings above 180 mg/dL */
    private Double tar;
    /** TIR (%) broken down per calendar day */
    private Map<LocalDate, Double> tirByDay;

    // ─── Hypo / Hyper Counts ───────────────────────────────────────────────────
    private Long hypos;
    private Long severeHypos;
    private Long hypers;
    private Long severeHypers;

    // ─── Trend ─────────────────────────────────────────────────────────────────
    /** Latest reading: sgv, direction, delta */
    private Map<String, Object> currentTrend;
    private int rapidRiseEvents;
    private int rapidFallEvents;

    // ─── Pattern Recognition ───────────────────────────────────────────────────
    /** Average glucose per hour of day (0–23) */
    private Map<Integer, Double> dailyAverageByHour;
    /**
     * Ambulatory Glucose Profile: p5, p25, p50, p75, p95 per hour of day (0–23)
     */
    private Map<Integer, Map<String, Double>> agp;

    // ─── Insulin Correlation ───────────────────────────────────────────────────
    /** Estimated insulin sensitivity factor (mg/dL per unit) */
    private Double estimatedIsf;
    /** Per meal-bolus: was the post-meal spike prevented? (bolus ID → boolean) */
    private Map<Long, Boolean> mealBolusCorrelation;

    // ─── Risk Indices ──────────────────────────────────────────────────────────
    /** Low Blood Glucose Index (> 2.5 = high risk) */
    private Double lbgi;
    /** High Blood Glucose Index (> 4.5 = high risk) */
    private Double hbgi;

    // ─── Rapid Events (detail) ─────────────────────────────────────────────────
    private List<NightscoutEntryDTO> rapidRiseEntries;
    private List<NightscoutEntryDTO> rapidFallEntries;
}
