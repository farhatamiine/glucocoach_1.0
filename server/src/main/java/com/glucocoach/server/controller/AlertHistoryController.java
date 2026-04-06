package com.glucocoach.server.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.AlertHistoryResponse;
import com.glucocoach.server.service.AlertHistoryService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/alert-history")
@RequiredArgsConstructor
public class AlertHistoryController {

    private final AlertHistoryService alertHistoryService;

    // Read-only — history is written by the system, never by the user
    @GetMapping
    public ResponseEntity<List<AlertHistoryResponse>> getAll(@AuthenticationPrincipal User currentUser) {
        return ResponseEntity.ok(alertHistoryService.getAll(currentUser.getEmail()));
    }
}
