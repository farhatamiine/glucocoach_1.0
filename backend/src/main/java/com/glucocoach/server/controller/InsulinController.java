package com.glucocoach.server.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.InsulinSummaryResponse;
import com.glucocoach.server.service.InsulinSummaryService;
import com.glucocoach.server.util.LocalDayUtil;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/insulin")
@RequiredArgsConstructor
public class InsulinController {

    private final InsulinSummaryService insulinSummaryService;

    @Operation(summary = "Insulin summary", description = "Aggregate insulin statistics computed from bolus "
            + "and basal entries over the last `days` local calendar days (in `tz`): average total daily "
            + "dose, basal/bolus split, correction vs meal bolus counts, and units per kg per day (null "
            + "when no weight is recorded in health-data). Raw numbers only.")
    @GetMapping("/summary")
    public ResponseEntity<InsulinSummaryResponse> summary(
            @AuthenticationPrincipal User currentUser,
            @RequestParam(defaultValue = "90") int days,
            @Parameter(description = "IANA timezone defining the local-day boundary")
            @RequestParam(defaultValue = "Europe/Paris") String tz) {
        return ResponseEntity.ok(
                insulinSummaryService.summarize(currentUser.getEmail(), days, LocalDayUtil.parseZone(tz)));
    }
}
