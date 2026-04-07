package com.glucocoach.server.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.MealMapper;
import com.glucocoach.server.repository.MealRepository;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MealService {

    private final MealRepository mealRepository;
    private final UserRepository userRepository;
    private final MealMapper mealMapper;

    public List<MealResponse> getAll(String email) {
        User user = getUser(email);
        return mealRepository.findByUserIdOrderByTimestampDesc(user.getId())
                .stream()
                .map(mealMapper::toResponse)
                .toList();
    }

    public MealResponse getById(Long id, String email) {
        User user = getUser(email);
        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));
        return mealMapper.toResponse(meal);
    }

    @Transactional
    public MealResponse create(MealRequest request, String email) {
        User user = getUser(email);
        Meal meal = mealMapper.toEntity(request);
        meal.setUser(user);
        return mealMapper.toResponse(mealRepository.save(meal));
    }

    @Transactional
    public MealResponse update(Long id, MealRequest request, String email) {
        User user = getUser(email);
        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));

        meal.setName(request.getName());
        meal.setCarbs(request.getCarbs());
        meal.setTimestamp(request.getTimestamp());

        return mealMapper.toResponse(mealRepository.save(meal));
    }

    @Transactional
    public void delete(Long id, String email) {
        User user = getUser(email);
        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));
        mealRepository.delete(meal);
    }

    private User getUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }
}
