package com.glucocoach.server.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.glucocoach.server.domain.Meal;

@Repository
public interface MealRepository extends JpaRepository<Meal, Long> {
    List<Meal> findByUserIdOrderByTimestampDesc(Long userId);
    Optional<Meal> findByIdAndUserId(Long id, Long userId);
}
