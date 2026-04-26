package com.glucocoach.server.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.dto.response.MealAnalysisResult;
import com.glucocoach.server.dto.response.MealResponse;
import com.glucocoach.server.exception.ResourceNotFoundException;
import com.glucocoach.server.mapper.MealMapper;
import com.glucocoach.server.repository.MealRepository;
import com.glucocoach.server.service.LlmMealAnalysisService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Slf4j
@RestController
@RequestMapping("/api/meals")
@RequiredArgsConstructor
public class MealImageController {

    private final MealRepository mealRepository;
    private final LlmMealAnalysisService llmMealAnalysisService;
    private final MealMapper mealMapper;
    private final ObjectMapper objectMapper;

    // Not added to SecurityConfig permitAll — JWT required
    @PostMapping("/{id}/image")
    public ResponseEntity<MealResponse> uploadImage(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file,
            @AuthenticationPrincipal User user) {

        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));

        byte[] fileBytes;
        try {
            fileBytes = file.getBytes();
        } catch (IOException e) {
            throw new RuntimeException("Failed to read uploaded file", e);
        }

        // Save to uploads/meals/{userId}/{uuid}.jpg (relative to working dir)
        // In Docker: working_dir=/app → resolves to /app/uploads/meals/... matching the volume mount
        Path dir = Paths.get("uploads", "meals", user.getId().toString());
        Path filePath;
        try {
            Files.createDirectories(dir);
            filePath = dir.resolve(UUID.randomUUID() + ".jpg");
            Files.write(filePath, fileBytes);
        } catch (IOException e) {
            throw new RuntimeException("Failed to store meal image file", e);
        }

        try {
            // imageUrl stores the local file path (not a URL) — for internal reference only.
            // If a public URL is needed, add a static resource mapping and store /uploads/... here.
            meal.setImageUrl(filePath.toString());

            MealAnalysisResult result = llmMealAnalysisService.analyze(fileBytes);

            meal.setAnalysisResult(objectMapper.writeValueAsString(result));
            meal.setEstimatedCarbs(result.estimatedCarbs());
            if (!StringUtils.hasText(meal.getName())) {
                meal.setName(result.name());
            }

            Meal saved = mealRepository.save(meal);
            log.info("Meal {} image uploaded and analyzed: estimatedCarbs={}, confidence={}",
                    id, result.estimatedCarbs(), result.confidence());

            return ResponseEntity.ok(mealMapper.toResponse(saved));
        } catch (Exception e) {
            // File was written — clean up the orphan before re-throwing
            try {
                Files.deleteIfExists(filePath);
            } catch (IOException deleteEx) {
                log.warn("Failed to clean up orphaned upload {}: {}", filePath, deleteEx.getMessage());
            }
            throw (e instanceof RuntimeException re) ? re : new RuntimeException(e);
        }
    }
}
