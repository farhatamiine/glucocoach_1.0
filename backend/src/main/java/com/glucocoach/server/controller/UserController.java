package com.glucocoach.server.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ChangePasswordRequest;
import com.glucocoach.server.dto.request.UserRequest;
import com.glucocoach.server.dto.response.UserResponse;
import com.glucocoach.server.service.UserService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

// All endpoints here are protected — JwtAuthFilter runs first and puts the
// authenticated User object into the SecurityContext before this controller is called
@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    // ── GET /api/users/me ─────────────────────────────────────────────────────
    // @AuthenticationPrincipal injects the User object that JwtAuthFilter stored
    // in the SecurityContext — no need to manually call SecurityContextHolder
    // Returns 200 OK + UserResponse (no password, no internal fields)
    @GetMapping("/me")
    public ResponseEntity<UserResponse> getMe(@AuthenticationPrincipal User currentUser) {
        UserResponse response = userService.getMe(currentUser.getEmail());
        return ResponseEntity.ok(response);
    }

    // ── PUT /api/users/me ─────────────────────────────────────────────────────
    // Updates firstName, lastName, birthDate
    // @Valid validates the request body before the method runs
    // Returns 200 OK + updated UserResponse
    @PutMapping("/me")
    public ResponseEntity<UserResponse> updateMe(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody UserRequest request) {
        UserResponse response = userService.updateMe(currentUser.getEmail(), request);
        return ResponseEntity.ok(response);
    }

    // ── DELETE /api/users/me ──────────────────────────────────────────────────
    // Deletes the authenticated user's account
    // Returns 204 NO CONTENT — success with no body
    @DeleteMapping("/me")
    public ResponseEntity<Void> deleteMe(@AuthenticationPrincipal User currentUser) {
        userService.deleteMe(currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }

    // ── PUT /api/users/change-password ───────────────────────────────────────
    // Changes the password for the authenticated user
    @PutMapping("/change-password")
    public ResponseEntity<Void> changePassword(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody ChangePasswordRequest request) {
        userService.changePassword(currentUser.getEmail(), request);
        return ResponseEntity.noContent().build();
    }
}
