package com.glucocoach.server.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.glucocoach.server.dto.response.NightscoutEntryDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NightScoutService {

    private final RestTemplate restTemplate;
    @Value("${nightscout-api-secret}")
    private String apiSecret;
    @Value("${nightscout-url}")
    private String nightscoutUrl;

    private List<NightscoutEntryDTO> fetchEntries(String url) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("api-secret", apiSecret);
        HttpEntity<Void> entity = new HttpEntity<>(headers);
        ResponseEntity<NightscoutEntryDTO[]> response = restTemplate.exchange(
                url,
                HttpMethod.GET,
                entity,
                NightscoutEntryDTO[].class);
        return response.getBody() != null ? Arrays.asList(response.getBody()) : Collections.emptyList();
    }

    public List<NightscoutEntryDTO> getEntries(int count) {
        String url = nightscoutUrl + "/api/v1/entries.json?count=" + count;
        return fetchEntries(url);
    }

    public List<NightscoutEntryDTO> getEntriesByDay(int days) {
        String from = LocalDate.now().minusDays(days).format(DateTimeFormatter.ISO_LOCAL_DATE);
        String url = nightscoutUrl + "/api/v1/entries.json"
                + "?find[dateString][$gte]=" + from
                + "&count=999999";
        return fetchEntries(url);
    }

}
