package com.glucocoach.server.controller;

import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.LabResultType;
import com.glucocoach.server.dto.request.LabResultRequest;
import com.glucocoach.server.dto.response.LabAnalyteResponse;
import com.glucocoach.server.dto.response.LabResultResponse;
import com.glucocoach.server.service.LabResultService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

/**
 * Lab results — one measurement per row. Replaces the old fixed-column
 * LaboAnalysis API (hba1c/cholesterol/triglycerides per row); existing rows
 * are migrated at startup, one LabResult per non-null column.
 */
@RestController
@RequestMapping("/api/labo")
@RequiredArgsConstructor
public class LabResultController {

    private final LabResultService labResultService;

    @Operation(summary = "List lab results", description = "Lab results of the current user, newest first. "
            + "Optional filters: analyte `type`, and an inclusive `from`/`to` date window (YYYY-MM-DD).")
    @GetMapping
    public ResponseEntity<List<LabResultResponse>> getAll(
            @AuthenticationPrincipal User currentUser,
            @Parameter(description = "Analyte type filter")
            @RequestParam(required = false) LabResultType type,
            @Parameter(description = "First day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @Parameter(description = "Last day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to) {
        return ResponseEntity.ok(labResultService.getAll(currentUser.getEmail(), type, from, to));
    }

    @Operation(summary = "Analyte catalog", description = "Supported analytes with display name, "
            + "France-typical default unit, category, and informational reference bounds — for the add form.")
    @GetMapping("/analytes")
    public ResponseEntity<List<LabAnalyteResponse>> analytes() {
        return ResponseEntity.ok(Arrays.stream(LabResultType.values())
                .map(LabAnalyteResponse::from)
                .toList());
    }

    @Operation(summary = "Create a lab result", description = "One measurement. customName is required "
            + "when type is CUSTOM (400 otherwise).")
    @PostMapping
    public ResponseEntity<LabResultResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody LabResultRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(labResultService.create(request, currentUser.getEmail()));
    }

    @Operation(summary = "Update a lab result")
    @PutMapping("/{id}")
    public ResponseEntity<LabResultResponse> update(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id,
            @Valid @RequestBody LabResultRequest request) {
        return ResponseEntity.ok(labResultService.update(id, request, currentUser.getEmail()));
    }

    @Operation(summary = "Delete a lab result")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        labResultService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
