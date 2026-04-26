package com.glucocoach.server.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.dto.response.MealAnalysisResult;
import com.glucocoach.server.exception.MealAnalysisException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Base64;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class LlmMealAnalysisService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;   // injected Spring-autoconfigured bean

    @Value("${app.llm.api-key}")
    private String apiKey;

    @Value("${app.llm.model:claude-opus-4-5}")
    private String model;

    private static final String ANTHROPIC_URL     = "https://api.anthropic.com/v1/messages";
    private static final String ANTHROPIC_VERSION = "2023-06-01";
    private static final String PROMPT =
            "Analyze this meal photo. Return ONLY valid JSON, no markdown. " +
            "Keys: name(string), estimatedCarbs(number grams), ingredients(string[]), " +
            "confidence(low|medium|high)";

    public MealAnalysisResult analyze(byte[] imageBytes) {
        try {
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);

            Map<String, Object> requestBody = Map.of(
                    "model", model,
                    "max_tokens", 512,
                    "messages", List.of(Map.of(
                            "role", "user",
                            "content", List.of(
                                    Map.of("type", "image",
                                            "source", Map.of(
                                                    "type", "base64",
                                                    // Hardcoded to JPEG — MealImageController always writes .jpg before calling this method.
                                                    // To support PNG/WebP, accept a mimeType parameter here and pass it from the controller.
                                                    "media_type", "image/jpeg",
                                                    "data", base64Image)),
                                    Map.of("type", "text", "text", PROMPT)
                            )
                    ))
            );

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.set("x-api-key", apiKey);
            headers.set("anthropic-version", ANTHROPIC_VERSION);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
            String responseBody = restTemplate.postForObject(ANTHROPIC_URL, entity, String.class);

            JsonNode root = objectMapper.readTree(responseBody);
            JsonNode contentArray = root.path("content");
            if (contentArray.isEmpty()) {
                throw new MealAnalysisException("Anthropic response missing content array: " + responseBody);
            }
            String rawText = contentArray.get(0).path("text").asText();

            // Strip markdown fences the LLM occasionally adds despite prompt instructions
            String jsonText = rawText.replaceAll("(?s)```json\\s*|```\\s*", "").trim();

            MealAnalysisResult result = objectMapper.readValue(jsonText, MealAnalysisResult.class);
            log.info("LLM analysis complete: name={}, carbs={}, confidence={}",
                    result.name(), result.estimatedCarbs(), result.confidence());
            return result;

        } catch (Exception e) {
            throw new MealAnalysisException("Failed to analyze meal image: " + e.getMessage(), e);
        }
    }
}
