package com.glucocoach.server.exception;

// ─────────────────────────────────────────────────────────────────────────────
// WHY extends RuntimeException?
//   Java has two kinds of exceptions:
//   • Checked   → must be declared in method signature (throws XYZ) or caught.
//   • Unchecked → extends RuntimeException — NO need to declare or catch them.
//
//   In Spring REST APIs we always use RuntimeException so that:
//   1. Services don't have ugly "throws" on every method signature.
//   2. Spring can intercept them automatically via @ExceptionHandler.
// ─────────────────────────────────────────────────────────────────────────────
public class ResourceNotFoundException extends RuntimeException {

    // ── Constructor 1 ────────────────────────────────────────────────────────
    // Accepts a plain message, e.g.:
    // throw new ResourceNotFoundException("User not found with id: " + id);
    //
    // super(message) → passes the message up to RuntimeException so that
    // e.getMessage() returns it later (used in GlobalExceptionHandler).
    public ResourceNotFoundException(String message) {
        super(message);
    }

    // ── Constructor 2 (optional but useful) ──────────────────────────────────
    // Accepts a message AND the original cause (another exception).
    // Useful when you catch a low-level exception and want to wrap it:
    // throw new ResourceNotFoundException("User not found", originalException);
    //
    // This preserves the original stack trace for debugging.
    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }
}
