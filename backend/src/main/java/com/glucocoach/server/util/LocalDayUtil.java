package com.glucocoach.server.util;

import java.time.DateTimeException;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZoneOffset;

import com.glucocoach.server.exception.BadRequestException;

/**
 * Local-calendar-day boundary helpers.
 *
 * <p>All per-day bucketing (tirByDay, daily summaries, date-window filtering)
 * must share the same local-day boundary. The boundary is defined by an IANA
 * timezone supplied per request ({@code tz} query param, default Europe/Paris).</p>
 *
 * <p>Entity date-times ({@code Bolus.timestamp}, {@code Basal.injectedAt},
 * {@code Meal.timestamp}) are bare {@link LocalDateTime}s holding UTC wall-clock
 * values — the client submits {@code Date.toISOString()} and re-appends "Z" when
 * reading. Local-day windows therefore have to be converted to UTC before being
 * compared against stored values.</p>
 */
public final class LocalDayUtil {

    /** Default local-day boundary when no {@code tz} query param is supplied. */
    public static final ZoneId DEFAULT_ZONE = ZoneId.of("Europe/Paris");

    /** Open-ended window sentinels — safe for a Postgres {@code timestamp} column. */
    public static final LocalDateTime FAR_PAST = LocalDateTime.of(1970, 1, 1, 0, 0);
    public static final LocalDateTime FAR_FUTURE = LocalDateTime.of(3000, 1, 1, 0, 0);

    private LocalDayUtil() {
    }

    /**
     * Parses an IANA timezone id.
     *
     * @throws BadRequestException when the id is unknown (→ HTTP 400)
     */
    public static ZoneId parseZone(String tz) {
        try {
            return ZoneId.of(tz);
        } catch (DateTimeException ex) {
            throw new BadRequestException("Invalid IANA timezone id: " + tz);
        }
    }

    /** Instant at which {@code day} starts in {@code zone}. */
    public static Instant startOfDayInstant(LocalDate day, ZoneId zone) {
        return day.atStartOfDay(zone).toInstant();
    }

    /** Instant at which the day after {@code day} starts in {@code zone} (exclusive bound). */
    public static Instant endOfDayInstantExclusive(LocalDate day, ZoneId zone) {
        return day.plusDays(1).atStartOfDay(zone).toInstant();
    }

    /** Start of the local day expressed as a UTC wall-clock {@link LocalDateTime}. */
    public static LocalDateTime utcStartOfDay(LocalDate day, ZoneId zone) {
        return LocalDateTime.ofInstant(startOfDayInstant(day, zone), ZoneOffset.UTC);
    }

    /** Exclusive end of the local day expressed as a UTC wall-clock {@link LocalDateTime}. */
    public static LocalDateTime utcEndOfDayExclusive(LocalDate day, ZoneId zone) {
        return LocalDateTime.ofInstant(endOfDayInstantExclusive(day, zone), ZoneOffset.UTC);
    }
}
