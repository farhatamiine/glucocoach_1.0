package com.glucocoach.server.service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.OptionalDouble;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.apache.commons.math.stat.descriptive.DescriptiveStatistics;
import org.springframework.stereotype.Service;

import com.glucocoach.server.domain.enums.BolusType;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;

import lombok.AllArgsConstructor;

@AllArgsConstructor
@Service
public class GlucoseService {

    private final NightScoutService nightScoutService;

    // ─── Core Statistics ───────────────────────────────────────────────────────

    public Double calculateAverage(List<NightscoutEntryDTO> entries) {
        OptionalDouble avg = entries.stream().mapToInt(NightscoutEntryDTO::getSgv).average();
        return avg.orElse(0);
    }

    public Double calculateStdDev(List<NightscoutEntryDTO> entries) {
        DescriptiveStatistics stats = new DescriptiveStatistics();
        entries.forEach(e -> stats.addValue(e.getSgv().doubleValue()));
        return stats.getStandardDeviation();
    }

    public Double calculateCV(List<NightscoutEntryDTO> entries) {
        return (calculateStdDev(entries) / calculateAverage(entries)) * 100;
    }

    public Double calculateGMI(List<NightscoutEntryDTO> entries) {
        return 3.31 + (0.02392 * calculateAverage(entries));
    }

    // ─── Time in Range ─────────────────────────────────────────────────────────

    public Double calculateTIR(List<NightscoutEntryDTO> entries) {
        long count = entries.stream()
                .filter(e -> e.getSgv() >= 70 && e.getSgv() <= 180)
                .count();
        return ((double) count / entries.size()) * 100;
    }

    public Double calculateTBR(List<NightscoutEntryDTO> entries) {
        long count = entries.stream().filter(e -> e.getSgv() < 70).count();
        return ((double) count / entries.size()) * 100;
    }

    public Double calculateTAR(List<NightscoutEntryDTO> entries) {
        long count = entries.stream().filter(e -> e.getSgv() > 180).count();
        return ((double) count / entries.size()) * 100;
    }

    /**
     * Returns TIR (%) per calendar day for the last {@code days} days.
     */
    public Map<LocalDate, Double> calculateTIRByDay(int days) {
        List<NightscoutEntryDTO> entries = nightScoutService.getEntriesByDay(days);
        return entries.stream()
                .filter(e -> e.getSysTime() != null)
                .collect(Collectors.groupingBy(
                        e -> parseInstant(e.getSysTime()).atZone(ZoneId.systemDefault()).toLocalDate(),
                        Collectors.collectingAndThen(Collectors.toList(), this::calculateTIR)));
    }

    // ─── Hypo / Hyper Analysis ─────────────────────────────────────────────────

    public long countHypos(List<NightscoutEntryDTO> entries) {
        return entries.stream().filter(e -> e.getSgv() < 70).count();
    }

    public long countSevereHypos(List<NightscoutEntryDTO> entries) {
        return entries.stream().filter(e -> e.getSgv() < 54).count();
    }

    public long countHypers(List<NightscoutEntryDTO> entries) {
        return entries.stream().filter(e -> e.getSgv() > 180).count();
    }

    public long countSevereHypers(List<NightscoutEntryDTO> entries) {
        return entries.stream().filter(e -> e.getSgv() > 250).count();
    }

    // ─── Trend Analysis ────────────────────────────────────────────────────────

    /**
     * Returns the latest Nightscout reading with its direction and delta.
     * Keys: "sgv", "direction", "delta".
     */
    public Map<String, Object> getCurrentTrend() {
        List<NightscoutEntryDTO> latest = nightScoutService.getEntries(1);
        if (latest.isEmpty())
            return Collections.emptyMap();
        NightscoutEntryDTO e = latest.get(0);
        Map<String, Object> trend = new LinkedHashMap<>();
        trend.put("sgv", e.getSgv());
        trend.put("direction", e.getDirection());
        trend.put("delta", e.getDelta());
        return trend;
    }

    /**
     * Returns entries with a rapid rise: delta > 15 mg/dL per 5-min interval (> 3
     * mg/dL/min).
     */
    public List<NightscoutEntryDTO> detectRapidRise(List<NightscoutEntryDTO> entries) {
        return entries.stream()
                .filter(e -> e.getDelta() != null && e.getDelta() > 15.0)
                .collect(Collectors.toList());
    }

    /**
     * Returns entries with a rapid fall: delta < -15 mg/dL per 5-min interval (< -3
     * mg/dL/min).
     */
    public List<NightscoutEntryDTO> detectRapidFall(List<NightscoutEntryDTO> entries) {
        return entries.stream()
                .filter(e -> e.getDelta() != null && e.getDelta() < -15.0)
                .collect(Collectors.toList());
    }

    // ─── Pattern Recognition ───────────────────────────────────────────────────

    /**
     * Average glucose per hour of the day (0–23). Useful for spotting dawn
     * phenomenon
     * and post-meal patterns.
     */
    public Map<Integer, Double> getDailyAverageByHour(List<NightscoutEntryDTO> entries) {
        return entries.stream()
                .filter(e -> e.getSysTime() != null)
                .collect(Collectors.groupingBy(
                        e -> parseInstant(e.getSysTime()).atZone(ZoneId.systemDefault()).getHour(),
                        Collectors.averagingDouble(e -> e.getSgv().doubleValue())));
    }

    /**
     * Ambulatory Glucose Profile: 5th, 25th, 50th, 75th, and 95th percentiles of
     * glucose
     * per hour of the day (0–23).
     */
    public Map<Integer, Map<String, Double>> getAGP(List<NightscoutEntryDTO> entries) {
        Map<Integer, List<Double>> byHour = entries.stream()
                .filter(e -> e.getSysTime() != null)
                .collect(Collectors.groupingBy(
                        e -> parseInstant(e.getSysTime()).atZone(ZoneId.systemDefault()).getHour(),
                        Collectors.mapping(e -> e.getSgv().doubleValue(), Collectors.toList())));

        Map<Integer, Map<String, Double>> agp = new TreeMap<>();
        byHour.forEach((hour, values) -> {
            DescriptiveStatistics stats = new DescriptiveStatistics();
            values.forEach(stats::addValue);
            Map<String, Double> percentiles = new LinkedHashMap<>();
            percentiles.put("p5", stats.getPercentile(5));
            percentiles.put("p25", stats.getPercentile(25));
            percentiles.put("p50", stats.getPercentile(50));
            percentiles.put("p75", stats.getPercentile(75));
            percentiles.put("p95", stats.getPercentile(95));
            agp.put(hour, percentiles);
        });
        return agp;
    }

    // ─── Insulin Correlation ───────────────────────────────────────────────────

    /**
     * For each MEAL bolus, checks whether glucose peaked above 180 mg/dL within 2
     * hours
     * after the bolus. Returns bolus ID → true if spike was prevented (peak ≤ 180).
     */
    public Map<Long, Boolean> correlateMealBolus(List<NightscoutEntryDTO> entries,
            List<BolusResponse> boluses) {
        Map<Long, Boolean> result = new LinkedHashMap<>();
        boluses.stream()
                .filter(b -> b.getBolusType() == BolusType.MEAL)
                .forEach(bolus -> {
                    Instant bolusTime = bolus.getTimestamp().atZone(ZoneId.systemDefault()).toInstant();
                    Instant windowEnd = bolusTime.plusSeconds(2 * 3600);

                    double peak = entries.stream()
                            .filter(e -> e.getSysTime() != null)
                            .filter(e -> {
                                Instant t = parseInstant(e.getSysTime());
                                return t.isAfter(bolusTime) && t.isBefore(windowEnd);
                            })
                            .mapToDouble(e -> e.getSgv().doubleValue())
                            .max()
                            .orElse(0);

                    result.put(bolus.getId(), peak <= 180);
                });
        return result;
    }

    /**
     * Estimates insulin sensitivity factor (ISF): average mg/dL drop per unit of
     * correction bolus.
     * Measures glucose nadir in the 2–4 hour window after each correction bolus.
     */
    public Double estimateInsulinSensitivity(List<NightscoutEntryDTO> entries,
            List<BolusResponse> boluses) {
        List<Double> isfValues = boluses.stream()
                .filter(b -> b.getBolusType() == BolusType.CORRECTION && b.getAmount() > 0)
                .flatMap(bolus -> {
                    Instant bolusTime = bolus.getTimestamp().atZone(ZoneId.systemDefault()).toInstant();
                    Instant nadirStart = bolusTime.plusSeconds(2 * 3600);
                    Instant nadirEnd = bolusTime.plusSeconds(4 * 3600);

                    OptionalDouble before = entries.stream()
                            .filter(e -> e.getSysTime() != null)
                            .filter(e -> parseInstant(e.getSysTime()).isBefore(bolusTime))
                            .mapToDouble(e -> e.getSgv().doubleValue())
                            .max();

                    OptionalDouble nadir = entries.stream()
                            .filter(e -> e.getSysTime() != null)
                            .filter(e -> {
                                Instant t = parseInstant(e.getSysTime());
                                return t.isAfter(nadirStart) && t.isBefore(nadirEnd);
                            })
                            .mapToDouble(e -> e.getSgv().doubleValue())
                            .min();

                    if (before.isPresent() && nadir.isPresent()) {
                        double drop = before.getAsDouble() - nadir.getAsDouble();
                        return java.util.stream.Stream.of(drop / bolus.getAmount());
                    }
                    return java.util.stream.Stream.empty();
                })
                .collect(Collectors.toList());

        return isfValues.stream().mapToDouble(Double::doubleValue).average().orElse(0.0);
    }

    // ─── Risk Indices ──────────────────────────────────────────────────────────

    /**
     * Low Blood Glucose Index (LBGI) — Kovatchev et al.
     * Higher values indicate greater hypoglycemia risk (> 2.5 = high risk).
     */
    public Double calculateLBGI(List<NightscoutEntryDTO> entries) {
        DescriptiveStatistics stats = new DescriptiveStatistics();
        for (NightscoutEntryDTO e : entries) {
            if (e.getSgv() != null && e.getSgv() > 0) {
                double f = 1.509 * (Math.pow(Math.log(e.getSgv()), 1.084) - 5.381);
                if (f < 0)
                    stats.addValue(10 * f * f);
            }
        }
        return stats.getN() > 0 ? stats.getMean() : 0.0;
    }

    /**
     * High Blood Glucose Index (HBGI) — Kovatchev et al.
     * Higher values indicate greater hyperglycemia risk (> 4.5 = high risk).
     */
    public Double calculateHBGI(List<NightscoutEntryDTO> entries) {
        DescriptiveStatistics stats = new DescriptiveStatistics();
        for (NightscoutEntryDTO e : entries) {
            if (e.getSgv() != null && e.getSgv() > 0) {
                double f = 1.509 * (Math.pow(Math.log(e.getSgv()), 1.084) - 5.381);
                if (f > 0)
                    stats.addValue(10 * f * f);
            }
        }
        return stats.getN() > 0 ? stats.getMean() : 0.0;
    }

    // ─── Helpers ───────────────────────────────────────────────────────────────

    private Instant parseInstant(String sysTime) {
        try {
            return Instant.parse(sysTime);
        } catch (Exception ex) {
            return Instant.EPOCH;
        }
    }
}
