package com.glucocoach.server.service;

import java.util.Optional;
import java.util.function.BiFunction;

import org.springframework.stereotype.Component;

import com.glucocoach.server.domain.OwnedEntity;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.repository.UserRepository;

import lombok.RequiredArgsConstructor;

/**
 * Centralizes user-ownership validation across all domain services.
 *
 * <p>Eliminates the duplicated {@code getUser(String email)} helper and the
 * repeated {@code findByIdAndUserId(...).orElseThrow(...)} pattern that existed
 * in 8+ service classes.</p>
 *
 * <p>Usage:</p>
 * <pre>
 *   User user = ownershipValidator.getCurrentUser(email);
 *   Meal meal = ownershipValidator.validateOwnership(
 *       id, user.getId(), mealRepository::findByIdAndUserId, "Meal");
 * </pre>
 */
@Component
@RequiredArgsConstructor
public class OwnershipValidator {

    private final UserRepository userRepository;

    /**
     * Resolves the currently authenticated user from their email.
     *
     * @throws ResourceNotFoundException if no user exists for the given email
     */
    public User getCurrentUser(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));
    }

    /**
     * Verifies that an entity with the given ID belongs to the specified user.
     *
     * @param entityId        the entity primary key
     * @param userId          the expected owner
     * @param ownershipFinder repository method reference, e.g. {@code repo::findByIdAndUserId}
     * @param entityName      human-readable name used in the exception message
     * @return the verified entity
     * @throws ResourceNotFoundException if the entity does not exist or does not belong to the user
     */
    public <T extends OwnedEntity> T validateOwnership(
            Long entityId,
            Long userId,
            BiFunction<Long, Long, Optional<T>> ownershipFinder,
            String entityName) {

        return ownershipFinder.apply(entityId, userId)
                .orElseThrow(() -> new ResourceNotFoundException(
                        entityName + " not found with id: " + entityId));
    }
}
