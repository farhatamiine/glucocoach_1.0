package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;

@Component
public class MealMapper {

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
        response.setImageUrl(meal.getImageUrl());
        response.setAnalysisResult(meal.getAnalysisResult());
        response.setEstimatedCarbs(meal.getEstimatedCarbs());
        return response;
    }
}
