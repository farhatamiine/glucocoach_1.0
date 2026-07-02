package com.glucocoach.server.util;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;

import org.junit.jupiter.api.Test;

import com.glucocoach.server.exception.BadRequestException;

class LocalDayUtilTest {

    private static final ZoneId PARIS = ZoneId.of("Europe/Paris");

    @Test
    void parseZone_shouldAcceptValidIanaId() {
        assertThat(LocalDayUtil.parseZone("Europe/Paris")).isEqualTo(PARIS);
    }

    @Test
    void parseZone_shouldRejectInvalidId() {
        assertThatThrownBy(() -> LocalDayUtil.parseZone("Not/AZone"))
                .isInstanceOf(BadRequestException.class);
    }

    @Test
    void utcWindow_shouldShiftBySummerOffset() {
        // Paris is UTC+2 on June 24 → the local day starts at 22:00 UTC the day before
        LocalDate day = LocalDate.of(2026, 6, 24);

        assertThat(LocalDayUtil.utcStartOfDay(day, PARIS))
                .isEqualTo(LocalDateTime.of(2026, 6, 23, 22, 0));
        assertThat(LocalDayUtil.utcEndOfDayExclusive(day, PARIS))
                .isEqualTo(LocalDateTime.of(2026, 6, 24, 22, 0));
    }

    @Test
    void utcWindow_shouldShiftByWinterOffset() {
        // Paris is UTC+1 on January 15
        LocalDate day = LocalDate.of(2026, 1, 15);

        assertThat(LocalDayUtil.utcStartOfDay(day, PARIS))
                .isEqualTo(LocalDateTime.of(2026, 1, 14, 23, 0));
        assertThat(LocalDayUtil.utcEndOfDayExclusive(day, PARIS))
                .isEqualTo(LocalDateTime.of(2026, 1, 15, 23, 0));
    }

    @Test
    void instantWindow_shouldCoverExactlyOneLocalDay() {
        LocalDate day = LocalDate.of(2026, 6, 24);

        Instant start = LocalDayUtil.startOfDayInstant(day, PARIS);
        Instant end = LocalDayUtil.endOfDayInstantExclusive(day, PARIS);

        assertThat(start).isEqualTo(Instant.parse("2026-06-23T22:00:00Z"));
        assertThat(end).isEqualTo(Instant.parse("2026-06-24T22:00:00Z"));
    }
}
