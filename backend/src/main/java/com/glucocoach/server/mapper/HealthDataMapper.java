package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.HealthData;
import com.glucocoach.server.dto.request.HealthDataRequest;
import com.glucocoach.server.dto.response.HealthDataResponse;

@Component
public class HealthDataMapper {

    public HealthData toEntity(HealthDataRequest request) {
        return HealthData.builder()
                .weight(request.getWeight())
                .heartRate(request.getHeartRate())
                .bloodPressure(request.getBloodPressure())
                .date(request.getDate())
                .build();
    }

    public HealthDataResponse toResponse(HealthData healthData) {
        HealthDataResponse response = new HealthDataResponse();
        response.setId(healthData.getId());
        response.setWeight(healthData.getWeight());
        response.setHeartRate(healthData.getHeartRate());
        response.setBloodPressure(healthData.getBloodPressure());
        response.setDate(healthData.getDate());
        response.setUserId(healthData.getUser().getId());
        return response;
    }
}
