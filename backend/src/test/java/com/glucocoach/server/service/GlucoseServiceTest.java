package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.dto.response.DailyGlucoseSummaryResponse;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;

@ExtendWith(MockitoExtension.class)
class GlucoseServiceTest {

    private static final ZoneId PARIS = ZoneId.of("Europe/Paris");

    @Mock
    private NightScoutService nightScoutService;

    @InjectMocks
    private GlucoseService glucoseService;

    private static NightscoutEntryDTO entry(String sysTime, int sgv) {
        NightscoutEntryDTO e = new NightscoutEntryDTO();
        e.setSysTime(sysTime);
        e.setSgv(sgv);
        return e;
    }

    // ── local-day bucketing ───────────────────────────────────────────────────

    @Test
    void calculateTIRByDay_shouldBucketByLocalDay_notUtcDay() {
        // 23:30 UTC on June 23 is 01:30 on June 24 in Paris (UTC+2 in summer)
        List<NightscoutEntryDTO> entries = List.of(
                entry("2026-06-23T23:30:00Z", 100),
                entry("2026-06-24T10:00:00Z", 250));

        Map<LocalDate, Double> tirByDay = glucoseService.calculateTIRByDay(entries, PARIS);

        assertThat(tirByDay).containsOnlyKeys(LocalDate.of(2026, 6, 24));
        assertThat(tirByDay.get(LocalDate.of(2026, 6, 24))).isEqualTo(50.0);
    }

    @Test
    void calculateTIRByDay_shouldSplitAcrossUtcMidnightInOtherZones() {
        List<NightscoutEntryDTO> entries = List.of(
                entry("2026-06-23T23:30:00Z", 100),
                entry("2026-06-24T10:00:00Z", 250));

        Map<LocalDate, Double> tirByDay = glucoseService.calculateTIRByDay(entries, ZoneId.of("UTC"));

        assertThat(tirByDay).containsOnlyKeys(LocalDate.of(2026, 6, 23), LocalDate.of(2026, 6, 24));
    }

    // ── daily summaries ───────────────────────────────────────────────────────

    @Test
    void buildDailySummaries_shouldMatchTirByDayAndBeSortedAscending() {
        List<NightscoutEntryDTO> entries = List.of(
                entry("2026-06-24T10:00:00Z", 60),   // below
                entry("2026-06-24T11:00:00Z", 120),  // in range
                entry("2026-06-24T12:00:00Z", 240),  // above
                entry("2026-06-23T10:00:00Z", 150)); // previous day, in range

        List<DailyGlucoseSummaryResponse> rows = glucoseService.buildDailySummaries(entries, PARIS);
        Map<LocalDate, Double> tirByDay = glucoseService.calculateTIRByDay(entries, PARIS);

        assertThat(rows).hasSize(2);
        assertThat(rows.get(0).getDate()).isEqualTo(LocalDate.of(2026, 6, 23));
        assertThat(rows.get(1).getDate()).isEqualTo(LocalDate.of(2026, 6, 24));

        DailyGlucoseSummaryResponse june24 = rows.get(1);
        assertThat(june24.getTir()).isEqualTo(tirByDay.get(june24.getDate()));
        assertThat(june24.getReadings()).isEqualTo(3);
        assertThat(june24.getAverage()).isEqualTo(140.0);
        assertThat(june24.getTbr()).isCloseTo(100.0 / 3, org.assertj.core.data.Offset.offset(1e-9));
        assertThat(june24.getTar()).isCloseTo(100.0 / 3, org.assertj.core.data.Offset.offset(1e-9));
    }

    @Test
    void buildDailySummaries_shouldReturnEmptyList_whenNoEntries() {
        assertThat(glucoseService.buildDailySummaries(List.of(), PARIS)).isEmpty();
    }

    // ── empty-input guards (single day without data must not produce NaN) ─────

    @Test
    void calculations_shouldReturnZero_whenNoEntries() {
        List<NightscoutEntryDTO> empty = List.of();

        assertThat(glucoseService.calculateTIR(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateTBR(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateTAR(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateAverage(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateCV(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateGMI(empty)).isEqualTo(0.0);
        assertThat(glucoseService.calculateTIRByDay(empty, PARIS)).isEmpty();
        assertThat(glucoseService.getDailyAverageByHour(empty, PARIS)).isEmpty();
        assertThat(glucoseService.getAGP(empty, PARIS)).isEmpty();
    }

    // ── window filtering ──────────────────────────────────────────────────────

    @Test
    void filterWithin_shouldKeepOnlyEntriesInHalfOpenWindow() {
        Instant start = Instant.parse("2026-06-23T22:00:00Z"); // June 24 starts in Paris
        Instant end = Instant.parse("2026-06-24T22:00:00Z");

        List<NightscoutEntryDTO> entries = List.of(
                entry("2026-06-23T21:59:59Z", 100), // before window
                entry("2026-06-23T22:00:00Z", 110), // window start, included
                entry("2026-06-24T12:00:00Z", 120), // inside
                entry("2026-06-24T22:00:00Z", 130), // window end, excluded
                entry(null, 140));                   // no sysTime, dropped

        List<NightscoutEntryDTO> filtered = glucoseService.filterWithin(entries, start, end);

        assertThat(filtered).hasSize(2);
        assertThat(filtered.get(0).getSgv()).isEqualTo(110);
        assertThat(filtered.get(1).getSgv()).isEqualTo(120);
    }

    // ── hour bucketing uses the requested zone ────────────────────────────────

    @Test
    void getDailyAverageByHour_shouldUseLocalHour() {
        // 10:00 UTC = 12:00 Paris in summer
        List<NightscoutEntryDTO> entries = List.of(entry("2026-06-24T10:00:00Z", 100));

        Map<Integer, Double> byHour = glucoseService.getDailyAverageByHour(entries, PARIS);

        assertThat(byHour).containsOnlyKeys(12);
    }
}
