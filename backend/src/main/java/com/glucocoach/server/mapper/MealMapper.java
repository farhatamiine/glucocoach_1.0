package com.glucocoach.server.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealAnalysisResult;
import com.glucocoach.server.dto.response.MealResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class MealMapper {

    private final ObjectMapper objectMapper;

    public Meal toEntity(MealRequest request) {
        return Meal.builder()
                .name(request.getName())
                .carbs(request.getCarbs())
                .timestamp(request.getTimestamp())
                .build();
    }

    public MealResponse toResponse(Meal meal) {
        MealResponse response = new MealResponse();
        response.setId(meal.getId());
        response.setName(meal.getName());
        response.setCarbs(meal.getCarbs());
        response.setTimestamp(meal.getTimestamp());
        response.setUserId(meal.getUser().getId());
        response.setEstimatedCarbs(meal.getEstimatedCarbs());
        if (meal.getAnalysisResult() != null) {
            try {
                response.setAnalysis(objectMapper.readValue(meal.getAnalysisResult(), MealAnalysisResult.class));
            } catch (JsonProcessingException e) {
                log.warn("Could not deserialize analysisResult for meal {}: {}", meal.getId(), e.getMessage());
            }
        }
        return response;
    }
}
