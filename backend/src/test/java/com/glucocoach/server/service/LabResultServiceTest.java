package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.time.LocalDate;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.LabResult;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.LabResultType;
import com.glucocoach.server.dto.request.LabResultRequest;
import com.glucocoach.server.dto.response.LabResultResponse;
import com.glucocoach.server.exception.BadRequestException;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.LabResultMapper;
import com.glucocoach.server.repository.LabResultRepository;

@ExtendWith(MockitoExtension.class)
class LabResultServiceTest {

    @Mock
    private LabResultRepository labResultRepository;

    @Mock
    private OwnershipValidator ownershipValidator;

    @Mock
    private LabResultMapper labResultMapper;

    @InjectMocks
    private LabResultService labResultService;

    private User user;
    private LabResult hba1c;
    private LabResult cholesterol;
    private final String userEmail = "john@example.com";

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email(userEmail)
                .firstName("John")
                .lastName("Doe")
                .birthDate(LocalDate.of(1990, 1, 1))
                .build();

        hba1c = LabResult.builder()
                .id(1L)
                .type(LabResultType.HBA1C)
                .value(6.5)
                .unit("%")
                .date(LocalDate.of(2026, 6, 1))
                .user(user)
                .build();

        cholesterol = LabResult.builder()
                .id(2L)
                .type(LabResultType.TOTAL_CHOLESTEROL)
                .value(1.8)
                .unit("g/L")
                .date(LocalDate.of(2026, 3, 1))
                .user(user)
                .build();
    }

    private LabResultResponse response(LabResult entity) {
        LabResultResponse r = new LabResultResponse();
        r.setId(entity.getId());
        r.setType(entity.getType());
        r.setValue(entity.getValue());
        r.setUnit(entity.getUnit());
        r.setDate(entity.getDate());
        r.setUserId(user.getId());
        return r;
    }

    // ── getAll ────────────────────────────────────────────────────────────────

    @Test
    void getAll_shouldReturnAll_whenNoFilters() {
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(labResultRepository.findByUserIdOrderByDateDesc(user.getId()))
                .thenReturn(List.of(hba1c, cholesterol));
        when(labResultMapper.toResponse(hba1c)).thenReturn(response(hba1c));
        when(labResultMapper.toResponse(cholesterol)).thenReturn(response(cholesterol));

        List<LabResultResponse> result = labResultService.getAll(userEmail, null, null, null);

        assertThat(result).hasSize(2);
    }

    @Test
    void getAll_shouldFilterByType() {
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(labResultRepository.findByUserIdOrderByDateDesc(user.getId()))
                .thenReturn(List.of(hba1c, cholesterol));
        when(labResultMapper.toResponse(hba1c)).thenReturn(response(hba1c));

        List<LabResultResponse> result = labResultService.getAll(userEmail, LabResultType.HBA1C, null, null);

        assertThat(result).hasSize(1);
        assertThat(result.get(0).getType()).isEqualTo(LabResultType.HBA1C);
    }

    @Test
    void getAll_shouldFilterByInclusiveDateWindow() {
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(labResultRepository.findByUserIdOrderByDateDesc(user.getId()))
                .thenReturn(List.of(hba1c, cholesterol));
        when(labResultMapper.toResponse(hba1c)).thenReturn(response(hba1c));

        // window exactly matching hba1c's date — inclusive on both ends
        List<LabResultResponse> result = labResultService.getAll(
                userEmail, null, LocalDate.of(2026, 6, 1), LocalDate.of(2026, 6, 1));

        assertThat(result).hasSize(1);
        assertThat(result.get(0).getId()).isEqualTo(1L);
    }

    // ── create ────────────────────────────────────────────────────────────────

    @Test
    void create_shouldSaveAndReturnResponse() {
        LabResultRequest request = new LabResultRequest();
        request.setType(LabResultType.HBA1C);
        request.setValue(6.5);
        request.setUnit("%");
        request.setDate(LocalDate.of(2026, 6, 1));

        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(labResultMapper.toEntity(request)).thenReturn(hba1c);
        when(labResultRepository.save(any(LabResult.class))).thenReturn(hba1c);
        when(labResultMapper.toResponse(hba1c)).thenReturn(response(hba1c));

        LabResultResponse result = labResultService.create(request, userEmail);

        assertThat(result.getId()).isEqualTo(1L);
        verify(labResultRepository).save(any(LabResult.class));
    }

    @Test
    void create_shouldThrowBadRequest_whenCustomWithoutCustomName() {
        LabResultRequest request = new LabResultRequest();
        request.setType(LabResultType.CUSTOM);
        request.setValue(12.0);
        request.setUnit("mg/L");
        request.setDate(LocalDate.of(2026, 6, 1));

        assertThatThrownBy(() -> labResultService.create(request, userEmail))
                .isInstanceOf(BadRequestException.class)
                .hasMessageContaining("customName");

        verify(labResultRepository, never()).save(any());
    }

    // ── update ────────────────────────────────────────────────────────────────

    @Test
    void update_shouldUpdateAllFields() {
        LabResultRequest request = new LabResultRequest();
        request.setType(LabResultType.CUSTOM);
        request.setCustomName("Ferritin");
        request.setValue(80.0);
        request.setUnit("µg/L");
        request.setDate(LocalDate.of(2026, 6, 15));
        request.setNote("fasting");

        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(ownershipValidator.validateOwnership(eq(1L), eq(user.getId()), any(), eq("Lab result")))
                .thenReturn(hba1c);
        when(labResultRepository.save(hba1c)).thenReturn(hba1c);
        when(labResultMapper.toResponse(hba1c)).thenReturn(response(hba1c));

        labResultService.update(1L, request, userEmail);

        assertThat(hba1c.getType()).isEqualTo(LabResultType.CUSTOM);
        assertThat(hba1c.getCustomName()).isEqualTo("Ferritin");
        assertThat(hba1c.getValue()).isEqualTo(80.0);
        assertThat(hba1c.getUnit()).isEqualTo("µg/L");
        assertThat(hba1c.getNote()).isEqualTo("fasting");
        verify(labResultRepository).save(hba1c);
    }

    // ── delete ────────────────────────────────────────────────────────────────

    @Test
    void delete_shouldRemoveLabResult_whenExists() {
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(ownershipValidator.validateOwnership(eq(1L), eq(user.getId()), any(), eq("Lab result")))
                .thenReturn(hba1c);

        labResultService.delete(1L, userEmail);

        verify(labResultRepository).delete(hba1c);
    }

    @Test
    void delete_shouldThrowException_whenDoesNotExist() {
        when(ownershipValidator.getCurrentUser(userEmail)).thenReturn(user);
        when(ownershipValidator.validateOwnership(eq(99L), eq(user.getId()), any(), eq("Lab result")))
                .thenThrow(new ResourceNotFoundException("Lab result not found with id: 99"));

        assertThatThrownBy(() -> labResultService.delete(99L, userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
        verify(labResultRepository, never()).delete(any(LabResult.class));
    }
}
