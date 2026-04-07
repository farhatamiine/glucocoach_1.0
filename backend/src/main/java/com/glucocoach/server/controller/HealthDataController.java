package com.glucocoach.server.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.HealthDataRequest;
import com.glucocoach.server.dto.response.HealthDataResponse;
import com.glucocoach.server.service.HealthDataService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/health-data")
@RequiredArgsConstructor
public class HealthDataController {

    private final HealthDataService healthDataService;

    @GetMapping
    public ResponseEntity<List<HealthDataResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(healthDataService.getAll(currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<HealthDataResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody HealthDataRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(healthDataService.create(request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        healthDataService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
