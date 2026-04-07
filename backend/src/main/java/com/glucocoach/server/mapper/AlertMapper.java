package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;

@Component
public class AlertMapper {

    public Alert toEntity(AlertRequest request) {
        return Alert.builder()
                .thresholdLow(request.getThresholdLow())
                .thresholdHigh(request.getThresholdHigh())
                .notifyVia(request.getNotifyVia())
                .active(request.isActive())
                .build();
    }

    public AlertResponse toResponse(Alert alert) {
        AlertResponse response = new AlertResponse();
        response.setId(alert.getId());
        response.setThresholdLow(alert.getThresholdLow());
        response.setThresholdHigh(alert.getThresholdHigh());
        response.setNotifyVia(alert.getNotifyVia());
        response.setActive(alert.isActive());
        response.setUserId(alert.getUser().getId());
        return response;
    }
}
