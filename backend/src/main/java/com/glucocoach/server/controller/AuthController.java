package com.glucocoach.server.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.dto.request.ForgetPasswordRequest;
import com.glucocoach.server.dto.request.LoginRequest;
import com.glucocoach.server.dto.request.RefreshRequest;
import com.glucocoach.server.dto.request.RegisterRequest;
import com.glucocoach.server.dto.request.ResetPasswordRequest;
import com.glucocoach.server.dto.response.AuthResponse;
import com.glucocoach.server.service.AuthService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

// @RestController = @Controller + @ResponseBody
//   Every method return value is serialized to JSON automatically
// @RequestMapping sets the base URL for all endpoints in this class
@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    // ── POST /api/auth/register ───────────────────────────────────────────────
    // Public endpoint — no JWT needed
    // @Valid triggers validation annotations on RegisterRequest (@NotBlank, @Email, @Size)
    //   → if validation fails, Spring throws MethodArgumentNotValidException
    //   → caught by GlobalExceptionHandler → returns 400 with field errors map
    // Returns 201 CREATED + tokens so the client is immediately logged in after registration
    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest request) {
        AuthResponse response = authService.register(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    // ── POST /api/auth/login ──────────────────────────────────────────────────
    // Public endpoint — no JWT needed
    // Returns 200 OK + { accessToken, refreshToken, tokenType }
    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        AuthResponse response = authService.login(request);
        return ResponseEntity.ok(response);
    }

    // ── POST /api/auth/refresh ────────────────────────────────────────────────
    // Public endpoint — the client sends the refresh token to get a new access token
    // Body: { "refreshToken": "eyJ..." }
    // Returns 200 OK + new { accessToken, refreshToken }
    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest request) {
        AuthResponse response = authService.refresh(request);
        return ResponseEntity.ok(response);
    }

    // ── POST /api/auth/logout ─────────────────────────────────────────────────
    // Client sends their refresh token — it is deleted from the DB
    // The access token expires naturally (we don't blacklist it — stateless design)
    // Returns 204 NO CONTENT — success with no body
    @PostMapping("/logout")
    public ResponseEntity<Void> logout(@Valid @RequestBody RefreshRequest request) {
        authService.logout(request);
        return ResponseEntity.noContent().build();
    }

    // ── POST /api/auth/forget-password ────────────────────────────────────────
    // Public endpoint — sends (returns) a reset token to the user's email
    @PostMapping("/forget-password")
    public ResponseEntity<String> forgetPassword(@Valid @RequestBody ForgetPasswordRequest request) {
        String token = authService.forgetPassword(request);
        return ResponseEntity.ok("Reset token: " + token);
    }

    // ── POST /api/auth/reset-password ─────────────────────────────────────────
    // Public endpoint — resets the password using the token
    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        authService.resetPassword(request);
        return ResponseEntity.ok("Password reset successfully");
    }
}
