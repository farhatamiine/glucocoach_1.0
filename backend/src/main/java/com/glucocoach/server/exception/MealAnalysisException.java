package com.glucocoach.server.exception;

public class MealAnalysisException extends RuntimeException {

    public MealAnalysisException(String message) {
        super(message);
    }

    public MealAnalysisException(String message, Throwable cause) {
        super(message, cause);
    }
}
