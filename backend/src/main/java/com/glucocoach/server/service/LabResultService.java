package com.glucocoach.server.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.LabResult;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.LabResultType;
import com.glucocoach.server.dto.request.LabResultRequest;
import com.glucocoach.server.dto.response.LabResultResponse;
import com.glucocoach.server.exception.BadRequestException;
import com.glucocoach.server.mapper.LabResultMapper;
import com.glucocoach.server.repository.LabResultRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LabResultService {

    private final LabResultRepository labResultRepository;
    private final OwnershipValidator ownershipValidator;
    private final LabResultMapper labResultMapper;

    /**
     * Lab results newest-first, optionally filtered by analyte type and/or an
     * inclusive {@code [from, to]} date window.
     */
    public List<LabResultResponse> getAll(String email, LabResultType type, LocalDate from, LocalDate to) {
        User user = ownershipValidator.getCurrentUser(email);
        return labResultRepository.findByUserIdOrderByDateDesc(user.getId())
                .stream()
                .filter(r -> type == null || r.getType() == type)
                .filter(r -> from == null || !r.getDate().isBefore(from))
                .filter(r -> to == null || !r.getDate().isAfter(to))
                .map(labResultMapper::toResponse)
                .toList();
    }

    @Transactional
    public LabResultResponse create(LabResultRequest request, String email) {
        validateCustomName(request);
        User user = ownershipValidator.getCurrentUser(email);
        LabResult labResult = labResultMapper.toEntity(request);
        labResult.setUser(user);
        return labResultMapper.toResponse(labResultRepository.save(labResult));
    }

    @Transactional
    public LabResultResponse update(Long id, LabResultRequest request, String email) {
        validateCustomName(request);
        User user = ownershipValidator.getCurrentUser(email);
        LabResult labResult = ownershipValidator.validateOwnership(
                id, user.getId(), labResultRepository::findByIdAndUserId, "Lab result");

        labResult.setType(request.getType());
        labResult.setCustomName(request.getCustomName());
        labResult.setValue(request.getValue());
        labResult.setUnit(request.getUnit());
        labResult.setDate(request.getDate());
        labResult.setReferenceLow(request.getReferenceLow());
        labResult.setReferenceHigh(request.getReferenceHigh());
        labResult.setNote(request.getNote());

        return labResultMapper.toResponse(labResultRepository.save(labResult));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        LabResult labResult = ownershipValidator.validateOwnership(
                id, user.getId(), labResultRepository::findByIdAndUserId, "Lab result");
        labResultRepository.delete(labResult);
    }

    private void validateCustomName(LabResultRequest request) {
        if (request.getType() == LabResultType.CUSTOM
                && (request.getCustomName() == null || request.getCustomName().isBlank())) {
            throw new BadRequestException("customName is required when type is CUSTOM");
        }
    }
}
