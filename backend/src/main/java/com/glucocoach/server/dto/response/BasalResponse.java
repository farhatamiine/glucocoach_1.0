package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class BasalResponse {
    private Long id;
    private Double amount;
    private LocalDateTime injectedAt;
    private Long userId;
}
