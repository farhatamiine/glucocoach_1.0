# GlucoCoach Mobile

A Flutter 3.24+ mobile app for personal diabetes management. Connects to an existing Spring Boot 4 backend API to track glucose, log meals/insulin, view clinical analytics, and receive push alerts.

## Features

- **Real-time Glucose Dashboard** — Current SGV with trend arrows, color-coded ranges, TIR summary
- **Clinical Analytics** — Glucose trends, TIR breakdown, AGP percentile bands, daily averages, LBGI/HBGI risk indices
- **Meal Logging** — Log meals with carbs, upload photos for AI-powered carb estimation via LLM
- **Insulin Tracking** — Log meal and correction boluses with linked meals
- **Smart Alerts** — Configure glucose threshold alerts with push notification support
- **Offline Support** — Local caching with sync queue for when connection returns
- **Secure Auth** — JWT tokens stored in secure storage with automatic refresh

## Tech Stack

| Layer | Package |
|-------|---------|
| State Management | `flutter_riverpod` + `riverpod_generator` |
| Networking | `dio` + `retrofit` |
| Serialization | `freezed` + `json_serializable` |
| Local Storage | `hive_ce` |
| Security | `flutter_secure_storage` + `envied` |
| Charts | `fl_chart` |
| Navigation | `go_router` |
| Images | `image_picker` + `cached_network_image` |
| Notifications | `firebase_messaging` + `flutter_local_notifications` |

## Getting Started

### Prerequisites

- Flutter 3.24+ (SDK ^3.11.1)
- Dart 3.11+
- Android Studio / Xcode for emulators
- Backend API running at `http://141.94.121.93:8080`

### Setup

1. **Clone and install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   ```
   Edit `.env` to set your API base URL:
   ```
   API_BASE_URL=http://141.94.121.93:8080
   ```

3. **Generate code (models, API clients, providers):**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

### Firebase Setup (for Push Notifications)

1. Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
2. Add Android/iOS apps and download config files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
3. Enable Cloud Messaging in Firebase Console
4. The app automatically registers FCM tokens and sends them to the backend

## Project Structure

```
lib/
  config/           # Routes, theme, constants, env
  data/
    models/         # Freezed DTOs matching backend
    repositories/   # Dio provider, Retrofit API client
    local/          # Secure storage, Hive boxes, sync queue, connectivity
  domain/
    providers/      # Riverpod business logic providers
  presentation/
    screens/        # One folder per feature
    widgets/        # Shared components (GlucoseValue, TIRBar, etc.)
    theme/          # Design tokens and app theme
  main.dart
```

## Backend API Integration

The app integrates with a Spring Boot 4 backend. Key endpoints:

| Feature | Endpoint |
|---------|----------|
| Auth | `/api/auth/login`, `/api/auth/register` |
| User | `/api/users/me`, `/api/users/fcm-token` |
| Profile | `/api/profile` |
| Meals | `/api/meals`, `/api/meals/{id}/image` |
| Bolus | `/api/bolus` |
| Glucose | `/api/glucose/health-data`, `/api/glucose/trend`, etc. |
| Alerts | `/api/alerts`, `/api/alert-history` |

## Running Tests

```bash
# Unit tests
flutter test test/unit/

# Widget tests
flutter test test/widget/

# All tests
flutter test
```

## Design System

Custom minimal design system with semantic color tokens:

- **Glucose Colors**: Green (70-180), Orange (181-250), Red (<70 or >250), Dark Red (<54)
- **Typography**: Inter font family with tabular figures for glucose values
- **Components**: AppCard, GlucoseValue, TIRBar, TimeRangeChips
- **Accessibility**: 48dp touch targets, high contrast, screen reader labels

## License

Personal project — all rights reserved.
