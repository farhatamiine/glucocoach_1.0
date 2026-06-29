/** Helpers to bridge `<input type="datetime-local">` (local, no tz) ↔ backend ISO. */

/**
 * Parse a backend date-time string into a Date.
 *
 * The backend serializes timestamps without a timezone designator (Spring
 * `LocalDateTime`, e.g. "2026-06-29T14:52:58"). `new Date()` would interpret
 * those as *local* time and shift them by the viewer's UTC offset (a fresh entry
 * shows up as "2 h ago" in UTC+2). The values are actually UTC, so we append `Z`
 * when no offset is present. A string that already carries `Z` or `±HH:MM` is
 * parsed as-is.
 */
export function parseBackendDate(s: string): Date {
    const hasTz = /(Z|[+-]\d{2}:?\d{2})$/.test(s);
    return new Date(hasTz ? s : `${s}Z`);
}

/** ISO (or now) → "YYYY-MM-DDTHH:mm" in the user's local time, for datetime-local inputs. */
export function isoToLocalInput(iso?: string): string {
    const d = iso ? parseBackendDate(iso) : new Date();
    const local = new Date(d.getTime() - d.getTimezoneOffset() * 60_000);
    return local.toISOString().slice(0, 16);
}

/** "YYYY-MM-DDTHH:mm" (local) → full ISO date-time string for the backend. */
export function localInputToIso(local: string): string {
    return new Date(local).toISOString();
}

/** True when a backend timestamp falls on the same local calendar day as `day`. */
export function isSameLocalDay(iso: string, day: Date): boolean {
    const d = parseBackendDate(iso);
    return (
        d.getFullYear() === day.getFullYear() &&
        d.getMonth() === day.getMonth() &&
        d.getDate() === day.getDate()
    );
}
