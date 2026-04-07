package com.glucocoach.server.dto.response;

import com.glucocoach.server.domain.enums.NotifyVia;

import lombok.Data;

@Data
public class AlertResponse {
    private Long id;
    private Double thresholdLow;
    private Double thresholdHigh;
    private NotifyVia notifyVia;
    private boolean active;
    private Long userId;
}
