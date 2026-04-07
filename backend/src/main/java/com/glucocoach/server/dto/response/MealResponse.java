package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class MealResponse {
    private Long id;
    private String name;
    private Double carbs;
    private LocalDateTime timestamp;
    private Long userId;
}
