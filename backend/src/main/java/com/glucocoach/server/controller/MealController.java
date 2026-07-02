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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.service.MealService;
import com.glucocoach.server.util.LocalDayUtil;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/meals")
@RequiredArgsConstructor
public class MealController {

    private final MealService mealService;

    @Operation(summary = "List meals", description = "All meals of the current user, newest first. "
            + "Optional from/to (inclusive, YYYY-MM-DD) restrict the list to full local days in tz; "
            + "from=to=<date> returns every meal of that local day.")
    @GetMapping
    public ResponseEntity<List<MealResponse>> getAll(
            @AuthenticationPrincipal User currentUser,
            @Parameter(description = "First local day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate from,
            @Parameter(description = "Last local day, inclusive (YYYY-MM-DD)")
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate to,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        return ResponseEntity.ok(
                mealService.getAll(currentUser.getEmail(), from, to, LocalDayUtil.parseZone(tz)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<MealResponse> getById(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        return ResponseEntity.ok(mealService.getById(id, currentUser.getEmail()));
    }

    @PostMapping
    public ResponseEntity<MealResponse> create(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody MealRequest request) {
        return ResponseEntity
                .status(HttpStatus.CREATED)
                .body(mealService.create(request, currentUser.getEmail()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<MealResponse> update(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id,
            @Valid @RequestBody MealRequest request) {
        return ResponseEntity.ok(mealService.update(id, request, currentUser.getEmail()));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long id) {
        mealService.delete(id, currentUser.getEmail());
        return ResponseEntity.noContent().build();
    }
}
