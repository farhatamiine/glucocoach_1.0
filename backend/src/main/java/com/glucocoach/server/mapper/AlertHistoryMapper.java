package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.dto.response.AlertHistoryResponse;

@Component
public class AlertHistoryMapper {

    // No toEntity — AlertHistory is created internally by the system, never by the user
    public AlertHistoryResponse toResponse(AlertHistory alertHistory) {
        AlertHistoryResponse response = new AlertHistoryResponse();
        response.setId(alertHistory.getId());
        response.setTriggeredAt(alertHistory.getTriggeredAt());
        response.setGlucoseValue(alertHistory.getGlucoseValue());
        response.setMessage(alertHistory.getMessage());
        response.setUserId(alertHistory.getUser().getId());
        return response;
    }
}
