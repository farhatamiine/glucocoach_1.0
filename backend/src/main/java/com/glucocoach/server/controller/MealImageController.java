package com.glucocoach.server.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;

@Slf4j
@RestController
@RequestMapping("/api/meals")
@RequiredArgsConstructor
public class MealImageController {

    private final MealRepository mealRepository;
    private final LlmMealAnalysisService llmMealAnalysisService;
    private final MealMapper mealMapper;
    private final ObjectMapper objectMapper;

    @Value("${app.upload.max-size-bytes:10485760}")
    private long maxSizeBytes;

    // Not added to SecurityConfig permitAll — JWT required
    @PostMapping("/{id}/image")
    public ResponseEntity<MealResponse> uploadImage(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file,
            @AuthenticationPrincipal User user) {

        if (!"image/jpeg".equals(file.getContentType())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "Only JPEG images are accepted (received: " + file.getContentType() + ")");
        }
        if (file.getSize() > maxSizeBytes) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST,
                    "File exceeds maximum allowed size of " + maxSizeBytes + " bytes");
        }

        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));

        byte[] fileBytes;
        try {
            fileBytes = file.getBytes();
        } catch (IOException e) {
            throw new RuntimeException("Failed to read uploaded file", e);
        }

        // Image bytes are used only for analysis — not persisted to disk or object storage.
        MealAnalysisResult result = llmMealAnalysisService.analyze(fileBytes);

        try {
            meal.setAnalysisResult(objectMapper.writeValueAsString(result));
        } catch (JsonProcessingException e) {
            throw new RuntimeException("Failed to serialize analysis result", e);
        }
        meal.setEstimatedCarbs(result.estimatedCarbs());
        if (!StringUtils.hasText(meal.getName())) {
            meal.setName(result.name());
        }

        Meal saved = mealRepository.save(meal);
        log.info("Meal {} analyzed: estimatedCarbs={}, confidence={}",
                id, result.estimatedCarbs(), result.confidence());

        return ResponseEntity.ok(mealMapper.toResponse(saved));
    }
}
