package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.dto.request.BasalRequest;
import com.glucocoach.server.dto.response.BasalResponse;

@Component
public class BasalMapper {

    public Basal toEntity(BasalRequest request) {
        return Basal.builder()
                .amount(request.getAmount())
                .injectedAt(request.getInjectedAt())
                .build();
    }

    public BasalResponse toResponse(Basal basal) {
        BasalResponse response = new BasalResponse();
        response.setId(basal.getId());
        response.setAmount(basal.getAmount());
        response.setInjectedAt(basal.getInjectedAt());
        response.setUserId(basal.getUser().getId());
        return response;
    }
}
