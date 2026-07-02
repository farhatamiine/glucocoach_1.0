package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.domain.Bolus;
import com.glucocoach.server.domain.HealthData;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.BolusType;
import com.glucocoach.server.dto.response.InsulinSummaryResponse;
import com.glucocoach.server.repository.BasalRepository;
import com.glucocoach.server.repository.BolusRepository;
import com.glucocoach.server.repository.HealthDataRepository;

@ExtendWith(MockitoExtension.class)
class InsulinSummaryServiceTest {

    private static final ZoneId PARIS = ZoneId.of("Europe/Paris");

    @Mock
    private BolusRepository bolusRepository;

    @Mock
    private BasalRepository basalRepository;

    @Mock
    private HealthDataRepository healthDataRepository;

    @Mock
    private OwnershipValidator ownershipValidator;

    @InjectMocks
    private InsulinSummaryService insulinSummaryService;

    private User user;
    private final String userEmail = "john@example.com";

    @BeforeEach
    void setUp() {
        user = User.builder().id(1L).email(userEmail).build();
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
    }

    private static Bolus bolus(double amount, BolusType type) {
        return Bolus.builder().amount(amount).bolusType(type).timestamp(LocalDateTime.now()).build();
    }

    private static Basal basal(double amount) {
        return Basal.builder().amount(amount).injectedAt(LocalDateTime.now()).build();
    }

    @Test
    void summarize_shouldComputeAveragesSplitsAndCounts() {
        // 10 days: 200 bolus units (140 meal + 60 correction), 220 basal units
        when(bolusRepository
                .findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(
                        bolus(140.0, BolusType.MEAL),
                        bolus(60.0, BolusType.CORRECTION)));
        when(basalRepository
                .findByUserIdAndInjectedAtGreaterThanEqualAndInjectedAtLessThanOrderByInjectedAtDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(basal(120.0), basal(100.0)));
        when(healthDataRepository.findFirstByUserIdAndWeightIsNotNullOrderByDateDesc(1L))
                .thenReturn(Optional.of(HealthData.builder()
                        .weight(70.0).date(LocalDate.now()).build()));

        InsulinSummaryResponse summary = insulinSummaryService.summarize(userEmail, 10, PARIS);

        assertThat(summary.getDays()).isEqualTo(10);
        assertThat(summary.getBolusUnitsAvg()).isEqualTo(20.0);
        assertThat(summary.getBasalUnitsAvg()).isEqualTo(22.0);
        assertThat(summary.getTotalDailyDoseAvg()).isEqualTo(42.0);
        assertThat(summary.getBasalPct()).isEqualTo(52.4);   // 220/420
        assertThat(summary.getBolusPct()).isEqualTo(47.6);   // 200/420
        assertThat(summary.getCorrectionBolusCount()).isEqualTo(1);
        assertThat(summary.getMealBolusCount()).isEqualTo(1);
        assertThat(summary.getCorrectionUnitsPct()).isEqualTo(30.0); // 60/200
        assertThat(summary.getUnitsPerKgPerDay()).isEqualTo(0.6);    // 42/70
    }

    @Test
    void summarize_shouldReturnNullUnitsPerKg_whenNoWeightRecorded() {
        when(bolusRepository
                .findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(bolus(10.0, BolusType.MEAL)));
        when(basalRepository
                .findByUserIdAndInjectedAtGreaterThanEqualAndInjectedAtLessThanOrderByInjectedAtDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of());
        when(healthDataRepository.findFirstByUserIdAndWeightIsNotNullOrderByDateDesc(1L))
                .thenReturn(Optional.empty());

        InsulinSummaryResponse summary = insulinSummaryService.summarize(userEmail, 10, PARIS);

        assertThat(summary.getUnitsPerKgPerDay()).isNull();
        assertThat(summary.getBolusPct()).isEqualTo(100.0);
        assertThat(summary.getBasalPct()).isEqualTo(0.0);
    }

    @Test
    void summarize_shouldReturnZeros_whenNoInsulinLogged() {
        when(bolusRepository
                .findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of());
        when(basalRepository
                .findByUserIdAndInjectedAtGreaterThanEqualAndInjectedAtLessThanOrderByInjectedAtDesc(
                        eq(1L), any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of());
        when(healthDataRepository.findFirstByUserIdAndWeightIsNotNullOrderByDateDesc(1L))
                .thenReturn(Optional.empty());

        InsulinSummaryResponse summary = insulinSummaryService.summarize(userEmail, 90, PARIS);

        assertThat(summary.getTotalDailyDoseAvg()).isEqualTo(0.0);
        assertThat(summary.getBasalPct()).isEqualTo(0.0);
        assertThat(summary.getBolusPct()).isEqualTo(0.0);
        assertThat(summary.getCorrectionUnitsPct()).isEqualTo(0.0);
        assertThat(summary.getCorrectionBolusCount()).isEqualTo(0);
        assertThat(summary.getMealBolusCount()).isEqualTo(0);
        assertThat(summary.getUnitsPerKgPerDay()).isNull();
    }
}
