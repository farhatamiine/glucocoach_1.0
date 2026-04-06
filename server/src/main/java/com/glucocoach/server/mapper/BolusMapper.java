package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.Bolus;
import com.glucocoach.server.dto.request.BolusRequest;
import com.glucocoach.server.dto.response.BolusResponse;

@Component
public class BolusMapper {

    // NOTE: meal and user are NOT set here — the service sets them after loading
    // the entities from the DB to ensure ownership validation happens in one place
    public Bolus toEntity(BolusRequest request) {
        return Bolus.builder()
                .amount(request.getAmount())
                .bolusType(request.getBolusType())
                .timestamp(request.getTimestamp())
                .build();
    }

    public BolusResponse toResponse(Bolus bolus) {
        BolusResponse response = new BolusResponse();
        response.setId(bolus.getId());
        response.setAmount(bolus.getAmount());
        response.setBolusType(bolus.getBolusType());
        response.setTimestamp(bolus.getTimestamp());
        response.setUserId(bolus.getUser().getId());
        // mealId is null for CORRECTION bolus — @JsonInclude(NON_NULL) hides it
        if (bolus.getMeal() != null) {
            response.setMealId(bolus.getMeal().getId());
        }
        return response;
    }
}
