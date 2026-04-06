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
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.service.MealService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/meals")
@RequiredArgsConstructor
public class MealController {

    private final MealService mealService;

    @GetMapping
    public ResponseEntity<List<MealResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(mealService.getAll(currentUser.getEmail()));
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
