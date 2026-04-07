package com.glucocoach.server.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.ProfileRequest;
import com.glucocoach.server.dto.response.ProfileResponse;
import com.glucocoach.server.service.ProfileService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/profile")
@RequiredArgsConstructor
public class UserProfileController {

    private final ProfileService profileService;

    // POST /api/profile — create profile for the authenticated user (one-time)
    @PostMapping
    public ResponseEntity<ProfileResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody ProfileRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(profileService.create(currentUser.getEmail(), request));
    }

    // GET /api/profile — get the authenticated user's profile
    @GetMapping
    public ResponseEntity<ProfileResponse> get(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(profileService.get(currentUser.getEmail()));
    }

    // PUT /api/profile — update the authenticated user's profile
    @PutMapping
    public ResponseEntity<ProfileResponse> update(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody ProfileRequest request) {
        return ResponseEntity.ok(profileService.update(currentUser.getEmail(), request));
    }
}
