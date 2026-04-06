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
import com.glucocoach.server.dto.request.BasalRequest;
import com.glucocoach.server.dto.response.BasalResponse;
import com.glucocoach.server.service.BasalService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/basal")
@RequiredArgsConstructor
public class BasalController {

    private final BasalService basalService;

    @GetMapping
    public ResponseEntity<List<BasalResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(basalService.getAll(currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<BasalResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody BasalRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(basalService.create(request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        basalService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
