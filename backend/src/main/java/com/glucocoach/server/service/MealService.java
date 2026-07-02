package com.glucocoach.server.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.mapper.MealMapper;
import com.glucocoach.server.repository.MealRepository;
import com.glucocoach.server.util.LocalDayUtil;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MealService {

    private final MealRepository mealRepository;
    private final OwnershipValidator ownershipValidator;
    private final MealMapper mealMapper;

    public List<MealResponse> getAll(String email) {
        return getAll(email, null, null, LocalDayUtil.DEFAULT_ZONE);
    }

    /**
     * Meals in the inclusive local-day window {@code [from, to]} (in {@code zone}).
     * Both bounds null → all entries (unchanged behavior); a single bound → open-ended.
     */
    public List<MealResponse> getAll(String email, LocalDate from, LocalDate to, ZoneId zone) {
        User user = ownershipValidator.getCurrentUser(email);

        List<Meal> meals;
        if (from == null && to == null) {
            meals = mealRepository.findByUserIdOrderByTimestampDesc(user.getId());
        } else {
            LocalDateTime start = from != null ? LocalDayUtil.utcStartOfDay(from, zone) : LocalDayUtil.FAR_PAST;
            LocalDateTime end = to != null ? LocalDayUtil.utcEndOfDayExclusive(to, zone) : LocalDayUtil.FAR_FUTURE;
            meals = mealRepository
                    .findByUserIdAndTimestampGreaterThanEqualAndTimestampLessThanOrderByTimestampDesc(
                            user.getId(), start, end);
        }

        return meals.stream()
                .map(mealMapper::toResponse)
                .toList();
    }

    public MealResponse getById(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Meal meal = ownershipValidator.validateOwnership(
                id, user.getId(), mealRepository::findByIdAndUserId, "Meal");
        return mealMapper.toResponse(meal);
    }

    @Transactional
    public MealResponse create(MealRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Meal meal = mealMapper.toEntity(request);
        meal.setUser(user);
        return mealMapper.toResponse(mealRepository.save(meal));
    }

    @Transactional
    public MealResponse update(Long id, MealRequest request, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Meal meal = ownershipValidator.validateOwnership(
                id, user.getId(), mealRepository::findByIdAndUserId, "Meal");

        meal.setName(request.getName());
        meal.setCarbs(request.getCarbs());
        meal.setTimestamp(request.getTimestamp());

        return mealMapper.toResponse(mealRepository.save(meal));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = ownershipValidator.getCurrentUser(email);
        Meal meal = ownershipValidator.validateOwnership(
                id, user.getId(), mealRepository::findByIdAndUserId, "Meal");
        mealRepository.delete(meal);
    }
}
