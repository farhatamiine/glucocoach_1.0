package com.glucocoach.server.exception;

// Used when trying to create a resource that is unique per user (e.g. Profile)
// GlobalExceptionHandler maps this to HTTP 409 Conflict
public class AlreadyExistsException extends RuntimeException {
    public AlreadyExistsException(String message) {
        super(message);
    }
}
