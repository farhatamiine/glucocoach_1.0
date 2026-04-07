package com.glucocoach.server.exception;

// Same pattern as ResourceNotFoundException — extends RuntimeException (unchecked).
// Used when a user tries to register with an email that already exists in the DB.
//
// Usage in UserService:
//   if (userRepository.existsByEmail(request.getEmail())) {
//       throw new DuplicateEmailException("Email already in use: " + request.getEmail());
//   }
public class UnauthorizedException extends RuntimeException {

    public UnauthorizedException(String message) {
        super(message);
    }
}
