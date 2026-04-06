package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AlertHistoryResponse {
    private Long id;
    private LocalDateTime triggeredAt;
    private Double glucoseValue;
    private String message;
    private Long userId;
}
