# HeritageOS

**Discover Ethiopia Through AI** — a Flutter app for exploring Ethiopian heritage sites, museums, and artifacts through guided tours, QR-scannable exhibits, audio narration, an AI cultural guide, and AR previews.

[![Flutter](https://img.shields.io/badge/Flutter-3.44+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.12+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platforms](https://img.shields.io/badge/platforms-Android%20%7C%20iOS%20%7C%20Web-lightgrey)]()

---

## Table of Contents

- [About](#about)
- [Features](#features)
- [Demo Mode](#demo-mode)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Content](#content)
- [Design System](#design-system)
- [Testing](#testing)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

---

## About

HeritageOS turns a visit to an Ethiopian museum or heritage site into a guided, interactive experience. Point the app at an exhibit's QR code to pull up its story, listen to an audio guide, ask an AI guide follow-up questions, or preview an artifact in AR.

The app currently ships with eight curated Ethiopian heritage sites from the Adwa Victory Memorial Museum to the rock-hewn churches of Lalibela  including their exhibits, timelines, ticketing details, and visitor reviews.

## Features

**Discovery**
- Home feed with featured sites, categories, upcoming cultural events, and tour progress
- Heritage directory with live search across site name, city, and category
- Map screen and nearby-places view for orienting around a site
- Saved places and a personal profile with achievements

**At the site**
- QR scanner that resolves exhibit codes (e.g. `ADWA-DIORAMA-001`) to full artifact pages
- Per-site screens for exhibits, timeline, activities, tours, and reviews
- Audio guide with a full transport (play/pause, seek, ±15s skip) built on `just_audio`
- AR preview screen with a live camera feed and a placeable exhibit overlay

**Learning**
- AI Guide chat that answers questions about Ethiopian history and heritage
- Per-site AI screen scoped to the place you're visiting
- Scored multiple-choice quiz on Ethiopian history
- Ticketing screen for visit planning

**Platform**
- Locale switching across English, Amharic, and French, persisted with `shared_preferences`
- Firebase-backed auth, Firestore, and Storage service layer

## Demo Mode

**The app runs fully offline against bundled mock data.** No Firebase project or API key is required to build and explore it. Several subsystems are deliberately stubbed so the UI can be demoed end to end:

| Subsystem | Current behavior | Backed by |
| --- | --- | --- |
| Authentication | Always signed in as a demo user; sign-in forms simulate a delay | `providers/auth_provider.dart` |
| Places, exhibits, reviews | Served from in-memory mock data | `data/mock_data.dart` |
| Firestore | Service exists but short-circuits to mock data (`_isAvailable = false`) | `services/firestore_service.dart` |
| AI Guide chat | Keyword-matched canned responses for Adwa, Lalibela, Lucy, Axum, Gondar, Harar | `providers/chat_provider.dart` |
| OpenAI | Fully implemented client, not yet wired to the chat UI | `services/openai_service.dart` |
| QR scanning | Simulated lookups against known demo codes | `screens/qr_screen.dart` |
| AR | Camera passthrough with an animated overlay, not true plane tracking | `screens/ar_screen.dart` |

Firebase initialization in `main.dart` is wrapped in a `try`/`catch`, so the app starts normally with placeholder credentials. See [Configuration](#configuration) to switch to live backends.

## Tech Stack

| Layer | Choice |
| --- | --- |
| Framework | Flutter |
| State management | Riverpod (`flutter_riverpod`, `riverpod_annotation`) |
| Backend | Firebase Core, Auth, Cloud Firestore, Storage, Google Sign-In |
| Networking | Dio |
| Camera / QR | `mobile_scanner` |
| Maps & location | `google_maps_flutter`, `geolocator`, `geocoding` |
| Audio | `just_audio` |
| Local storage | `shared_preferences` |
| Localization | `flutter_localizations`, `intl` |
| UI | `google_fonts`, `flutter_svg`, `cached_network_image`, `percent_indicator`, `flutter_staggered_animations` |

## Getting Started

### Prerequisites

- **Flutter 3.44 or newer** (Dart 3.12+) — this is what `pubspec.lock` was resolved against. Check with `flutter --version`; on an older SDK, `flutter pub get` will re-resolve the lockfile and produce spurious diffs.
- Android Studio / Xcode for device builds, or Chrome for web
- A physical device for camera-dependent features (QR scanning and AR do not work in emulators without a virtual camera)

### Install

```bash
git clone https://github.com/yuti-AMZ/HeritageOS-mobile.git
cd HeritageOS-mobile
flutter pub get
```

### Run

```bash
flutter devices          # list available targets
flutter run              # run on the default device
flutter run -d chrome    # run in the browser
```

### Build

```bash
flutter build apk --release        # Android
flutter build appbundle --release  # Android (Play Store)
flutter build ios --release        # iOS (requires macOS + Xcode)
flutter build web --release        # Web
```

## Configuration

Everything below is optional — the app runs without it.

### Firebase

Replace the placeholder credentials in `lib/main.dart` with your own project's values. The recommended path is FlutterFire, which generates `lib/firebase_options.dart` for you:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Then swap the inline `FirebaseOptions` for the generated config:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

To go live rather than staying on mock data, flip `_isAvailable` to `true` in `services/firestore_service.dart` and point the providers in `providers/heritage_provider.dart` at `FirestoreService` instead of `MockData`. `data/seed_data.dart` will populate Firestore with the bundled places, exhibits, and reviews.

### OpenAI

`OpenAIService` is ready but unwired. Construct it with your key and call it from `ChatNotifier.sendMessage` in place of `_generateResponse`:

```dart
final service = OpenAIService(apiKey: const String.fromEnvironment('OPENAI_API_KEY'));
final reply = await service.chat(systemPrompt: '...', messages: [...]);
```

Pass the key at build time rather than committing it:

```bash
flutter run --dart-define=OPENAI_API_KEY=sk-...
```

### Google Maps

`google_maps_flutter` is declared as a dependency but not yet used in any screen. Before adding a real map, register an API key in `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`.

### Permissions

Camera access is already declared for both platforms — `CAMERA` in the Android manifest and `NSCameraUsageDescription` in `ios/Runner/Info.plist`. Location permissions are requested at runtime by `providers/map_provider.dart` and will need matching manifest and plist entries before location features ship.

## Project Structure

```
lib/
├── main.dart                 # Entry point, Firebase init, theme, locale wiring
├── constants/
│   ├── app_colors.dart       # Palette
│   └── app_strings.dart      # UI copy
├── data/
│   ├── mock_data.dart        # 8 heritage sites with exhibits and timelines
│   └── seed_data.dart        # One-shot Firestore seeder
├── l10n/
│   ├── app_en.arb            # English strings
│   └── app_am.arb            # Amharic strings
├── models/
│   ├── heritage_place.dart   # HeritagePlace, Exhibit, TimelineEvent, Achievement
│   ├── place_model.dart      # UI view models (Category, Event, QuizQuestion, …)
│   ├── review_model.dart
│   └── user_model.dart
├── providers/                # Riverpod state
│   ├── audio_provider.dart     # Playback state and transport
│   ├── auth_provider.dart      # Demo session
│   ├── chat_provider.dart      # AI guide conversation
│   ├── heritage_provider.dart  # Places, exhibits, reviews, saved places
│   ├── locale_provider.dart    # Persisted language preference
│   └── map_provider.dart       # Geolocation and distance
├── screens/                  # 25 screens
├── services/                 # Firebase, OpenAI, and audio clients
├── utils/
│   ├── exhibit_lookup.dart   # QR payload → exhibit resolution
│   └── page_transitions.dart
└── widgets/                  # BottomNav, StatusBar, FeatureTag
```

## Architecture

The app follows a layered flow: **screens** read and write **providers**, providers call **services**, and services return **models**.

```
Screen (ConsumerWidget)
  └─ Provider (Riverpod)
       └─ Service (Firestore / OpenAI / Audio)
            └─ Model
```

**Navigation** starts at `SplashScreen`, which waits two seconds and then routes to `HomeScreen` when a session exists or `OnboardingScreen` when it doesn't. In demo mode a session always exists, so the onboarding and login screens are reachable only by signing out.

`HomeScreen` owns the five-tab shell — Home, Explore, AI Guide, Scan, Profile — and swaps the body via index rather than named routes. Deeper screens are pushed with `MaterialPageRoute`.

**Providers use families where state is scoped to an entity**, so `chatProvider`, `exhibitsProvider`, and `reviewsProvider` are keyed by place ID and each site keeps its own independent conversation and exhibit list.

## Content

Eight heritage sites ship with the app:

| Site | City | Category |
| --- | --- | --- |
| Adwa Victory Memorial Museum | Addis Ababa | Museum |
| National Museum of Ethiopia | Addis Ababa | Museum |
| Rock-Hewn Churches of Lalibela | Lalibela | Archaeological Site |
| Axum Obelisks & Archaeological Site | Axum | Archaeological Site |
| Fasil Ghebbi (Gondar Castles) | Gondar | Historical Monument |
| Harar Jugol — Old Walled City | Harar | Historical Monument |
| Simien Mountains National Park | Debark | Natural Heritage |
| Tiya Stelae Field | Tiya | Archaeological Site |

Each carries a description, hero and gallery imagery, rating, opening hours, ticket pricing in ETB, contact details, coordinates, and — for the museum sites — exhibits with QR codes and timeline events.

## Design System

The palette draws on Ethiopian heritage tones, defined in `constants/app_colors.dart`:

| Token | Hex | Use |
| --- | --- | --- |
| `green` | `#1E3A2F` | Primary, headers, splash |
| `gold` | `#C9A227` | Secondary, accents, highlights |
| `sand` | `#F5F1E8` | Active states, warm surfaces |
| `greyLight` | `#F4F6F5` | Scaffold background |

## Testing

```bash
flutter test              # run the suite
flutter analyze           # static analysis (flutter_lints)
```

Coverage is currently a single smoke test in `test/widget_test.dart` that verifies the app boots and renders its title.

## Roadmap

- [ ] Wire `OpenAIService` into the AI Guide in place of canned responses, and use its `generateQuiz` / `generateDescription` helpers to replace the hardcoded quiz
- [ ] Enable live Firestore reads and writes; retire the mock-data fallback
- [ ] Real Firebase Auth sessions, replacing the demo user
- [ ] Live QR scanning in `QRScreen` using the `mobile_scanner` camera already used by the AR screen
- [ ] True AR with ARCore / ARKit and 3D exhibit models
- [ ] Generate localizations from the `.arb` files (`l10n.yaml` + `generate: true`) and replace hardcoded `AppStrings`; add French translations
- [ ] Bundle audio guide assets — `mock_data.dart` references `audio/adwa_oral_history.mp3`, which is not yet in the project
- [ ] Real Google Maps integration on the map and nearby screens
- [ ] Persist saved places across launches
- [ ] Set a production `applicationId` and release signing config (currently `com.example.heritageos`, signed with debug keys)
- [ ] Broaden test coverage beyond the smoke test

## Contributing

1. Fork the repository and create a branch off `main`: `git checkout -b feature/your-feature`
2. Run `flutter analyze` and `flutter test` before committing
3. Follow the existing commit style (`feat:`, `fix:`, `refactor:`)
4. Open a pull request describing the change and how you verified it

When adding a dependency, commit the resulting `pubspec.lock` from a Flutter 3.44+ SDK so the lockfile stays stable for everyone.

## License

No license has been specified for this project yet.
