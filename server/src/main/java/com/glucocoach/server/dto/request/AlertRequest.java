package com.glucocoach.server.dto.request;

import com.glucocoach.server.domain.enums.NotifyVia;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class AlertRequest {

    @NotNull(message = "Low threshold is required")
    private Double thresholdLow;

    @NotNull(message = "High threshold is required")
    private Double thresholdHigh;

    @NotNull(message = "Notification method is required")
    private NotifyVia notifyVia;

    // Defaults to true — a newly created alert is active by default
    private boolean active = true;
}
