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
import com.glucocoach.server.dto.request.LaboAnalysisRequest;
import com.glucocoach.server.dto.response.LaboAnalysisResponse;
import com.glucocoach.server.service.LaboAnalysisService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/labo")
@RequiredArgsConstructor
public class LaboAnalysisController {

    private final LaboAnalysisService laboAnalysisService;

    @GetMapping
    public ResponseEntity<List<LaboAnalysisResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(laboAnalysisService.getAll(currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<LaboAnalysisResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody LaboAnalysisRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(laboAnalysisService.create(request, currentUser.getEmail()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<LaboAnalysisResponse> update(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id,
            @Valid @RequestBody LaboAnalysisRequest request) {
        return ResponseEntity.ok(laboAnalysisService.update(id, request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        laboAnalysisService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
