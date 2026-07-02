package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.LabResult;
import com.glucocoach.server.dto.request.LabResultRequest;
import com.glucocoach.server.dto.response.LabResultResponse;

@Component
public class LabResultMapper {

    public LabResult toEntity(LabResultRequest request) {
        return LabResult.builder()
                .type(request.getType())
                .customName(request.getCustomName())
                .value(request.getValue())
                .unit(request.getUnit())
                .date(request.getDate())
                .referenceLow(request.getReferenceLow())
                .referenceHigh(request.getReferenceHigh())
                .note(request.getNote())
                .build();
    }

    public LabResultResponse toResponse(LabResult labResult) {
        LabResultResponse response = new LabResultResponse();
        response.setId(labResult.getId());
        response.setType(labResult.getType());
        response.setCustomName(labResult.getCustomName());
        response.setValue(labResult.getValue());
        response.setUnit(labResult.getUnit());
        response.setDate(labResult.getDate());
        response.setReferenceLow(labResult.getReferenceLow());
        response.setReferenceHigh(labResult.getReferenceHigh());
        response.setNote(labResult.getNote());
        response.setUserId(labResult.getUser().getId());
        return response;
    }
}
