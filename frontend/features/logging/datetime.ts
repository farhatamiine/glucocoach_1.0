/** Helpers to bridge `<input type="datetime-local">` (local, no tz) ↔ backend ISO. */

/** ISO (or now) → "YYYY-MM-DDTHH:mm" in the user's local time, for datetime-local inputs. */
export function isoToLocalInput(iso?: string): string {
    const d = iso ? new Date(iso) : new Date();
    const local = new Date(d.getTime() - d.getTimezoneOffset() * 60_000);
    return local.toISOString().slice(0, 16);
}

/** "YYYY-MM-DDTHH:mm" (local) → full ISO date-time string for the backend. */
export function localInputToIso(local: string): string {
    return new Date(local).toISOString();
}
