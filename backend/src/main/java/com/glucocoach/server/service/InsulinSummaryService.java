package com.glucocoach.server.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

import org.springframework.stereotype.Service;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.domain.Bolus;
import com.glucocoach.server.domain.HealthData;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.BolusType;
import com.glucocoach.server.dto.response.InsulinSummaryResponse;
import com.glucocoach.server.repository.BasalRepository;
import com.glucocoach.server.repository.BolusRepository;
import com.glucocoach.server.repository.HealthDataRepository;
import com.glucocoach.server.util.LocalDayUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class InsulinSummaryService {

    private final BolusRepository bolusRepository;
    private final BasalRepository basalRepository;
    private final HealthDataRepository healthDataRepository;
    private final OwnershipValidator ownershipValidator;

    /**
     * Aggregates bolus + basal entries over the last {@code days} local calendar
     * days (including today, in {@code zone}). Daily averages divide total units
     * by {@code days}, so days without entries count as zero-dose days.
     */
    public InsulinSummaryResponse summarize(String email, int days, ZoneId zone) {
        User user = ownershipValidator.getCurrentUser(email);

        LocalDate today = LocalDate.now(zone);
        LocalDateTime start = LocalDayUtil.utcStartOfDay(today.minusDays(days - 1L), zone);
        LocalDateTime end = LocalDayUtil.utcEndOfDayExclusive(today, zone);

        List<Bolus> boluses = bolusRepository
                .findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
                        user.getId(), start, end);
        List<Basal> basals = basalRepository
                .findByUserIdAndInjectedAtGreaterThanEqualAndInjectedAtLessThanOrderByInjectedAtDesc(
                        user.getId(), start, end);

        double bolusUnits = boluses.stream()
                .filter(b -> b.getAmount() != null)
                .mapToDouble(Bolus::getAmount)
                .sum();
        double basalUnits = basals.stream()
                .filter(b -> b.getAmount() != null)
                .mapToDouble(Basal::getAmount)
                .sum();
        double totalUnits = bolusUnits + basalUnits;

        double correctionUnits = boluses.stream()
                .filter(b -> b.getBolusType() == BolusType.CORRECTION && b.getAmount() != null)
                .mapToDouble(Bolus::getAmount)
                .sum();
        long correctionBolusCount = boluses.stream()
                .filter(b -> b.getBolusType() == BolusType.CORRECTION)
                .count();
        long mealBolusCount = boluses.stream()
                .filter(b -> b.getBolusType() == BolusType.MEAL)
                .count();

        double basalUnitsAvg = basalUnits / days;
        double bolusUnitsAvg = bolusUnits / days;
        double totalDailyDoseAvg = totalUnits / days;

        Double weight = healthDataRepository
                .findFirstByUserIdAndWeightIsNotNullOrderByDateDesc(user.getId())
                .map(HealthData::getWeight)
                .orElse(null);
        Double unitsPerKgPerDay = (weight != null && weight > 0)
                ? round2(totalDailyDoseAvg / weight)
                : null;

        return InsulinSummaryResponse.builder()
                .days(days)
                .totalDailyDoseAvg(round1(totalDailyDoseAvg))
                .basalUnitsAvg(round1(basalUnitsAvg))
                .bolusUnitsAvg(round1(bolusUnitsAvg))
                .basalPct(totalUnits > 0 ? round1(basalUnits / totalUnits * 100) : 0.0)
                .bolusPct(totalUnits > 0 ? round1(bolusUnits / totalUnits * 100) : 0.0)
                .correctionBolusCount(correctionBolusCount)
                .mealBolusCount(mealBolusCount)
                .correctionUnitsPct(bolusUnits > 0 ? round1(correctionUnits / bolusUnits * 100) : 0.0)
                .unitsPerKgPerDay(unitsPerKgPerDay)
                .build();
    }

    private static double round1(double value) {
        return Math.round(value * 10.0) / 10.0;
    }

    private static double round2(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
}
