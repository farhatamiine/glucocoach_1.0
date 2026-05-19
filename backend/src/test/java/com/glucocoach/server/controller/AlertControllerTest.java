package com.glucocoach.server.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.dto.request.AlertRequest;
import com.glucocoach.server.dto.response.AlertResponse;
import com.glucocoach.server.service.AlertService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.time.LocalDate;
import java.util.List;

import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class AlertControllerTest {

    @Mock
    private AlertService alertService;

    @InjectMocks
    private AlertController alertController;

    private MockMvc mockMvc;
    private ObjectMapper objectMapper;
    private User testUser;

    @BeforeEach
    void setUp() {
        testUser = User.builder()
                .id(1L)
                .email("test@example.com")
                .firstName("John")
                .lastName("Doe")
                .birthDate(LocalDate.of(1990, 1, 1))
                .password("secret")
                .build();

        mockMvc = MockMvcBuilders.standaloneSetup(alertController)
                .setCustomArgumentResolvers(new AuthenticationPrincipalResolver(testUser))
                .build();
        objectMapper = new ObjectMapper();
    }

    @Test
    void getAll_shouldReturnListOfAlerts() throws Exception {
        AlertResponse response = new AlertResponse();
        response.setId(1L);
        response.setThresholdLow(70.0);
        response.setThresholdHigh(180.0);
        response.setNotifyVia(NotifyVia.PUSH);
        response.setActive(true);
        response.setUserId(1L);

        when(alertService.getAll(testUser.getEmail())).thenReturn(List.of(response));

        mockMvc.perform(get("/api/alerts"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].id").value(1))
                .andExpect(jsonPath("$[0].thresholdLow").value(70.0))
                .andExpect(jsonPath("$[0].thresholdHigh").value(180.0));
    }

    @Test
    void create_shouldReturnCreatedAlert() throws Exception {
        AlertRequest request = new AlertRequest();
        request.setThresholdLow(70.0);
        request.setThresholdHigh(180.0);
        request.setNotifyVia(NotifyVia.PUSH);
        request.setActive(true);

        AlertResponse response = new AlertResponse();
        response.setId(1L);
        response.setThresholdLow(70.0);
        response.setThresholdHigh(180.0);
        response.setNotifyVia(NotifyVia.PUSH);
        response.setActive(true);
        response.setUserId(1L);

        when(alertService.create(any(AlertRequest.class), eq(testUser.getEmail()))).thenReturn(response);

        mockMvc.perform(post("/api/alerts")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.id").value(1))
                .andExpect(jsonPath("$.thresholdLow").value(70.0));
    }

    @Test
    void update_shouldReturnUpdatedAlert() throws Exception {
        AlertRequest request = new AlertRequest();
        request.setThresholdLow(80.0);
        request.setThresholdHigh(200.0);
        request.setNotifyVia(NotifyVia.EMAIL);
        request.setActive(false);

        AlertResponse response = new AlertResponse();
        response.setId(1L);
        response.setThresholdLow(80.0);
        response.setThresholdHigh(200.0);
        response.setNotifyVia(NotifyVia.EMAIL);
        response.setActive(false);
        response.setUserId(1L);

        when(alertService.update(eq(1L), any(AlertRequest.class), eq(testUser.getEmail()))).thenReturn(response);

        mockMvc.perform(put("/api/alerts/1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(request)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.thresholdLow").value(80.0))
                .andExpect(jsonPath("$.active").value(false));
    }

    @Test
    void delete_shouldReturnNoContent() throws Exception {
        doNothing().when(alertService).delete(1L, testUser.getEmail());

        mockMvc.perform(delete("/api/alerts/1"))
                .andExpect(status().isNoContent());

        verify(alertService).delete(1L, testUser.getEmail());
    }

    /**
     * Resolves @AuthenticationPrincipal parameters to the provided test user.
     */
    record AuthenticationPrincipalResolver(User principal) implements HandlerMethodArgumentResolver {
        @Override
        public boolean supportsParameter(MethodParameter parameter) {
            return parameter.getParameterAnnotation(AuthenticationPrincipal.class) != null;
        }

        @Override
        public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
                                      NativeWebRequest webRequest, WebDataBinderFactory binderFactory) {
            return principal;
        }
    }
}
