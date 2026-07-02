package com.glucocoach.server.controller;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.dto.response.DailyGlucoseSummaryResponse;
import com.glucocoach.server.dto.response.GlucoseSummaryResponse;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;
import com.glucocoach.server.service.BolusService;
import com.glucocoach.server.service.GlucoseService;
import com.glucocoach.server.service.NightScoutService;
import com.glucocoach.server.util.LocalDayUtil;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/glucose")
@RequiredArgsConstructor
public class GlucoseController {

    private final GlucoseService glucoseService;
    private final NightScoutService nightScoutService;
    private final BolusService bolusService;

    /**
     * Full health summary — the main dashboard endpoint.
     *
     * <p>Without {@code date}: fetches the last {@code days} days of CGM data and
     * all user boluses (unchanged behavior). With {@code date}: computes the same
     * summary over that single local calendar day (in {@code tz}); {@code days}
     * is ignored. A day without data returns 200 with dataPoints=0 and empty maps.</p>
     */
    @Operation(summary = "Glucose health summary", description = "Every glucose metric over the last `days` "
            + "days, or — when `date` (YYYY-MM-DD) is given — over that single local calendar day in `tz` "
            + "(days is then ignored). Per-day buckets (tirByDay) and per-hour buckets use the tz local-day "
            + "boundary. A date without data returns 200 with dataPoints=0 and empty maps; an invalid date "
            + "or tz returns 400.")
    @GetMapping("/health-data")
    public ResponseEntity<GlucoseSummaryResponse> healthData(
            @AuthenticationPrincipal User currentUser,
            @Parameter(description = "Number of days to analyse (ignored when date is present)")
            @RequestParam(defaultValue = "90") int days,
            @Parameter(description = "Single local calendar day to analyse (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {

        ZoneId zone = LocalDayUtil.parseZone(tz);

        List<NightscoutEntryDTO> entries;
        List<BolusResponse> boluses;
        int daysAnalyzed;
        Map<String, Object> currentTrend;

        if (date != null) {
            Instant start = LocalDayUtil.startOfDayInstant(date, zone);
            Instant end = LocalDayUtil.endOfDayInstantExclusive(date, zone);
            entries = glucoseService.filterWithin(nightScoutService.getEntriesBetween(start, end), start, end);
            // only that day's boluses, so ISF / meal-bolus correlation stay within the day
            boluses = bolusService.getAll(currentUser.getEmail(), date, date, zone);
            daysAnalyzed = 1;
            currentTrend = null; // the latest live reading is meaningless for a historical day
        } else {
            entries = nightScoutService.getEntriesByDay(days);
            boluses = bolusService.getAll(currentUser.getEmail());
            daysAnalyzed = days;
            currentTrend = glucoseService.getCurrentTrend();
        }

        List<NightscoutEntryDTO> rapidRise = glucoseService.detectRapidRise(entries);
        List<NightscoutEntryDTO> rapidFall = glucoseService.detectRapidFall(entries);

        GlucoseSummaryResponse summary = GlucoseSummaryResponse.builder()
                // meta
                .dataPoints(entries.size())
                .daysAnalyzed(daysAnalyzed)
                // core stats
                .average(glucoseService.calculateAverage(entries))
                .stdDev(glucoseService.calculateStdDev(entries))
                .cv(glucoseService.calculateCV(entries))
                .gmi(glucoseService.calculateGMI(entries))
                // time in range
                .tir(glucoseService.calculateTIR(entries))
                .tbr(glucoseService.calculateTBR(entries))
                .tar(glucoseService.calculateTAR(entries))
                .tirByDay(glucoseService.calculateTIRByDay(entries, zone))
                // hypo / hyper counts
                .hypos(glucoseService.countHypos(entries))
                .severeHypos(glucoseService.countSevereHypos(entries))
                .hypers(glucoseService.countHypers(entries))
                .severeHypers(glucoseService.countSevereHypers(entries))
                // trend
                .currentTrend(currentTrend)
                .rapidRiseEvents(rapidRise.size())
                .rapidFallEvents(rapidFall.size())
                .rapidRiseEntries(rapidRise)
                .rapidFallEntries(rapidFall)
                // patterns
                .dailyAverageByHour(glucoseService.getDailyAverageByHour(entries, zone))
                .agp(glucoseService.getAGP(entries, zone))
                // insulin
                .estimatedIsf(glucoseService.estimateInsulinSensitivity(entries, boluses))
                .mealBolusCorrelation(glucoseService.correlateMealBolus(entries, boluses))
                // risk
                .lbgi(glucoseService.calculateLBGI(entries))
                .hbgi(glucoseService.calculateHBGI(entries))
                .build();

        return ResponseEntity.ok(summary);
    }

    /**
     * One summary row per local calendar day — powers the daily-log appendix and
     * enriches the TIR calendar. Same bucketing as tirByDay, sorted by date ascending.
     */
    @Operation(summary = "Per-day glucose series", description = "One row per local calendar day (in `tz`) "
            + "over the last `days` days, sorted by date ascending: date, average, tir, tbr, tar, readings. "
            + "Uses the same local-day bucketing as tirByDay, so tir values match tirByDay for the same "
            + "dates. Days without readings are omitted.")
    @GetMapping("/daily-summary")
    public ResponseEntity<List<DailyGlucoseSummaryResponse>> dailySummary(
            @RequestParam(defaultValue = "90") int days,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        ZoneId zone = LocalDayUtil.parseZone(tz);
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(glucoseService.buildDailySummaries(entries, zone));
    }

    // ─── Individual endpoints ──────────────────────────────────────────────────

    @GetMapping("/trend")
    public ResponseEntity<Map<String, Object>> trend() {
        return ResponseEntity.ok(glucoseService.getCurrentTrend());
    }

    @Operation(summary = "TIR per day", description = "TIR (%) per local calendar day (in `tz`).")
    @GetMapping("/tir-by-day")
    public ResponseEntity<?> tirByDay(
            @RequestParam(defaultValue = "30") int days,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        return ResponseEntity.ok(glucoseService.calculateTIRByDay(days, LocalDayUtil.parseZone(tz)));
    }

    @Operation(summary = "Ambulatory glucose profile", description = "Glucose percentiles per local hour "
            + "of the day (0–23, in `tz`).")
    @GetMapping("/agp")
    public ResponseEntity<?> agp(
            @RequestParam(defaultValue = "90") int days,
            @Parameter(description = "IANA timezone defining the local hour-of-day")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(glucoseService.getAGP(entries, LocalDayUtil.parseZone(tz)));
    }

    @Operation(summary = "Average glucose per hour", description = "Average glucose per local hour of the "
            + "day (0–23, in `tz`).")
    @GetMapping("/daily-average-by-hour")
    public ResponseEntity<?> dailyAverageByHour(
            @RequestParam(defaultValue = "90") int days,
            @Parameter(description = "IANA timezone defining the local hour-of-day")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(glucoseService.getDailyAverageByHour(entries, LocalDayUtil.parseZone(tz)));
    }

    @GetMapping("/rapid-events")
    public ResponseEntity<?> rapidEvents(@RequestParam(defaultValue = "7") int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(Map.of(
                "rapidRise", glucoseService.detectRapidRise(entries),
                "rapidFall", glucoseService.detectRapidFall(entries)
        ));
    }

    @GetMapping("/risk")
    public ResponseEntity<?> risk(@RequestParam(defaultValue = "90") int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(Map.of(
                "lbgi", glucoseService.calculateLBGI(entries),
                "hbgi", glucoseService.calculateHBGI(entries)
        ));
    }

    @GetMapping("/insulin-sensitivity")
    public ResponseEntity<?> insulinSensitivity(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(defaultValue = "90") int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        List<BolusResponse> boluses = bolusService.getAll(currentUser.getEmail());
        return ResponseEntity.ok(Map.of(
                "estimatedIsf", glucoseService.estimateInsulinSensitivity(entries, boluses)
        ));
    }
}
