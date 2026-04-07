package com.glucocoach.server.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;
import com.glucocoach.server.service.AlertService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/alerts")
@RequiredArgsConstructor
public class AlertController {

    private final AlertService alertService;

    @GetMapping
    public ResponseEntity<List<AlertResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(alertService.getAll(currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<AlertResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody AlertRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(alertService.create(request, currentUser.getEmail()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<AlertResponse> update(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id,
            @Valid @RequestBody AlertRequest request) {
        return ResponseEntity.ok(alertService.update(id, request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        alertService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
