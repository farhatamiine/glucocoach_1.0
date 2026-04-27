package com.glucocoach.server.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.dto.response.MealAnalysisResult;
import com.glucocoach.server.exception.MealAnalysisException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpStatus;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class LlmMealAnalysisServiceTest {

    @Mock
    private RestTemplate restTemplate;

    private LlmMealAnalysisService service;

    @BeforeEach
    void setUp() {
        // Construct with a real ObjectMapper so Jackson parsing is exercised end-to-end
        service = new LlmMealAnalysisService(restTemplate, new ObjectMapper());
        ReflectionTestUtils.setField(service, "apiKey", "test-api-key");
        ReflectionTestUtils.setField(service, "model", "claude-opus-4-5");
    }

    @Test
    void analyze_shouldReturnParsedResult_whenResponseIsValid() {
        String anthropicResponse = """
                {
                  "content": [
                    {
                      "type": "text",
                      "text": "{\\"name\\": \\"Pasta\\", \\"estimatedCarbs\\": 45.5, \\"ingredients\\": [\\"pasta\\", \\"tomato sauce\\"], \\"confidence\\": \\"high\\"}"
                    }
                  ]
                }
                """;

        when(restTemplate.postForObject(anyString(), any(HttpEntity.class), eq(String.class)))
                .thenReturn(anthropicResponse);

        MealAnalysisResult result = service.analyze("fake-image".getBytes());

        assertThat(result.name()).isEqualTo("Pasta");
        assertThat(result.estimatedCarbs()).isEqualTo(45.5);
        assertThat(result.ingredients()).containsExactly("pasta", "tomato sauce");
        assertThat(result.confidence()).isEqualTo("high");
    }

    @Test
    void analyze_shouldThrowMealAnalysisException_whenApiReturnsHttpError() {
        when(restTemplate.postForObject(anyString(), any(HttpEntity.class), eq(String.class)))
                .thenThrow(new HttpClientErrorException(HttpStatus.UNAUTHORIZED));

        assertThatThrownBy(() -> service.analyze("fake-image".getBytes()))
                .isInstanceOf(MealAnalysisException.class)
                .hasMessageContaining("Meal image analysis failed");
    }

    @Test
    void analyze_shouldThrowMealAnalysisException_whenResponseJsonIsMalformed() {
        String malformedResponse = """
                {
                  "content": [
                    {
                      "type": "text",
                      "text": "this is not valid json at all"
                    }
                  ]
                }
                """;

        when(restTemplate.postForObject(anyString(), any(HttpEntity.class), eq(String.class)))
                .thenReturn(malformedResponse);

        assertThatThrownBy(() -> service.analyze("fake-image".getBytes()))
                .isInstanceOf(MealAnalysisException.class)
                .hasMessageContaining("Meal image analysis failed");
    }
}
