package com.glucocoach.server.domain;

/**
 * Marker interface for entities that belong to a specific {@link User}.
 * Enables centralized ownership validation via {@link com.glucocoach.server.service.OwnershipValidator}.
 */
public interface OwnedEntity {

    /**
     * Returns the owning user. Must never return {@code null} for persisted entities.
     */
    User getUser();
}
