package com.glucocoach.server.exception;

import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

// ResponseEntityExceptionHandler already handles many Spring MVC exceptions internally.
// For exceptions it already owns (like MethodArgumentNotValidException), we must
// OVERRIDE its protected method — NOT add a new @ExceptionHandler for the same type.
// Adding a second @ExceptionHandler causes the "Ambiguous handler" startup crash.
@ControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {

        @ExceptionHandler(Exception.class)
        public ResponseEntity<ErrorResponse> handleAllException(Exception ex, WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.INTERNAL_SERVER_ERROR.value())
                                .timestamp(Instant.now())
                                .error("Internal Server Error")
                                .message("An unexpected error occurred")
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
        }

        @ExceptionHandler(ResourceNotFoundException.class)
        public ResponseEntity<ErrorResponse> handleResourceNotFoundException(ResourceNotFoundException ex,
                        WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.NOT_FOUND.value())
                                .timestamp(Instant.now())
                                .error("Not Found")
                                .message(ex.getMessage())
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(error);
        }

        @ExceptionHandler(AlreadyExistsException.class)
        public ResponseEntity<ErrorResponse> handleAlreadyExistsException(AlreadyExistsException ex,
                        WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.CONFLICT.value())
                                .timestamp(Instant.now())
                                .error("Conflict")
                                .message(ex.getMessage())
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
        }

        @ExceptionHandler(DuplicateEmailException.class)
        public ResponseEntity<ErrorResponse> handleDuplicateEmailException(DuplicateEmailException ex,
                        WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.CONFLICT.value())
                                .timestamp(Instant.now())
                                .error("Conflict")
                                .message(ex.getMessage())
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.CONFLICT).body(error);
        }

        @ExceptionHandler(UnauthorizedException.class)
        public ResponseEntity<ErrorResponse> handleUnauthorizedException(UnauthorizedException ex, WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.UNAUTHORIZED.value())
                                .timestamp(Instant.now())
                                .error("Unauthorized")
                                .message(ex.getMessage())
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
        }

        // ResponseEntityExceptionHandler already "owns" MethodArgumentNotValidException.
        // We must OVERRIDE its protected hook method instead of declaring a new @ExceptionHandler.
        // The parent calls this method internally whenever validation fails.
        @Override
        protected ResponseEntity<Object> handleMethodArgumentNotValid(
                        MethodArgumentNotValidException ex,
                        HttpHeaders headers,
                        HttpStatusCode status,
                        WebRequest request) {

                Map<String, String> fields = new HashMap<>();
                ex.getBindingResult()
                                .getFieldErrors()
                                .forEach(err -> fields.put(err.getField(), err.getDefaultMessage()));

                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.BAD_REQUEST.value())
                                .timestamp(Instant.now())
                                .error("Validation Failed")
                                .fieldErrors(fields)
                                .message("One or more fields have validation errors")
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();

                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(error);
        }

}
