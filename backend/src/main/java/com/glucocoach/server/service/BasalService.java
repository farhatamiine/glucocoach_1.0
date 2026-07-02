package com.glucocoach.server.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Basal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.BasalRequest;
import com.glucocoach.server.dto.response.BasalResponse;
import com.glucocoach.server.mapper.BasalMapper;
import com.glucocoach.server.repository.BasalRepository;
import com.glucocoach.server.util.LocalDayUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BasalService {

    private final BasalRepository basalRepository;
    private final OwnershipValidator ownershipValidator;
    private final BasalMapper basalMapper;

    public List<BasalResponse> getAll(String email) {
        return getAll(email, null, null, LocalDayUtil.DEFAULT_ZONE);
    }

    /**
     * Basal injections in the inclusive local-day window {@code [from, to]} (in {@code zone}).
     * Both bounds null → all entries (unchanged behavior); a single bound → open-ended.
     */
    public List<BasalResponse> getAll(String email, LocalDate from, LocalDate to, ZoneId zone) {
        User user = ownershipValidator.getCurrentUser(email);

        List<Basal> basals;
        if (from == null && to == null) {
            basals = basalRepository.findByUserIdOrderByInjectedAtDesc(user.getId());
        } else {
            LocalDateTime start = from != null ? LocalDayUtil.utcStartOfDay(from, zone) : LocalDayUtil.FAR_PAST;
            LocalDateTime end = to != null ? LocalDayUtil.utcEndOfDayExclusive(to, zone) : LocalDayUtil.FAR_FUTURE;
            basals = basalRepository
                    .findByUserIdAndInjectedAtGreaterThanEqualAndInjectedAtLessThanOrderByInjectedAtDesc(
                            user.getId(), start, end);
        }

        return basals.stream()
                .map(basalMapper::toResponse)
                .toList();
    }

    @Transactional
    public BasalResponse create(BasalRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Basal basal = basalMapper.toEntity(request);
        basal.setUser(user);
        return basalMapper.toResponse(basalRepository.save(basal));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Basal basal = ownershipValidator.validateOwnership(
                id, user.getId(), basalRepository::findByIdAndUserId, "Basal entry");
        basalRepository.delete(basal);
    }
}
