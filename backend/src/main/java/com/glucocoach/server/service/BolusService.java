package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Bolus;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.BolusRequest;
import com.glucocoach.server.dto.response.BolusResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.BolusMapper;
import com.glucocoach.server.repository.BolusRepository;
import com.glucocoach.server.repository.MealRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BolusService {

    private final BolusRepository bolusRepository;
    private final MealRepository mealRepository;
    private final OwnershipValidator ownershipValidator;
    private final BolusMapper bolusMapper;

    public List<BolusResponse> getAll(String email) {
        User user = ownershipValidator.getCurrentUser(email);
        return bolusRepository.findByUserIdOrderByTimestampDesc(user.getId())
                .stream()
                .map(bolusMapper::toResponse)
                .toList();
    }

    @Transactional
    public BolusResponse create(BolusRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Bolus bolus = bolusMapper.toEntity(request);
        bolus.setUser(user);

        // If a mealId is provided, load and verify the meal belongs to this user
        if (request.getMealId() != null) {
            Meal meal = mealRepository.findByIdAndUserId(request.getMealId(), user.getId())
                    .orElseThrow(() -> new ResourceNotFoundException(
                            "Meal not found with id: " + request.getMealId()));
            bolus.setMeal(meal);
        }

        return bolusMapper.toResponse(bolusRepository.save(bolus));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Bolus bolus = ownershipValidator.validateOwnership(
                id, user.getId(), bolusRepository::findByIdAndUserId, "Bolus entry");
        bolusRepository.delete(bolus);
    }
}
