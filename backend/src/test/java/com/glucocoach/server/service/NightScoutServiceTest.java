package com.glucocoach.server.service;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

import java.net.URI;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.test.util.ReflectionTestUtils;
import org.springframework.web.client.RestTemplate;

import com.glucocoach.server.dto.response.NightscoutEntryDTO;

@ExtendWith(MockitoExtension.class)
class NightScoutServiceTest {

    @Mock
    private RestTemplate restTemplate;

    @InjectMocks
    private NightScoutService nightScoutService;

    @BeforeEach
    void setUp() {
        ReflectionTestUtils.setField(nightScoutService, "nightscoutUrl", "http://test.com");
    }

    @Test
    void getEntries_WhenNoApiSecret_ShouldNotIncludeHeader() {
        ReflectionTestUtils.setField(nightScoutService, "apiSecret", null);

        NightscoutEntryDTO[] responseArray = new NightscoutEntryDTO[0];
        when(restTemplate.exchange(any(URI.class), eq(HttpMethod.GET), any(HttpEntity.class), eq(NightscoutEntryDTO[].class)))
                .thenReturn(ResponseEntity.ok(responseArray));

        nightScoutService.getEntries(1);

        ArgumentCaptor<HttpEntity> entityCaptor = ArgumentCaptor.forClass(HttpEntity.class);
        verify(restTemplate).exchange(any(URI.class), eq(HttpMethod.GET), entityCaptor.capture(), eq(NightscoutEntryDTO[].class));

        assertThat(entityCaptor.getValue().getHeaders().get("api-secret")).isNull();
    }

    @Test
    void getEntries_WhenApiSecretProvided_ShouldIncludeHashedHeader() {
        ReflectionTestUtils.setField(nightScoutService, "apiSecret", "secret123");

        NightscoutEntryDTO[] responseArray = new NightscoutEntryDTO[0];
        when(restTemplate.exchange(any(URI.class), eq(HttpMethod.GET), any(HttpEntity.class), eq(NightscoutEntryDTO[].class)))
                .thenReturn(ResponseEntity.ok(responseArray));

        nightScoutService.getEntries(1);

        ArgumentCaptor<HttpEntity> entityCaptor = ArgumentCaptor.forClass(HttpEntity.class);
        verify(restTemplate).exchange(any(URI.class), eq(HttpMethod.GET), entityCaptor.capture(), eq(NightscoutEntryDTO[].class));

        // SHA-1 of "secret123" is f2b14f68eb995facb3a1c35287b778d5bd785511
        assertThat(entityCaptor.getValue().getHeaders().getFirst("api-secret")).isEqualTo("f2b14f68eb995facb3a1c35287b778d5bd785511");
    }
}
