package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import java.util.Optional;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.glucocoach.server.domain.Profile;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.DiabetesType;
import com.glucocoach.server.domain.enums.GlucoseUnit;
import com.glucocoach.server.dto.request.ProfileRequest;
import com.glucocoach.server.dto.response.ProfileResponse;
import com.glucocoach.server.exception.AlreadyExistsException;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.ProfileMapper;
import com.glucocoach.server.repository.ProfileRepository;
import com.glucocoach.server.repository.UserRepository;

@ExtendWith(MockitoExtension.class)
public class ProfileServiceTest {

    @Mock
    private ProfileRepository profileRepository;

    @Mock
    private UserRepository userRepository;

    @Mock
    private ProfileMapper profileMapper;

    @InjectMocks
    private ProfileService profileService;

    private User user;
    private Profile profile;
    private ProfileRequest profileRequest;
    private ProfileResponse profileResponse;
    private final String userEmail = "john@example.com";

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email(userEmail)
                .firstName("John")
                .lastName("Doe")
                .build();

        profile = Profile.builder()
                .id(1L)
                .height(180L)
                .diabetesType(DiabetesType.TYPE_1)
                .glucoseUnit(GlucoseUnit.MG)
                .user(user)
                .build();

        profileRequest = new ProfileRequest();
        profileRequest.setHeight(180L);
        profileRequest.setDiabetesType(DiabetesType.TYPE_1);
        profileRequest.setGlucoseUnit(GlucoseUnit.MG);
        profileRequest.setPrescribedBasalDose(20L);

        profileResponse = new ProfileResponse();
        profileResponse.setId(1L);
        profileResponse.setHeight(180L);
        profileResponse.setUserId(user.getId());
    }

    @Test
    void create_shouldSaveProfile_whenNoneExists() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(profileRepository.existsByUserId(user.getId())).thenReturn(false);
        when(profileMapper.toEntity(profileRequest)).thenReturn(profile);
        when(profileRepository.save(any(Profile.class))).thenReturn(profile);
        when(profileMapper.toResponse(profile)).thenReturn(profileResponse);

        // Act
        ProfileResponse result = profileService.create(userEmail, profileRequest);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(profileRepository).save(any(Profile.class));
    }

    @Test
    void create_shouldThrowException_whenProfileAlreadyExists() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(profileRepository.existsByUserId(user.getId())).thenReturn(true);

        // Act & Assert
        assertThatThrownBy(() -> profileService.create(userEmail, profileRequest))
                .isInstanceOf(AlreadyExistsException.class);
        verify(profileRepository, never()).save(any());
    }

    @Test
    void get_shouldReturnProfile_whenExists() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(profileRepository.findByUserId(user.getId())).thenReturn(Optional.of(profile));
        when(profileMapper.toResponse(profile)).thenReturn(profileResponse);

        // Act
        ProfileResponse result = profileService.get(userEmail);

        // Assert
        assertThat(result).isNotNull();
        assertThat(result.getId()).isEqualTo(1L);
        verify(profileRepository).findByUserId(user.getId());
    }

    @Test
    void get_shouldThrowException_whenNotFound() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(profileRepository.findByUserId(user.getId())).thenReturn(Optional.empty());

        // Act & Assert
        assertThatThrownBy(() -> profileService.get(userEmail))
                .isInstanceOf(ResourceNotFoundException.class);
    }

    @Test
    void update_shouldUpdateExistingProfile() {
        // Arrange
        when(userRepository.findByEmail(userEmail)).thenReturn(Optional.of(user));
        when(profileRepository.findByUserId(user.getId())).thenReturn(Optional.of(profile));
        when(profileRepository.save(any(Profile.class))).thenReturn(profile);
        when(profileMapper.toResponse(profile)).thenReturn(profileResponse);

        // Act
        ProfileResponse result = profileService.update(userEmail, profileRequest);

        // Assert
        assertThat(result).isNotNull();
        verify(profileRepository).save(profile);
    }
}
