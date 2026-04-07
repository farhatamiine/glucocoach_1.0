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
import com.glucocoach.server.dto.request.BolusRequest;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.service.BolusService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/bolus")
@RequiredArgsConstructor
public class BolusController {

    private final BolusService bolusService;

    @GetMapping
    public ResponseEntity<List<BolusResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(bolusService.getAll(currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<BolusResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody BolusRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(bolusService.create(request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        bolusService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
