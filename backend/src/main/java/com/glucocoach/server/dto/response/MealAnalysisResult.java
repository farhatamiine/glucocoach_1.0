package com.glucocoach.server.dto.response;

import java.util.List;

public record MealAnalysisResult(
        String name,
        Double estimatedCarbs,
        List<String> ingredients,
        String confidence          // "low" | "medium" | "high"
) {}
