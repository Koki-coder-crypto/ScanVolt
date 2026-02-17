# ScanVolt — QR & Barcode Scanner

## Project Overview
A production-quality QR code and barcode scanner app for iOS App Store (Utilities category).
Built with Flutter, targeting iOS and Android. No Mac available — iOS builds done via Codemagic CI/CD.

## Tech Stack
- Flutter (latest stable) with Dart
- mobile_scanner v7.x — core scanning engine (CameraX/ML Kit on Android, AVFoundation/Apple Vision on iOS)
- qr_flutter — QR code generation
- drift + sqlite3_flutter_libs — local SQLite database
- flutter_riverpod — state management
- go_router — navigation
- purchases_flutter (RevenueCat) — in-app purchases
- google_fonts — typography
- share_plus — sharing functionality
- url_launcher — opening URLs
- image_picker — gallery image selection

## Architecture
- Clean Architecture with 3 layers: Presentation, Domain, Data
- Feature-first folder structure under lib/features/
- MVVM pattern: Views (widgets) + ViewModels (StateNotifier/AsyncNotifier with Riverpod)
- Repository pattern in data layer
- Unidirectional data flow: Data Layer → UI Layer
- Immutable data models with freezed

## Code Style
- Follow Effective Dart and very_good_analysis lint rules
- Use const constructors wherever possible
- Use Riverpod for ALL state management — no setState, no ChangeNotifier
- Use go_router for ALL navigation
- Prefer async/await over raw Futures
- Use /// doc comments for all public APIs
- Name files with lowercase_with_underscores
- Name classes with UpperCamelCase
- Suffix ViewModels with "ViewModel", Views with "Screen", Repositories with "Repository", Services with "Service"

## Key Business Rules
- No ads, no dark patterns, no scan count limits in free version
- Free: unlimited scans, 50 history items visible, 4 basic QR generation types, security URL check
- Pro: unlimited history, 15+ QR types, custom QR design, batch export, iCloud sync, lens switching, image scan, widgets
- Privacy-first: no user tracking, no personal data collection, scan data stored only on device
