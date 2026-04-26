# GlucoCoach — Alert Scheduler & Meal LLM Analysis
**Date:** 2026-04-26
**Status:** Approved
**Scope:** Phase 1 — FCM push alert scheduler | Phase 2 — Meal image upload + LLM analysis

---

## Context

GlucoCoach is a Spring Boot 4 / Java 21 CGM management app. All business logic follows the
Alert pattern: Lombok `@Builder/@Data/@RequiredArgsConstructor`, manual mappers, `ResourceNotFoundException`
for 404s, `@AuthenticationPrincipal User` for auth. Existing integrations: Nightscout (glucose data),
PostgreSQL (JPA/Hibernate `ddl-auto=update`), JWT auth.

---

## Phase 1 — Alert Scheduler (FCM Push Notifications)

### 1.1 Data Model Changes

**`domain/User.java`** — add one nullable field:
```
@Column(nullable = true)
private String fcmToken;
```

**`domain/enums/AlertDirection.java`** — new enum:
```
public enum AlertDirection { LOW, HIGH }
```

**`domain/AlertHistory.java`** — add three nullable fields (additive; existing rows unaffected):
```
@Enumerated(EnumType.STRING)
private AlertDirection direction;   // LOW or HIGH

@Enumerated(EnumType.STRING)
private NotifyVia notifyVia;        // mirrors the alert's channel

private Long alertId;               // plain Long, NOT a FK — history survives alert deletion
```
The existing `alertId` comment intent: keeping history intact when an alert config is later deleted
is deliberate and matches the existing no-FK comment already on the entity.

Existing `AlertHistory` fields retained unchanged: `id`, `triggeredAt`, `glucoseValue`, `message`, `user`.

### 1.2 New Endpoint — `PATCH /api/users/fcm-token`

**`dto/request/FcmTokenRequest.java`**
- Single field: `@NotBlank String fcmToken`

**`UserController`** — add:
```
PATCH /api/users/fcm-token
Body: FcmTokenRequest
Auth: JWT (@AuthenticationPrincipal)
Response: 200 no body
```
Saves `fcmToken` on the authenticated user. Not added to `permitAll` in `SecurityConfig`.

### 1.3 Firebase Dependency

```xml
<dependency>
  <groupId>com.google.firebase</groupId>
  <artifactId>firebase-admin</artifactId>
  <version>9.3.0</version>
</dependency>
```

### 1.4 FcmConfig (Conditional)

**`config/FcmConfig.java`**
- `@Configuration`
- `@ConditionalOnProperty(name = "app.firebase.credentials-path", matchIfMissing = false)`
- Reads `app.firebase.credentials-path` via `@Value`
- **Edge case — blank string:** `@ConditionalOnProperty` only guards against the property being
  *absent*. The default `${FIREBASE_CREDENTIALS_PATH:}` resolves to an empty string, which means
  the property IS present and the condition still matches. The `@Bean` method must therefore also
  check `StringUtils.hasText(credentialsPath)` and whether the file exists. If either check fails,
  log a warning and return `null` from the `@Bean` method (Spring 6+ handles null `@Bean` returns
  by simply not registering the bean, making `Optional<FirebaseMessaging>` resolve to
  `Optional.empty()`).
- If file exists and path is non-blank → initialize `FirebaseApp` via `FileInputStream` +
  `GoogleCredentials.fromStream()`
- Exposes `@Bean FirebaseMessaging`

When the property is absent, blank, or the file is missing, no `FirebaseMessaging` bean is
registered. Spring will inject `Optional.empty()` into any dependent that declares
`Optional<FirebaseMessaging>`.

**`application.properties`** (safe default — empty string disables FCM in dev/CI):
```
app.firebase.credentials-path=${FIREBASE_CREDENTIALS_PATH:}
```

### 1.5 FcmService

**`service/FcmService.java`** — `@Service`, injects `Optional<FirebaseMessaging>`

`sendPush(String fcmToken, String title, String body)`:
1. `FirebaseMessaging` absent → `log.warn("FCM not configured")`, return
2. `fcmToken` null or blank → `log.warn("No FCM token for user")`, return
3. Build `Message` via Firebase SDK, call `FirebaseMessaging.send(message)`
4. On success → log info
5. `FirebaseMessagingException` → log error, **never rethrow** (scheduler must not die)

### 1.6 AlertRepository

Add derived query method:
```java
List<Alert> findByActiveTrue();
```

### 1.7 GlucoseAlertScheduler

**`scheduler/GlucoseAlertScheduler.java`** — `@Component`

Injected deps: `AlertRepository`, `NightScoutService`, `FcmService`, `AlertHistoryRepository`

Scheduled: `@Scheduled(fixedRateString = "${app.alert.check-interval-ms:60000}")`

`@EnableScheduling` added to `ServerApplication`.

**`application.properties`**:
```
app.alert.check-interval-ms=60000
```

**Execution logic:**

```
1. Fetch alertRepository.findByActiveTrue()
2. Group alerts by User → Map<User, List<Alert>>
3. For each user entry:
   [wrap entire block in try/catch(Exception) → log error, continue]

   a. Call nightScoutService.getEntries(1)
      - IOException / any exception is caught by the outer try/catch
      - If result is empty → log.warn("No Nightscout entries for user {}"), continue
   b. sgv = entries.get(0).getSgv()
   c. For each alert in user's list:
      - sgv < alert.thresholdLow  → direction = LOW
      - sgv > alert.thresholdHigh → direction = HIGH
      - else → skip (no history saved, no notification sent)
   d. On fire:
      title = "GlucoCoach Alert"
      body  = LOW  ? "Low glucose: {sgv} mg/dL (threshold: {thresholdLow})"
                   : "High glucose: {sgv} mg/dL (threshold: {thresholdHigh})"
      Route by alert.notifyVia:
        PUSH  → fcmService.sendPush(user.getFcmToken(), title, body)
        EMAIL → log.info("EMAIL not implemented, user {}", user.getId())
        SMS   → log.info("SMS not implemented, user {}", user.getId())
      Save AlertHistory:
        triggeredAt   = Instant.now() / LocalDateTime.now()
        glucoseValue  = sgv (as Double)
        message       = body
        direction     = LOW | HIGH
        notifyVia     = alert.getNotifyVia()
        alertId       = alert.getId()
        user          = user
```

**Error isolation guarantee:** every per-user block is wrapped in `try/catch(Exception)`.
A Nightscout timeout, FCM failure, or DB error for user A never prevents user B from being processed.
The scheduler thread itself never crashes.

### 1.8 GlucoseAlertSchedulerTest

**`test/.../scheduler/GlucoseAlertSchedulerTest.java`**
`@ExtendWith(MockitoExtension.class)`, mocks: `AlertRepository`, `NightScoutService`, `FcmService`, `AlertHistoryRepository`

| Test | Setup | Assert |
|------|-------|--------|
| LOW alert fires | sgv=60, thresholdLow=70, notifyVia=PUSH | `sendPush` called; history saved with `direction=LOW` |
| HIGH alert fires | sgv=220, thresholdHigh=180, notifyVia=PUSH | `sendPush` called; history saved with `direction=HIGH` |
| In-range — no action | sgv=100, low=70, high=180 | `sendPush` never called; history never saved |
| Null FCM token | sgv=60, user.fcmToken=null | `sendPush` called with null (FcmService handles it); no throw |
| Empty Nightscout response | getEntries returns `[]` | no alert fired, no history saved |

---

## Phase 2 — Meal LLM Image Analysis

### 2.1 Meal Entity Changes

**`domain/Meal.java`** — add three nullable fields:
```java
@Column(nullable = true)
private String imageUrl;          // local file path (see §2.6 for persistence)

@Column(nullable = true, length = 2000)
private String analysisResult;    // raw JSON string from LLM — never interpreted by the app layer

@Column(nullable = true)
private Double estimatedCarbs;    // LLM estimate — separate from user-confirmed carbs field
```

**Carbs separation rule:** `carbs` (existing field on `MealRequest`) is the user-confirmed value.
`estimatedCarbs` is LLM-only and is never set via `MealRequest`. These must not be conflated.
`MealRequest` stays unchanged.

**`dto/response/MealResponse.java`** — add `imageUrl`, `analysisResult`, `estimatedCarbs`.

**`mapper/MealMapper.java`** — `toResponse()` maps all three new fields. `toEntity()` unchanged.

### 2.2 MealAnalysisResult Record

**`dto/response/MealAnalysisResult.java`**:
```java
public record MealAnalysisResult(
    String name,
    Double estimatedCarbs,
    List<String> ingredients,
    String confidence          // "low" | "medium" | "high"
) {}
```

### 2.3 MealAnalysisException

**`exception/MealAnalysisException.java`** — extends `RuntimeException`:
```java
public MealAnalysisException(String message) { ... }
public MealAnalysisException(String message, Throwable cause) { ... }
```

**`GlobalExceptionHandler`** — add handler: returns `502 Bad Gateway` with the exception message.

### 2.4 LlmMealAnalysisService

**`service/LlmMealAnalysisService.java`** — `@Service`, injects the existing `RestTemplate` bean
and the Spring-autoconfigured `ObjectMapper` bean (do not construct a new `ObjectMapper` — inject
it so Jackson configuration stays consistent across the app).

Properties (in `application.properties`):
```
app.llm.api-key=${LLM_API_KEY:}
app.llm.model=claude-opus-4-5
```

`public MealAnalysisResult analyze(byte[] imageBytes)`:

1. Base64-encode `imageBytes`
2. Build request body as `Map` (serialized to JSON via `ObjectMapper`):
   ```
   model: {model}
   max_tokens: 512
   messages: [{
     role: "user",
     content: [
       { type: "image", source: { type: "base64", media_type: "image/jpeg", data: {b64} } },
       { type: "text",  text: "Analyze this meal photo. Return ONLY valid JSON, no markdown.
                               Keys: name(string), estimatedCarbs(number grams),
                               ingredients(string[]), confidence(low|medium|high)" }
     ]
   }]
   ```
3. POST to `https://api.anthropic.com/v1/messages`
   Headers: `Content-Type: application/json`, `x-api-key: {apiKey}`, `anthropic-version: 2023-06-01`
4. Parse response: extract `content[0].text`, strip ` ```json ` / ` ``` ` fences if present,
   parse remaining string with `ObjectMapper` into `MealAnalysisResult`
5. Any exception (HTTP error, parse failure, missing field) → wrap and throw `MealAnalysisException`

### 2.5 MealImageController

**`controller/MealImageController.java`** — `@RestController @RequestMapping("/api/meals")`

Injects: `MealRepository`, `LlmMealAnalysisService`, `MealMapper`

```
POST /api/meals/{id}/image
Consumes: multipart/form-data
Param: @RequestParam("file") MultipartFile
Auth: JWT (@AuthenticationPrincipal User)
Response: 200 MealResponse
```

Logic:
1. `mealRepository.findByIdAndUserId(id, user.getId())` → `ResourceNotFoundException` if absent
2. Create directories: `uploads/meals/{userId}/`; save file as `uploads/meals/{userId}/{UUID}.jpg`
3. `meal.setImageUrl(relativePath)`
4. `llmMealAnalysisService.analyze(file.getBytes())`
5. `meal.setAnalysisResult(rawJsonString)`; `meal.setEstimatedCarbs(result.estimatedCarbs())`
6. If `meal.getName()` is blank → `meal.setName(result.name())`
7. `mealRepository.save(meal)` → return `mealMapper.toResponse(savedMeal)`

Not added to `permitAll` — protected by existing JWT filter.

**`application.properties`**:
```
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

### 2.6 File Persistence (Docker)

`uploads/` is a local directory path. In development this is fine. On a VPS with Docker,
container restarts wipe the container filesystem.

**`docker-compose.yml`** — add named volume mount:
```yaml
services:
  backend:
    volumes:
      - ./uploads:/app/uploads
    working_dir: /app
```

The file-write path in `MealImageController` must be relative to the working directory
(`uploads/meals/{userId}/{UUID}.jpg`) so it resolves correctly both locally and inside Docker.

### 2.7 LlmMealAnalysisServiceTest

**`test/.../service/LlmMealAnalysisServiceTest.java`**
`@ExtendWith(MockitoExtension.class)`, mock: `RestTemplate`

| Test | Setup | Assert |
|------|-------|--------|
| Valid image | Mock returns well-formed JSON response | Returns correct `MealAnalysisResult` with all fields |
| API HTTP error | Mock throws `HttpClientErrorException` | `MealAnalysisException` thrown |
| Malformed JSON | Mock returns `content[0].text = "not json"` | `MealAnalysisException` thrown |

---

## Cross-Cutting Constraints

| Constraint | Detail |
|------------|--------|
| Existing test files | Never modified — all new tests in new files |
| New properties | All in `application.properties` with safe empty-string or numeric defaults |
| Scheduler resilience | Per-user try/catch; Nightscout unreachable is caught by same block |
| Security | `PATCH /api/users/fcm-token` and `POST /api/meals/{id}/image` are NOT in `permitAll` |
| Carbs fields | `MealRequest.carbs` = user value; `Meal.estimatedCarbs` = LLM only — never conflated |
| FCM in CI/dev | Absent `app.firebase.credentials-path` → no bean, FcmService no-ops silently |
