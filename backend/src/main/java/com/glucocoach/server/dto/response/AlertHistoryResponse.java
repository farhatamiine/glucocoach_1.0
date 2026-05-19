package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;

import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;

import lombok.Data;

@Data
public class AlertHistoryResponse {
    private Long id;
    private LocalDateTime triggeredAt;
    private Double glucoseValue;
    private String message;
    private AlertDirection direction;
    private NotifyVia notifyVia;
    private Long userId;
}
