# Mobile-Specific Flutter Roadmap

This roadmap is prioritized for learning the mobile-specific pieces that matter most for the `app-ihs-mobile-front` project.

## Phase 1: Native App Foundations

- Native config files: `AndroidManifest.xml`, `Info.plist`, entitlements, app schemes, background modes.
- Firebase setup: Android/iOS config files, app initialization, messaging, analytics.
- App icons and splash screen: Android launch theme, iOS launch screen, first-frame behavior.
- Build and release setup: app id, signing, build numbers, Play Store, TestFlight/App Store.

## Phase 2: Notifications And Links

- Push notifications: FCM, permissions, foreground/background behavior, notification tokens.
- Local notifications: channels, groups, scheduling, notification tap handling.
- Deep links: custom schemes like `myapp://...`.
- Universal/app links: `https://...` links that open the app.
- Notification payload routing: tapping a notification opens the right screen.

## Phase 3: Lifecycle And Navigation

- App lifecycle: foreground, background, resume, cold start, warm start.
- Android back behavior: `PopScope`, drawers, modals, webview back navigation.
- Safe areas and system UI: notches, status bar, navigation bar, `SafeArea`.
- Keyboard behavior: forms, `adjustResize`, scroll-to-focused-input.
- Orientation handling: portrait/landscape, video fullscreen, `SystemChrome`.

## Phase 4: Storage, Offline, And Downloads

- File storage: documents directory, cache directory, external storage.
- Storage permissions: Android SDK differences, denied permissions, open settings.
- File downloads: background downloads, progress, pause/cancel/delete.
- Disk space checks: low storage warnings before downloads.
- Offline persistence: Hive, SharedPreferences, SQLite/sqlcipher.
- Cache management: cached API responses, clearing user data on logout.

## Phase 5: Media

- Camera/gallery: pick image, take photo, handle permissions.
- Image crop/upload: crop avatar, upload multipart files.
- Video playback: custom controls, fullscreen, progress, continue watching.
- Background audio: `audio_service`, `just_audio`, OS media controls, audio notifications.

## Phase 6: Web And External Integrations

- WebViews: embedded pages, JavaScript, progress, URL interception.
- External URL handling: browser, YouTube, email, phone, non-http schemes.
- Share sheet: share links/files/text with native apps.
- Payments/donations: external checkout, WebView/browser flows, return handling.

## Phase 7: Observability And Runtime Control

- Analytics: Firebase events, screen tracking, user id.
- iOS tracking permission: App Tracking Transparency.
- Crash reporting: Sentry setup, user scope, API error capture.
- Remote config: feature flags, runtime config, maintenance/force-update behavior.

## Lower Priority For This Project

These are useful mobile topics, but they appear less central to the current work app:

- Location / GPS
- Maps
- Microphone recording
- Contacts native access
- Calendar native access
- Bluetooth
- NFC
- Biometrics
- Sensors: accelerometer, gyroscope, compass
- Battery APIs
- Haptics / vibration
- QR / barcode scanning

## Suggested Side Project Structure

Build a `mobile_playground` app with one screen per topic:

- Permissions screen
- Notifications screen
- Deep links screen
- Downloads/storage screen
- Offline cache screen
- Camera/gallery screen
- Audio/video screen
- WebView/external links screen
- Lifecycle/back button screen
- Analytics/crash reporting screen

