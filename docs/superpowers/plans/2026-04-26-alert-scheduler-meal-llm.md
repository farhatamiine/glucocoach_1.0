# Alert Scheduler & Meal LLM Analysis — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement scheduled FCM push notifications for glucose threshold alerts (Phase 1) and LLM-powered meal photo analysis via the Anthropic API (Phase 2).

**Architecture:** Phase 1 adds a `@Scheduled` component that polls active alerts, fetches the latest SGV from Nightscout once per user, and routes PUSH/EMAIL/SMS notifications; FCM is conditionally configured so CI works with zero credentials. Phase 2 adds a multipart upload endpoint that writes the image to `uploads/`, calls the Anthropic Messages API with a base64-encoded image, and updates the meal record with the LLM analysis result. Phase 1 and Phase 2 are independent and can be executed or stopped separately.

**Tech Stack:** Spring Boot 4 / Java 21, Firebase Admin SDK 9.3.0, Anthropic Messages API (`claude-opus-4-5`), RestTemplate, Jackson `ObjectMapper`, Spring `@Scheduled`, Lombok, JPA/Hibernate, Mockito + AssertJ.

---

## File Map

### Phase 1 — New files
| File | Purpose |
|------|---------|
| `backend/src/main/java/com/glucocoach/server/domain/enums/AlertDirection.java` | LOW / HIGH enum |
| `backend/src/main/java/com/glucocoach/server/dto/request/FcmTokenRequest.java` | PATCH body DTO |
| `backend/src/main/java/com/glucocoach/server/config/FcmConfig.java` | Conditional Firebase setup |
| `backend/src/main/java/com/glucocoach/server/service/FcmService.java` | FCM push sender |
| `backend/src/main/java/com/glucocoach/server/scheduler/GlucoseAlertScheduler.java` | Scheduled alert checker |
| `backend/src/test/java/com/glucocoach/server/scheduler/GlucoseAlertSchedulerTest.java` | Scheduler unit tests |

### Phase 1 — Modified files
| File | Change |
|------|--------|
| `backend/pom.xml` | Add firebase-admin 9.3.0 |
| `backend/src/main/resources/application.properties` | Add app.firebase.*, app.alert.*, app.llm.*, multipart |
| `backend/src/main/java/com/glucocoach/server/domain/AlertHistory.java` | + direction, notifyVia, alertId |
| `backend/src/main/java/com/glucocoach/server/domain/User.java` | + fcmToken |
| `backend/src/main/java/com/glucocoach/server/service/UserService.java` | + saveFcmToken |
| `backend/src/main/java/com/glucocoach/server/controller/UserController.java` | + PATCH /fcm-token |
| `backend/src/main/java/com/glucocoach/server/repository/AlertRepository.java` | + findByActiveTrue() |
| `backend/src/main/java/com/glucocoach/server/ServerApplication.java` | + @EnableScheduling |

### Phase 2 — New files
| File | Purpose |
|------|---------|
| `backend/src/main/java/com/glucocoach/server/dto/response/MealAnalysisResult.java` | Parsed LLM response record |
| `backend/src/main/java/com/glucocoach/server/exception/MealAnalysisException.java` | Wraps LLM failures → 502 |
| `backend/src/main/java/com/glucocoach/server/service/LlmMealAnalysisService.java` | Anthropic API caller |
| `backend/src/main/java/com/glucocoach/server/controller/MealImageController.java` | Upload + analysis endpoint |
| `backend/src/test/java/com/glucocoach/server/service/LlmMealAnalysisServiceTest.java` | LLM service tests |

### Phase 2 — Modified files
| File | Change |
|------|--------|
| `backend/src/main/java/com/glucocoach/server/domain/Meal.java` | + imageUrl, analysisResult, estimatedCarbs |
| `backend/src/main/java/com/glucocoach/server/dto/response/MealResponse.java` | + imageUrl, analysisResult, estimatedCarbs |
| `backend/src/main/java/com/glucocoach/server/mapper/MealMapper.java` | toResponse() maps 3 new fields |
| `backend/src/main/java/com/glucocoach/server/exception/GlobalExceptionHandler.java` | + MealAnalysisException → 502 |
| `docker-compose.yml` | + uploads bind-mount on api service |

---

## ═══ PHASE 1 — ALERT SCHEDULER ═══

### Task 1: firebase-admin dependency + all new application properties

**Files:**
- Modify: `backend/pom.xml`
- Modify: `backend/src/main/resources/application.properties`

- [ ] **Step 1: Add firebase-admin to pom.xml**

Inside the `<dependencies>` block, add:

```xml
<dependency>
    <groupId>com.google.firebase</groupId>
    <artifactId>firebase-admin</artifactId>
    <version>9.3.0</version>
</dependency>
```

- [ ] **Step 2: Append all new properties to application.properties**

```properties
# Firebase Cloud Messaging — leave blank to disable FCM in dev/CI
# Set FIREBASE_CREDENTIALS_PATH env var in prod pointing to service-account JSON
app.firebase.credentials-path=${FIREBASE_CREDENTIALS_PATH:}

# Glucose alert scheduler — runs every 60 seconds
app.alert.check-interval-ms=60000

# LLM meal analysis — set LLM_API_KEY env var in prod
app.llm.api-key=${LLM_API_KEY:}
app.llm.model=claude-opus-4-5

# Multipart file upload limit for meal image uploads
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

- [ ] **Step 3: Verify the project compiles**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 4: Commit**

```bash
git add backend/pom.xml backend/src/main/resources/application.properties
git commit -m "chore: add firebase-admin dep and scaffold all new application properties"
```

---

### Task 2: AlertDirection enum + AlertHistory patch + User.fcmToken

**Files:**
- Create: `backend/src/main/java/com/glucocoach/server/domain/enums/AlertDirection.java`
- Modify: `backend/src/main/java/com/glucocoach/server/domain/AlertHistory.java`
- Modify: `backend/src/main/java/com/glucocoach/server/domain/User.java`

- [ ] **Step 1: Create AlertDirection enum**

```java
package com.glucocoach.server.domain.enums;

public enum AlertDirection {
    LOW, HIGH
}
```

- [ ] **Step 2: Add three fields to AlertHistory**

Add these imports to `AlertHistory.java`:

```java
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import jakarta.persistence.Enumerated;
import jakarta.persistence.EnumType;
```

Add the following fields after the `message` field and before the `user` field. Note `alertId` is a plain `Long` with no foreign key — history rows are intentionally kept even when an alert config is later deleted:

```java
    @Enumerated(EnumType.STRING)
    private AlertDirection direction;

    @Enumerated(EnumType.STRING)
    private NotifyVia notifyVia;

    private Long alertId;   // no FK — history survives alert deletion
```

- [ ] **Step 3: Add fcmToken to User**

In `User.java`, add after the `resetTokenExpiresAt` field and before the `profile` field. The `@Column` import is already present:

```java
    @Column(nullable = true)
    private String fcmToken;
```

- [ ] **Step 4: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS` (Hibernate adds new columns via `ddl-auto=update` on next startup)

- [ ] **Step 5: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/domain/
git commit -m "feat: add AlertDirection enum, patch AlertHistory fields, add User.fcmToken"
```

---

### Task 3: FcmTokenRequest DTO + UserService.saveFcmToken + PATCH endpoint

**Files:**
- Create: `backend/src/main/java/com/glucocoach/server/dto/request/FcmTokenRequest.java`
- Modify: `backend/src/main/java/com/glucocoach/server/service/UserService.java`
- Modify: `backend/src/main/java/com/glucocoach/server/controller/UserController.java`

- [ ] **Step 1: Create FcmTokenRequest**

```java
package com.glucocoach.server.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class FcmTokenRequest {
    @NotBlank(message = "FCM token is required")
    private String fcmToken;
}
```

- [ ] **Step 2: Add saveFcmToken to UserService**

Add after the `changePassword` method:

```java
    @Transactional
    public void saveFcmToken(String email, String fcmToken) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException(
                        "User not found with email: " + email));
        user.setFcmToken(fcmToken);
        userRepository.save(user);
    }
```

- [ ] **Step 3: Add PATCH /api/users/fcm-token to UserController**

Add to the import block of `UserController.java`:

```java
import org.springframework.web.bind.annotation.PatchMapping;
import com.glucocoach.server.dto.request.FcmTokenRequest;
```

Add this method after the `changePassword` method:

```java
    // ── PATCH /api/users/fcm-token ────────────────────────────────────────────
    // Registers the device FCM token for push notification routing
    // Not added to permitAll — JWT required
    @PatchMapping("/fcm-token")
    public ResponseEntity<Void> updateFcmToken(
            @AuthenticationPrincipal User currentUser,
            @Valid @RequestBody FcmTokenRequest request) {
        userService.saveFcmToken(currentUser.getEmail(), request.getFcmToken());
        return ResponseEntity.ok().build();
    }
```

- [ ] **Step 4: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 5: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/dto/request/FcmTokenRequest.java \
        backend/src/main/java/com/glucocoach/server/service/UserService.java \
        backend/src/main/java/com/glucocoach/server/controller/UserController.java
git commit -m "feat: add PATCH /api/users/fcm-token and UserService.saveFcmToken"
```

---

### Task 4: AlertRepository + FcmConfig + FcmService + @EnableScheduling

**Files:**
- Modify: `backend/src/main/java/com/glucocoach/server/repository/AlertRepository.java`
- Create: `backend/src/main/java/com/glucocoach/server/config/FcmConfig.java`
- Create: `backend/src/main/java/com/glucocoach/server/service/FcmService.java`
- Modify: `backend/src/main/java/com/glucocoach/server/ServerApplication.java`

- [ ] **Step 1: Add findByActiveTrue() to AlertRepository**

Add after `findByIdAndUserId`. The `List` import is already present:

```java
    List<Alert> findByActiveTrue();
```

- [ ] **Step 2: Create FcmConfig**

Two guards protect against misconfiguration:
- `@ConditionalOnExpression` skips the class when credentials-path is blank (avoids the Spring warning that null-returning `@Bean` methods produce)
- Inside `@Bean` — file-not-found at runtime throws `IllegalStateException` (fast failure in prod over a silent no-op)

```java
package com.glucocoach.server.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.messaging.FirebaseMessaging;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

@Slf4j
@Configuration
@ConditionalOnExpression("!'${app.firebase.credentials-path:}'.trim().isEmpty()")
public class FcmConfig {

    @Value("${app.firebase.credentials-path}")
    private String credentialsPath;

    @Bean
    public FirebaseMessaging firebaseMessaging() throws IOException {
        File credentialsFile = new File(credentialsPath);
        if (!credentialsFile.exists()) {
            throw new IllegalStateException(
                    "Firebase credentials file not found at: " + credentialsPath +
                    ". Fix app.firebase.credentials-path, or leave it blank to disable FCM.");
        }
        GoogleCredentials credentials = GoogleCredentials.fromStream(
                new FileInputStream(credentialsFile));
        FirebaseOptions options = FirebaseOptions.builder()
                .setCredentials(credentials)
                .build();
        if (FirebaseApp.getApps().isEmpty()) {
            FirebaseApp.initializeApp(options);
        }
        return FirebaseMessaging.getInstance();
    }
}
```

- [ ] **Step 3: Create FcmService**

```java
package com.glucocoach.server.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
public class FcmService {

    // Optional because FcmConfig is @ConditionalOnExpression — absent in dev/CI
    private final Optional<FirebaseMessaging> firebaseMessaging;

    public void sendPush(String fcmToken, String title, String body) {
        if (firebaseMessaging.isEmpty()) {
            log.warn("FCM not configured — skipping push (set app.firebase.credentials-path to enable)");
            return;
        }
        if (!StringUtils.hasText(fcmToken)) {
            log.warn("No FCM token provided — skipping push notification");
            return;
        }
        try {
            Message message = Message.builder()
                    .setNotification(Notification.builder()
                            .setTitle(title)
                            .setBody(body)
                            .build())
                    .setToken(fcmToken)
                    .build();
            String messageId = firebaseMessaging.get().send(message);
            log.info("FCM push sent, messageId={}", messageId);
        } catch (FirebaseMessagingException e) {
            log.error("Failed to send FCM push: {}", e.getMessage());
            // Never rethrow — scheduler must continue processing other users
        }
    }
}
```

- [ ] **Step 4: Add @EnableScheduling to ServerApplication**

```java
package com.glucocoach.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class ServerApplication {

    public static void main(String[] args) {
        SpringApplication.run(ServerApplication.class, args);
    }
}
```

- [ ] **Step 5: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 6: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/repository/AlertRepository.java \
        backend/src/main/java/com/glucocoach/server/config/FcmConfig.java \
        backend/src/main/java/com/glucocoach/server/service/FcmService.java \
        backend/src/main/java/com/glucocoach/server/ServerApplication.java
git commit -m "feat: add FcmConfig (conditional), FcmService, findByActiveTrue, @EnableScheduling"
```

---

### Task 5: GlucoseAlertScheduler — write failing tests first (TDD)

**Files:**
- Create stub: `backend/src/main/java/com/glucocoach/server/scheduler/GlucoseAlertScheduler.java`
- Create: `backend/src/test/java/com/glucocoach/server/scheduler/GlucoseAlertSchedulerTest.java`

- [ ] **Step 1: Create scheduler stub so the test class can compile**

```java
package com.glucocoach.server.scheduler;

import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.service.FcmService;
import com.glucocoach.server.service.NightScoutService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@RequiredArgsConstructor
public class GlucoseAlertScheduler {

    private final AlertRepository alertRepository;
    private final NightScoutService nightScoutService;
    private final FcmService fcmService;
    private final AlertHistoryRepository alertHistoryRepository;

    @Scheduled(fixedRateString = "${app.alert.check-interval-ms:60000}")
    public void checkGlucoseAlerts() {
        // stub — implemented in Task 6
    }
}
```

- [ ] **Step 2: Write the full test class**

```java
package com.glucocoach.server.scheduler;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.dto.response.NightscoutEntryDTO;
import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.service.FcmService;
import com.glucocoach.server.service.NightScoutService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class GlucoseAlertSchedulerTest {

    @Mock private AlertRepository alertRepository;
    @Mock private NightScoutService nightScoutService;
    @Mock private FcmService fcmService;
    @Mock private AlertHistoryRepository alertHistoryRepository;

    @InjectMocks
    private GlucoseAlertScheduler scheduler;

    private User user;
    private Alert alert;

    @BeforeEach
    void setUp() {
        user = User.builder()
                .id(1L)
                .email("test@example.com")
                .fcmToken("device-fcm-token")
                .build();

        alert = Alert.builder()
                .id(10L)
                .thresholdLow(70.0)
                .thresholdHigh(180.0)
                .notifyVia(NotifyVia.PUSH)
                .active(true)
                .user(user)
                .build();
    }

    @Test
    void checkGlucoseAlerts_shouldSendPushAndSaveHistory_whenSgvBelowLowThreshold() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(60);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(
                eq("device-fcm-token"),
                eq("GlucoCoach Alert"),
                contains("Low glucose: 60"));

        ArgumentCaptor<AlertHistory> captor = ArgumentCaptor.forClass(AlertHistory.class);
        verify(alertHistoryRepository).save(captor.capture());
        AlertHistory saved = captor.getValue();
        assertThat(saved.getDirection()).isEqualTo(AlertDirection.LOW);
        assertThat(saved.getGlucoseValue()).isEqualTo(60.0);
        assertThat(saved.getNotifyVia()).isEqualTo(NotifyVia.PUSH);
        assertThat(saved.getAlertId()).isEqualTo(10L);
        assertThat(saved.getUser()).isEqualTo(user);
        assertThat(saved.getTriggeredAt()).isNotNull();
        assertThat(saved.getMessage()).contains("Low glucose: 60");
    }

    @Test
    void checkGlucoseAlerts_shouldSendPushAndSaveHistory_whenSgvAboveHighThreshold() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(220);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(
                eq("device-fcm-token"),
                eq("GlucoCoach Alert"),
                contains("High glucose: 220"));

        ArgumentCaptor<AlertHistory> captor = ArgumentCaptor.forClass(AlertHistory.class);
        verify(alertHistoryRepository).save(captor.capture());
        AlertHistory saved = captor.getValue();
        assertThat(saved.getDirection()).isEqualTo(AlertDirection.HIGH);
        assertThat(saved.getGlucoseValue()).isEqualTo(220.0);
        assertThat(saved.getMessage()).contains("High glucose: 220");
    }

    @Test
    void checkGlucoseAlerts_shouldNotFireAnything_whenSgvInRange() {
        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(100);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));

        scheduler.checkGlucoseAlerts();

        verify(fcmService, never()).sendPush(any(), any(), any());
        verify(alertHistoryRepository, never()).save(any());
    }

    @Test
    void checkGlucoseAlerts_shouldPassNullTokenToFcmService_whenFcmTokenIsNull() {
        // FcmService handles null token internally and logs a warning — scheduler must not throw
        User userNoToken = User.builder().id(2L).email("notok@example.com").fcmToken(null).build();
        Alert alertNoToken = Alert.builder()
                .id(11L).thresholdLow(70.0).thresholdHigh(180.0)
                .notifyVia(NotifyVia.PUSH).active(true).user(userNoToken).build();

        NightscoutEntryDTO entry = new NightscoutEntryDTO();
        entry.setSgv(60);

        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alertNoToken));
        when(nightScoutService.getEntries(1)).thenReturn(List.of(entry));

        scheduler.checkGlucoseAlerts();

        verify(fcmService).sendPush(isNull(), eq("GlucoCoach Alert"), contains("Low glucose"));
        verify(alertHistoryRepository).save(any(AlertHistory.class));
    }

    @Test
    void checkGlucoseAlerts_shouldSkipUser_whenNightscoutReturnsEmpty() {
        when(alertRepository.findByActiveTrue()).thenReturn(List.of(alert));
        when(nightScoutService.getEntries(1)).thenReturn(List.of());

        scheduler.checkGlucoseAlerts();

        verify(fcmService, never()).sendPush(any(), any(), any());
        verify(alertHistoryRepository, never()).save(any());
    }
}
```

- [ ] **Step 3: Run tests — verify all 5 FAIL**

```bash
cd backend && ./mvnw test -Dtest=GlucoseAlertSchedulerTest -q 2>&1 | tail -20
```

Expected: 5 test failures (stub method does nothing)

---

### Task 6: Implement GlucoseAlertScheduler — make all tests pass

**Files:**
- Modify: `backend/src/main/java/com/glucocoach/server/scheduler/GlucoseAlertScheduler.java`

- [ ] **Step 1: Replace the stub with the full implementation**

```java
package com.glucocoach.server.scheduler;

import com.glucocoach.server.domain.Alert;
import com.glucocoach.server.domain.AlertHistory;
import com.glucocoach.server.domain.User;
import com.glucocoach.server.domain.enums.AlertDirection;
import com.glucocoach.server.domain.enums.NotifyVia;
import com.glucocoach.server.repository.AlertHistoryRepository;
import com.glucocoach.server.repository.AlertRepository;
import com.glucocoach.server.service.FcmService;
import com.glucocoach.server.service.NightScoutService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class GlucoseAlertScheduler {

    private final AlertRepository alertRepository;
    private final NightScoutService nightScoutService;
    private final FcmService fcmService;
    private final AlertHistoryRepository alertHistoryRepository;

    @Scheduled(fixedRateString = "${app.alert.check-interval-ms:60000}")
    public void checkGlucoseAlerts() {
        List<Alert> activeAlerts = alertRepository.findByActiveTrue();

        Map<User, List<Alert>> alertsByUser = activeAlerts.stream()
                .collect(Collectors.groupingBy(Alert::getUser));

        for (Map.Entry<User, List<Alert>> entry : alertsByUser.entrySet()) {
            User user = entry.getKey();
            try {
                processAlertsForUser(user, entry.getValue());
            } catch (Exception e) {
                // Per-user isolation: a Nightscout timeout or DB error for one user
                // must never prevent the remaining users from being processed.
                log.error("Error processing alerts for user {}: {}", user.getId(), e.getMessage(), e);
            }
        }
    }

    private void processAlertsForUser(User user, List<Alert> alerts) {
        var entries = nightScoutService.getEntries(1);
        if (entries.isEmpty()) {
            log.warn("No Nightscout entries for user {} — skipping alert check", user.getId());
            return;
        }

        double sgv = entries.get(0).getSgv();   // Integer auto-unboxed to double

        for (Alert alert : alerts) {
            AlertDirection direction;
            if (sgv < alert.getThresholdLow()) {
                direction = AlertDirection.LOW;
            } else if (sgv > alert.getThresholdHigh()) {
                direction = AlertDirection.HIGH;
            } else {
                continue;   // in range — no alert, no history
            }

            String title = "GlucoCoach Alert";
            String body = direction == AlertDirection.LOW
                    ? "Low glucose: " + (int) sgv + " mg/dL (threshold: " + alert.getThresholdLow() + ")"
                    : "High glucose: " + (int) sgv + " mg/dL (threshold: " + alert.getThresholdHigh() + ")";

            NotifyVia notifyVia = alert.getNotifyVia();
            switch (notifyVia) {
                case PUSH  -> fcmService.sendPush(user.getFcmToken(), title, body);
                case EMAIL -> log.info("EMAIL not yet implemented — user {}", user.getId());
                case SMS   -> log.info("SMS not yet implemented — user {}", user.getId());
            }

            alertHistoryRepository.save(AlertHistory.builder()
                    .triggeredAt(LocalDateTime.now())
                    .glucoseValue(sgv)
                    .message(body)
                    .direction(direction)
                    .notifyVia(notifyVia)
                    .alertId(alert.getId())
                    .user(user)
                    .build());
        }
    }
}
```

- [ ] **Step 2: Run the scheduler tests — verify all 5 pass**

```bash
cd backend && ./mvnw test -Dtest=GlucoseAlertSchedulerTest -q 2>&1 | tail -10
```

Expected: `Tests run: 5, Failures: 0, Errors: 0`

- [ ] **Step 3: Run the full test suite — confirm no regressions**

```bash
cd backend && ./mvnw test -q 2>&1 | tail -15
```

Expected: `BUILD SUCCESS`

- [ ] **Step 4: Commit Phase 1 complete**

```bash
git add backend/src/main/java/com/glucocoach/server/scheduler/ \
        backend/src/test/java/com/glucocoach/server/scheduler/
git commit -m "feat: implement GlucoseAlertScheduler with FCM push notifications (Phase 1 complete)"
```

---

## ═══ PHASE 2 — MEAL LLM IMAGE ANALYSIS ═══

### Task 7: Meal entity + MealResponse + MealMapper

**Files:**
- Modify: `backend/src/main/java/com/glucocoach/server/domain/Meal.java`
- Modify: `backend/src/main/java/com/glucocoach/server/dto/response/MealResponse.java`
- Modify: `backend/src/main/java/com/glucocoach/server/mapper/MealMapper.java`

- [ ] **Step 1: Add three fields to Meal**

Add `jakarta.persistence.Column` to the import block. Then add these fields after `timestamp` and before the `user` field. `MealRequest` is NOT modified — `carbs` (user-confirmed) and `estimatedCarbs` (LLM-only) must never be conflated:

```java
    @Column(nullable = true)
    private String imageUrl;            // local file path set by MealImageController

    @Column(nullable = true, length = 2000)
    private String analysisResult;      // raw JSON from LLM — never reinterpreted in the app layer

    @Column(nullable = true)
    private Double estimatedCarbs;      // LLM estimate — separate from user-confirmed carbs
```

- [ ] **Step 2: Replace MealResponse with the updated version**

```java
package com.glucocoach.server.dto.response;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class MealResponse {
    private Long id;
    private String name;
    private Double carbs;
    private LocalDateTime timestamp;
    private Long userId;
    private String imageUrl;
    private String analysisResult;
    private Double estimatedCarbs;
}
```

- [ ] **Step 3: Replace MealMapper with the updated version**

```java
package com.glucocoach.server.mapper;

import org.springframework.stereotype.Component;
import com.glucocoach.server.domain.Meal;
import com.glucocoach.server.dto.request.MealRequest;
import com.glucocoach.server.dto.response.MealResponse;

@Component
public class MealMapper {

    public Meal toEntity(MealRequest request) {
        return Meal.builder()
                .name(request.getName())
                .carbs(request.getCarbs())
                .timestamp(request.getTimestamp())
                .build();
    }

    public MealResponse toResponse(Meal meal) {
        MealResponse response = new MealResponse();
        response.setId(meal.getId());
        response.setName(meal.getName());
        response.setCarbs(meal.getCarbs());
        response.setTimestamp(meal.getTimestamp());
        response.setUserId(meal.getUser().getId());
        response.setImageUrl(meal.getImageUrl());
        response.setAnalysisResult(meal.getAnalysisResult());
        response.setEstimatedCarbs(meal.getEstimatedCarbs());
        return response;
    }
}
```

- [ ] **Step 4: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 5: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/domain/Meal.java \
        backend/src/main/java/com/glucocoach/server/dto/response/MealResponse.java \
        backend/src/main/java/com/glucocoach/server/mapper/MealMapper.java
git commit -m "feat: add imageUrl, analysisResult, estimatedCarbs to Meal entity, response, mapper"
```

---

### Task 8: MealAnalysisResult record + MealAnalysisException + GlobalExceptionHandler

**Files:**
- Create: `backend/src/main/java/com/glucocoach/server/dto/response/MealAnalysisResult.java`
- Create: `backend/src/main/java/com/glucocoach/server/exception/MealAnalysisException.java`
- Modify: `backend/src/main/java/com/glucocoach/server/exception/GlobalExceptionHandler.java`

- [ ] **Step 1: Create MealAnalysisResult record**

```java
package com.glucocoach.server.dto.response;

import java.util.List;

public record MealAnalysisResult(
        String name,
        Double estimatedCarbs,
        List<String> ingredients,
        String confidence          // "low" | "medium" | "high"
) {}
```

- [ ] **Step 2: Create MealAnalysisException**

```java
package com.glucocoach.server.exception;

public class MealAnalysisException extends RuntimeException {

    public MealAnalysisException(String message) {
        super(message);
    }

    public MealAnalysisException(String message, Throwable cause) {
        super(message, cause);
    }
}
```

- [ ] **Step 3: Add MealAnalysisException handler to GlobalExceptionHandler**

Add this import at the top of `GlobalExceptionHandler.java`:

```java
import com.glucocoach.server.exception.MealAnalysisException;
```

Add this method after `handleUnauthorizedException` and before the `@Override handleMethodArgumentNotValid`:

```java
        @ExceptionHandler(MealAnalysisException.class)
        public ResponseEntity<ErrorResponse> handleMealAnalysisException(
                        MealAnalysisException ex, WebRequest request) {
                ErrorResponse error = ErrorResponse.builder()
                                .status(HttpStatus.BAD_GATEWAY.value())
                                .timestamp(Instant.now())
                                .error("Meal Analysis Failed")
                                .message(ex.getMessage())
                                .details(request.getDescription(false).replace("uri=", ""))
                                .build();
                return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(error);
        }
```

- [ ] **Step 4: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 5: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/dto/response/MealAnalysisResult.java \
        backend/src/main/java/com/glucocoach/server/exception/MealAnalysisException.java \
        backend/src/main/java/com/glucocoach/server/exception/GlobalExceptionHandler.java
git commit -m "feat: add MealAnalysisResult record, MealAnalysisException, 502 handler"
```

---

### Task 9: LlmMealAnalysisService — write failing tests first (TDD)

**Files:**
- Create stub: `backend/src/main/java/com/glucocoach/server/service/LlmMealAnalysisService.java`
- Create: `backend/src/test/java/com/glucocoach/server/service/LlmMealAnalysisServiceTest.java`

- [ ] **Step 1: Create service stub so the test class can compile**

```java
package com.glucocoach.server.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.glucocoach.server.dto.response.MealAnalysisResult;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Slf4j
@Service
@RequiredArgsConstructor
public class LlmMealAnalysisService {

    private final RestTemplate restTemplate;
    private final ObjectMapper objectMapper;

    @Value("${app.llm.api-key}")
    private String apiKey;

    @Value("${app.llm.model:claude-opus-4-5}")
    private String model;

    public MealAnalysisResult analyze(byte[] imageBytes) {
        // stub — implemented in Task 10
        throw new UnsupportedOperationException("not yet implemented");
    }
}
```

- [ ] **Step 2: Write the full test class**

```java
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
                .hasMessageContaining("Failed to analyze meal image");
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
                .hasMessageContaining("Failed to analyze meal image");
    }
}
```

- [ ] **Step 3: Run tests — verify all 3 FAIL**

```bash
cd backend && ./mvnw test -Dtest=LlmMealAnalysisServiceTest -q 2>&1 | tail -20
```

Expected: 3 test failures (stub throws `UnsupportedOperationException`)

---

### Task 10: Implement LlmMealAnalysisService — make all tests pass

**Files:**
- Modify: `backend/src/main/java/com/glucocoach/server/service/LlmMealAnalysisService.java`

- [ ] **Step 1: Replace the stub with the full implementation**

```java
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
            String rawText = root.path("content").get(0).path("text").asText();

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
```

- [ ] **Step 2: Run the three LLM tests — verify all pass**

```bash
cd backend && ./mvnw test -Dtest=LlmMealAnalysisServiceTest -q 2>&1 | tail -10
```

Expected: `Tests run: 3, Failures: 0, Errors: 0`

- [ ] **Step 3: Run full test suite — confirm no regressions**

```bash
cd backend && ./mvnw test -q 2>&1 | tail -15
```

Expected: `BUILD SUCCESS`

- [ ] **Step 4: Commit**

```bash
git add backend/src/main/java/com/glucocoach/server/service/LlmMealAnalysisService.java \
        backend/src/test/java/com/glucocoach/server/service/LlmMealAnalysisServiceTest.java
git commit -m "feat: implement LlmMealAnalysisService with Anthropic API and base64 image upload"
```

---

### Task 11: MealImageController + Docker uploads volume

**Files:**
- Create: `backend/src/main/java/com/glucocoach/server/controller/MealImageController.java`
- Modify: `docker-compose.yml`

- [ ] **Step 1: Create MealImageController**

`analysisResult` is stored as re-serialized JSON of the parsed result — a clean, reproducible format. `MealRepository.findByIdAndUserId` already exists and provides user-scoped meal access:

```java
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
            @AuthenticationPrincipal User user) throws IOException {

        Meal meal = mealRepository.findByIdAndUserId(id, user.getId())
                .orElseThrow(() -> new ResourceNotFoundException("Meal not found with id: " + id));

        // Read bytes once — used for both file write and LLM analysis
        byte[] fileBytes = file.getBytes();

        // Save to uploads/meals/{userId}/{uuid}.jpg (relative to working dir)
        // In Docker: working_dir=/app → resolves to /app/uploads/meals/... matching the volume mount
        Path dir = Paths.get("uploads", "meals", user.getId().toString());
        Files.createDirectories(dir);
        Path filePath = dir.resolve(UUID.randomUUID() + ".jpg");
        Files.write(filePath, fileBytes);
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
    }
}
```

- [ ] **Step 2: Add uploads volume to the api service in docker-compose.yml**

In `docker-compose.yml`, add `working_dir` and `volumes` to the existing `api` service block (keep all existing keys — only add the two new ones):

```yaml
  api:
    image: ${API_IMAGE:-glucocoach-api:latest}
    build:
      context: ./backend
      dockerfile: Dockerfile
    networks:
      - app-network
    depends_on:
      - database
    ports:
      - "8080:8080"
    working_dir: /app
    volumes:
      - ./uploads:/app/uploads
    environment:
      # ... all existing environment vars stay unchanged
      - FIREBASE_CREDENTIALS_PATH=        # leave blank; override in prod
      - LLM_API_KEY=                      # leave blank; override in prod
```

The bind mount `./uploads:/app/uploads` creates `./uploads/` on the host next to `docker-compose.yml`. Since `working_dir` is `/app` and file paths are written as `uploads/meals/{userId}/...`, they resolve to `/app/uploads/meals/...` inside the container — matching the mount point. Files survive container restarts because they live on the host.

- [ ] **Step 3: Compile**

```bash
cd backend && ./mvnw compile -q
```

Expected: `BUILD SUCCESS`

- [ ] **Step 4: Run the full test suite**

```bash
cd backend && ./mvnw test -q 2>&1 | tail -15
```

Expected: `BUILD SUCCESS`, all tests pass

- [ ] **Step 5: Commit Phase 2 complete**

```bash
git add backend/src/main/java/com/glucocoach/server/controller/MealImageController.java \
        docker-compose.yml
git commit -m "feat: add MealImageController with LLM analysis and Docker uploads volume (Phase 2 complete)"
```
