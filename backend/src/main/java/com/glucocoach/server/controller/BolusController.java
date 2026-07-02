package com.glucocoach.server.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.BolusRequest;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.service.BolusService;
import com.glucocoach.server.util.LocalDayUtil;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/bolus")
@RequiredArgsConstructor
public class BolusController {

    private final BolusService bolusService;

    @Operation(summary = "List boluses", description = "All boluses of the current user, newest first. "
            + "Optional from/to (inclusive, YYYY-MM-DD) restrict the list to full local days in tz; "
            + "from=to=<date> returns every bolus of that local day.")
    @GetMapping
    public ResponseEntity<List<BolusResponse>> getAll(
            @AuthenticationPrincipal User currentUser,
            @Parameter(description = "First local day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @Parameter(description = "Last local day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        return ResponseEntity.ok(
                bolusService.getAll(currentUser.getEmail(), from, to, LocalDayUtil.parseZone(tz)));
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
