package com.glucocoach.server.service;

import java.net.URI;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.HexFormat;
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

    private List<NightscoutEntryDTO> fetchEntries(URI uri) {
        HttpHeaders headers = new HttpHeaders();
        if (apiSecret != null && !apiSecret.isBlank()) {
            headers.set("api-secret", sha1(apiSecret));
        }

        HttpEntity<Void> entity = new HttpEntity<>(headers);

        ResponseEntity<NightscoutEntryDTO[]> response = restTemplate.exchange(
                uri,
                HttpMethod.GET,
                entity,
                NightscoutEntryDTO[].class);
        return response.getBody() != null ? Arrays.asList(response.getBody()) : Collections.emptyList();
    }

    public List<NightscoutEntryDTO> getEntries(int count) {
        String url = nightscoutUrl + "/api/v1/entries.json?count=" + count;
        return fetchEntries(URI.create(url));
    }

    /**
     * Entries whose Nightscout {@code date} (epoch millis) falls in
     * {@code [from, toExclusive)}. Epoch comparison is timezone-safe, unlike
     * the string-compared {@code dateString} used by {@link #getEntriesByDay}.
     */
    public List<NightscoutEntryDTO> getEntriesBetween(Instant from, Instant toExclusive) {
        String url = nightscoutUrl + "/api/v1/entries.json"
                + "?find[date][$gte]=" + from.toEpochMilli()
                + "&find[date][$lt]=" + toExclusive.toEpochMilli()
                + "&count=999999";
        return fetchEntries(URI.create(url));
    }

    public List<NightscoutEntryDTO> getEntriesByDay(int days) {
        String from = LocalDate.now().minusDays(days).format(DateTimeFormatter.ISO_LOCAL_DATE);
        String url = nightscoutUrl + "/api/v1/entries.json"
                + "?find[dateString][$gte]=" + from
                + "&count=999999";
        return fetchEntries(URI.create(url));
    }

    private String sha1(String input) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-1");
            byte[] hash = digest.digest(input.getBytes(StandardCharsets.UTF_8));
            return HexFormat.of().formatHex(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("SHA-1 algorithm not found", e);
        }
    }

}
