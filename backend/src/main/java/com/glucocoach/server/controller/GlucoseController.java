package com.glucocoach.server.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.dto.response.GlucoseSummaryResponse;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;
import com.glucocoach.server.service.BolusService;
import com.glucocoach.server.service.GlucoseService;
import com.glucocoach.server.service.NightScoutService;

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
     * Fetches the last {@code days} days of CGM data and all user boluses,
     * then returns every metric the GlucoseService can compute.
     *
     * @param days number of days to analyse (default 90)
     */
    @GetMapping("/health-data")
    public ResponseEntity<GlucoseSummaryResponse> healthData(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(defaultValue = "90") int days) {

        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        List<BolusResponse> boluses = bolusService.getAll(currentUser.getEmail());

        List<NightscoutEntryDTO> rapidRise = glucoseService.detectRapidRise(entries);
        List<NightscoutEntryDTO> rapidFall = glucoseService.detectRapidFall(entries);

        GlucoseSummaryResponse summary = GlucoseSummaryResponse.builder()
                // meta
                .dataPoints(entries.size())
                .daysAnalyzed(days)
                // core stats
                .average(glucoseService.calculateAverage(entries))
                .stdDev(glucoseService.calculateStdDev(entries))
                .cv(glucoseService.calculateCV(entries))
                .gmi(glucoseService.calculateGMI(entries))
                // time in range
                .tir(glucoseService.calculateTIR(entries))
                .tbr(glucoseService.calculateTBR(entries))
                .tar(glucoseService.calculateTAR(entries))
                .tirByDay(glucoseService.calculateTIRByDay(days))
                // hypo / hyper counts
                .hypos(glucoseService.countHypos(entries))
                .severeHypos(glucoseService.countSevereHypos(entries))
                .hypers(glucoseService.countHypers(entries))
                .severeHypers(glucoseService.countSevereHypers(entries))
                // trend
                .currentTrend(glucoseService.getCurrentTrend())
                .rapidRiseEvents(rapidRise.size())
                .rapidFallEvents(rapidFall.size())
                .rapidRiseEntries(rapidRise)
                .rapidFallEntries(rapidFall)
                // patterns
                .dailyAverageByHour(glucoseService.getDailyAverageByHour(entries))
                .agp(glucoseService.getAGP(entries))
                // insulin
                .estimatedIsf(glucoseService.estimateInsulinSensitivity(entries, boluses))
                .mealBolusCorrelation(glucoseService.correlateMealBolus(entries, boluses))
                // risk
                .lbgi(glucoseService.calculateLBGI(entries))
                .hbgi(glucoseService.calculateHBGI(entries))
                .build();

        return ResponseEntity.ok(summary);
    }

    // ─── Individual endpoints ──────────────────────────────────────────────────

    @GetMapping("/trend")
    public ResponseEntity<Map<String, Object>> trend() {
        return ResponseEntity.ok(glucoseService.getCurrentTrend());
    }

    @GetMapping("/tir-by-day")
    public ResponseEntity<?> tirByDay(@RequestParam(defaultValue = "30") int days) {
        return ResponseEntity.ok(glucoseService.calculateTIRByDay(days));
    }

    @GetMapping("/agp")
    public ResponseEntity<?> agp(@RequestParam(defaultValue = "90") int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(glucoseService.getAGP(entries));
    }

    @GetMapping("/daily-average-by-hour")
    public ResponseEntity<?> dailyAverageByHour(@RequestParam(defaultValue = "90") int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return ResponseEntity.ok(glucoseService.getDailyAverageByHour(entries));
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
