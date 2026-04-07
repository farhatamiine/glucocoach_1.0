package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.LaboAnalysis;
import com.glucocoach.server.dto.request.LaboAnalysisRequest;
import com.glucocoach.server.dto.response.LaboAnalysisResponse;

@Component
public class LaboAnalysisMapper {

    public LaboAnalysis toEntity(LaboAnalysisRequest request) {
        return LaboAnalysis.builder()
                .hba1c(request.getHba1c())
                .cholesterol(request.getCholesterol())
                .triglycerides(request.getTriglycerides())
                .date(request.getDate())
                .build();
    }

    public LaboAnalysisResponse toResponse(LaboAnalysis labo) {
        LaboAnalysisResponse response = new LaboAnalysisResponse();
        response.setId(labo.getId());
        response.setHba1c(labo.getHba1c());
        response.setCholesterol(labo.getCholesterol());
        response.setTriglycerides(labo.getTriglycerides());
        response.setDate(labo.getDate());
        response.setUserId(labo.getUser().getId());
        return response;
    }
}
