# GlucoCoach Backend — Project Context

> Auto-generated project reference for Kimi Code CLI. Read this at the start of every task in this repo.

---

## 1. Project Overview

**GlucoCoach** is a diabetes management backend API. It helps users track:
- Blood glucose readings (via Nightscout CGM integration)
- Meals, basal & bolus insulin doses
- Health data (weight, heart rate, blood pressure)
- Lab analyses (HbA1c, cholesterol, triglycerides)
- Alerts & alert history for out-of-range glucose values

**Key Features:**
- JWT-based stateless authentication (access + refresh tokens)
- Firebase Cloud Messaging (FCM) push notifications for glucose alerts
- AI-powered meal image analysis via Anthropic Claude API
- Glucose analytics: TIR, AGP, hypo/hyper counts, insulin sensitivity estimation, risk indices (LBGI/HBGI)

---

## 2. Tech Stack

| Layer | Technology |
|-------|------------|
| **Framework** | Spring Boot 4.0.5 |
| **Language** | Java 21 |
| **Build Tool** | Maven |
| **Database** | PostgreSQL (Hibernate `ddl-auto=update`, no Flyway/Liquibase) |
| **Security** | Spring Security + JJWT 0.12.6 (HMAC-SHA) |
| **API Docs** | SpringDoc OpenAPI 2.8.5 (`/swagger-ui.html`) |
| **Push Notifications** | Firebase Admin SDK 9.3.0 |
| **LLM Integration** | Anthropic Claude API (`RestTemplate`) |
| **Math/Stats** | Apache Commons Math 2.2 |
| **Utilities** | Lombok |

---

## 3. Project Structure

```
src/main/java/com/glucocoach/server/
├── ServerApplication.java          # @EnableScheduling
├── config/                         # AppConfig, FcmConfig, SecurityConfig
├── controller/                     # REST controllers (see §5)
├── domain/                         # JPA entities (see §4)
├── domain/enums/                   # BolusType, DiabetesType, GlucoseUnit, NotifyVia, AlertDirection
├── dto/request/                    # Request DTOs
├── dto/response/                   # Response DTOs
├── exception/                      # Custom exceptions + GlobalExceptionHandler
├── mapper/                         # Entity <-> DTO mappers
├── repository/                     # Spring Data JPA repos
├── scheduler/                      # GlucoseAlertScheduler
├── security/                       # JwtAuthFilter, JwtService, UserDetailsServiceImpl
├── service/                        # Business logic (see §6)

src/main/resources/
├── application.properties          # Main config
├── application.local.properties    # Identical copy; auto-included via spring.profiles.include=local

src/test/java/com/glucocoach/server/
├── ServerApplicationTests.java
├── scheduler/GlucoseAlertSchedulerTest.java
├── service/*ServiceTest.java       # Unit tests for most services
```

---

## 4. Domain Model (JPA Entities)

All entities use: `@Entity`, Lombok (`@Data`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor`), `IDENTITY` id generation.

| Entity | Key Fields | Relationships |
|--------|-----------|---------------|
| **User** | `id`, `firstName`, `lastName`, `birthDate`, `email`, `password`, `resetTokenHash`, `resetTokenExpiresAt`, `fcmToken` | `@OneToOne` → Profile |
| **Profile** | `id`, `height`, `diabetesSince`, `diabetesType` (enum), `glucoseUnit` (enum), `prescribedBasalDose`, `basalInsulinName`, `bolusInsulinName` | `@OneToOne` → User |
| **HealthData** | `id`, `weight`, `heartRate`, `bloodPressure`, `date` | `@ManyToOne` → User |
| **Meal** | `id`, `name`, `carbs`, `timestamp`, `analysisResult` (JSON text), `estimatedCarbs` | `@ManyToOne` → User |
| **Basal** | `id`, `amount`, `injectedAt` | `@ManyToOne` → User |
| **Bolus** | `id`, `amount`, `bolusType` (enum string), `timestamp` | `@ManyToOne` → User, `@ManyToOne` → Meal (nullable) |
| **Alert** | `id`, `thresholdLow`, `thresholdHigh`, `notifyVia` (enum), `active` | `@ManyToOne` → User |
| **AlertHistory** | `id`, `triggeredAt`, `glucoseValue`, `message`, `direction` (enum), `notifyVia`, `alertId` | `@ManyToOne` → User |
| **RefreshToken** | `id`, `token` (unique), `expiresAt` | `@OneToOne` → User |
| **LaboAnalysis** | `id`, `hba1c`, `cholesterol`, `triglycerides`, `date` | `@ManyToOne` → User |

### Enums
- `BolusType` — MEAL, CORRECTION
- `DiabetesType` — TYPE_1, TYPE_2, GESTATIONAL, LADA, OTHER
- `GlucoseUnit` — MG_DL, MMOL_L
- `NotifyVia` — PUSH, EMAIL, SMS
- `AlertDirection` — RISING, FALLING, STABLE, RAPIDLY_RISING, RAPIDLY_FALLING, UNKNOWN

---

## 5. API Controllers & Endpoints

All controllers are `@RestController` under base path `/api`.

| Controller | Base Path | Auth | Key Operations |
|------------|-----------|------|----------------|
| `AuthController` | `/api/auth/**` | Public | POST `/register`, `/login`, `/refresh`, `/logout`, `/forget-password`, `/reset-password` |
| `UserController` | `/api/users/**` | Protected | GET `/me`, POST `/change-password`, POST `/fcm-token` |
| `UserProfileController` | `/api/profile/**` | Protected | CRUD profile |
| `HealthDataController` | `/api/health-data/**` | Protected | CRUD health data entries |
| `MealController` | `/api/meals/**` | Protected | CRUD meals |
| `MealImageController` | `/api/meals/{id}/image` | Protected | POST image → calls Claude LLM → updates meal with analysis |
| `BasalController` | `/api/basal/**` | Protected | CRUD basal insulin |
| `BolusController` | `/api/bolus/**` | Protected | CRUD bolus insulin |
| `GlucoseController` | `/api/glucose/**` | Protected | GET `/health-data`, `/trend`, `/tir`, `/agp`, `/risk`, `/insulin-sensitivity` |
| `AlertController` | `/api/alerts/**` | Protected | CRUD glucose alerts |
| `AlertHistoryController` | `/api/alert-history/**` | Protected | GET alert history |
| `LaboAnalysisController` | `/api/labo-analysis/**` | Protected | CRUD lab analyses |

Public (no auth) paths configured in `SecurityConfig`:
- `/api/auth/**`
- `/v3/api-docs/**`, `/swagger-ui/**`, `/swagger-ui.html`

---

## 6. Services (Business Logic)

| Service | Responsibility |
|---------|---------------|
| `AuthService` | Register, login, refresh, logout, password reset (SHA-256 hashed tokens, 1h expiry) |
| `UserService` | User CRUD, FCM token management |
| `ProfileService` | Profile CRUD |
| `MealService` | Meal CRUD |
| `BasalService` | Basal insulin CRUD |
| `BolusService` | Bolus insulin CRUD |
| `HealthDataService` | Health data CRUD |
| `LaboAnalysisService` | Lab analysis CRUD |
| `AlertService` | Alert CRUD |
| `AlertHistoryService` | Alert history logging |
| `NightScoutService` | Fetches CGM data from Nightscout instance via `RestTemplate` |
| `GlucoseService` | Pure analytics/statistics on Nightscout data (TIR, AGP, hypo/hyper, ISF, LBGI/HBGI) |
| `LlmMealAnalysisService` | Calls Anthropic Claude API with base64 JPEG → parses JSON → `MealAnalysisResult` |
| `FcmService` | Firebase push notification sender (conditional on `app.firebase.credentials-path`) |
| `GlucoseAlertScheduler` | `@Scheduled(fixedRate=60000)` — checks all active alerts against latest Nightscout reading, sends FCM if out of range |

---

## 7. Security Architecture

- **JWT Stateless Auth**: Access token (24h) + refresh token (7d)
- **Filter**: `JwtAuthFilter` (extends `OncePerRequestFilter`) extracts `Bearer <token>` → validates via `JwtService` → sets `SecurityContextHolder`
- **Password hashing**: `BCryptPasswordEncoder`
- **Refresh token rotation**: old token deleted before issuing new one
- **Password reset**: SHA-256 hashed reset tokens with 1-hour expiry; silent fail on `forgetPassword` to prevent user enumeration
- **User entity**: Implements `UserDetails` directly (no roles yet, empty authorities)
- **Current user injection**: `@AuthenticationPrincipal User` in controllers

---

## 8. External Integrations

### Nightscout CGM
- Base URL: `${nightscout-url}` (default `http://localhost:1337`)
- API secret header: not currently sent (comment notes `// ← no headers at all`)
- Endpoints consumed:
  - `GET /api/v1/entries.json?count={n}`
  - `GET /api/v1/entries.json?find[dateString][$gte]={from}&count=999999`

### Anthropic Claude (LLM Meal Analysis)
- URL: `https://api.anthropic.com/v1/messages`
- API key: `${app.llm.api-key}` (env `LLM_API_KEY`)
- Model: `${app.llm.model:claude-opus-4-5}`
- Input: base64 JPEG image
- Output: JSON with `name`, `estimatedCarbs`, `ingredients`, `confidence`

### Firebase Cloud Messaging (FCM)
- Enabled only when `app.firebase.credentials-path` is set
- Used by `GlucoseAlertScheduler` for push notifications

---

## 9. Configuration (`application.properties`)

```properties
# Database
spring.datasource.url=jdbc:postgresql://localhost:5432/glucocoach
spring.datasource.username=postgres
spring.datasource.password=root
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# JWT
jwt.secret=glucocoach-super-secret-key-must-be-at-least-32-characters-long!
jwt.expiration=86400000
jwt.refresh-expiration=604800000

# Server
server.port=8080

# Nightscout
nightscout-url=${NIGHTSCOUT_URL:http://localhost:1337}
nightscout-api-secret=${NIGHTSCOUT_API_SECRET:48f875fa-0e03-416f-b9d6-19c9afc4e197}

# Logging
logging.level.com.glucocoach=DEBUG
logging.level.org.springframework.web.client=DEBUG

# Firebase (optional)
app.firebase.credentials-path=${FIREBASE_CREDENTIALS_PATH:}

# Alert scheduler
app.alert.check-interval-ms=60000

# LLM (optional)
app.llm.api-key=${LLM_API_KEY:}
app.llm.model=claude-opus-4-5

# Upload limits
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
app.upload.max-size-bytes=10485760

# Profile
spring.profiles.include=local
```

**Note:** `application.local.properties` is an identical copy and is auto-included. There is no `application-prod.properties` or separate prod profile file.

---

## 10. Build & Deployment

### Maven
```bash
./mvnw clean package -DskipTests
```

### Docker
Multi-stage `Dockerfile`:
- Stage 1: `maven:3.9-eclipse-temurin-21` — builds JAR
- Stage 2: `eclipse-temurin:21-jre-alpine` — runtime, exposes 8080

No `docker-compose.yml` in root. A `compose.yaml` exists defining a `postgres` service (`postgres:latest`).

---

## 11. Testing

- Framework: Spring Boot Test + JUnit 5
- Service layer has unit tests for: `Alert`, `Auth`, `Basal`, `Bolus`, `HealthData`, `LaboAnalysis`, `LlmMealAnalysis`, `Meal`, `Profile`, `User`
- Scheduler test: `GlucoseAlertSchedulerTest`
- Run tests: `./mvnw test`

---

## 12. Coding Conventions & Patterns

- **Constructor injection** via `@RequiredArgsConstructor` (preferred over `@Autowired`)
- **DTO + Mapper pattern** for every domain object
- **Lombok `@Builder`** on entities and DTOs
- **`FetchType.LAZY`** on `@ManyToOne` relationships
- **`@Enumerated(EnumType.STRING)`** for enum persistence
- **`@ToString(exclude = ...)`** and **`@EqualsAndHashCode.Exclude`** to avoid circular references
- **`@Transactional`** on write operations in services
- **Global exception handling** via `@ControllerAdvice` (`GlobalExceptionHandler`)
- **Silent failures** on auth/security operations to prevent information leakage
- **Record-style DTOs** — many response DTOs are Java `record` classes (check individually)

---

## 13. Important Notes & Caveats

1. **No database migrations**: Schema is managed by Hibernate `ddl-auto=update`. No Flyway or Liquibase.
2. **Hardcoded JWT secret**: The secret in `application.properties` is hardcoded and should be overridden via env var in production.
3. **Nightscout auth**: `NightScoutService.fetchEntries()` sends **no headers** — the `apiSecret` config value is loaded but not attached to requests.
4. **LLM image type hardcoded**: `LlmMealAnalysisService` always sends `media_type: image/jpeg`. `MealImageController` converts uploads to `.jpg` before calling the service.
5. **No roles/authorities**: `User` returns empty authorities; all authenticated users have the same access level.
6. **Refresh token stored in DB**: `RefreshToken` entity holds the raw token string (not hashed).
7. **Password reset token hashing**: Reset tokens are SHA-256 hashed before storage, but the comparison logic uses raw hash strings.
8. **File upload size**: Enforced at Spring level (10MB) and app level (`app.upload.max-size-bytes`).
9. **Scheduler interval**: Glucose alerts are checked every 60 seconds (`fixedRateString = "${app.alert.check-interval-ms:60000}"`).
10. **FCM is optional**: If `FIREBASE_CREDENTIALS_PATH` is unset, FCM beans are not loaded (`@ConditionalOnExpression`).
11. **LLM is optional**: If `LLM_API_KEY` is unset, meal analysis throws `MealAnalysisException` with a clear message.

---

## 14. Quick Reference — File Locations

| Concern | File(s) |
|---------|---------|
| Main app | `src/main/java/com/glucocoach/server/ServerApplication.java` |
| Security config | `src/main/java/com/glucocoach/server/config/SecurityConfig.java` |
| JWT filter | `src/main/java/com/glucocoach/server/security/JwtAuthFilter.java` |
| JWT service | `src/main/java/com/glucocoach/server/security/JwtService.java` |
| Exception handler | `src/main/java/com/glucocoach/server/exception/GlobalExceptionHandler.java` |
| App config | `src/main/resources/application.properties` |
| Local config | `src/main/resources/application.local.properties` |
| Dockerfile | `Dockerfile` |
| POM | `pom.xml` |
| Tests | `src/test/java/com/glucocoach/server/service/*Test.java` |

---

## 15. Environment Variables for Production

| Variable | Purpose |
|----------|---------|
| `NIGHTSCOUT_URL` | Nightscout instance base URL |
| `NIGHTSCOUT_API_SECRET` | Nightscout API secret |
| `FIREBASE_CREDENTIALS_PATH` | Path to Firebase service account JSON |
| `LLM_API_KEY` | Anthropic API key |
| `JWT_SECRET` | **Should override** the hardcoded secret |

---

*Last updated: 2026-05-04*
