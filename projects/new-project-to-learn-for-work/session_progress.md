# Session Progress

This file tracks practical progress for the work-focused learning project.

Project path:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
```

Flutter app path:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/content_hub
```

Purpose:

```txt
Build a side project that teaches the same architecture and tools used in the real work project:
/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front
```

## Current Goal

Prepare to build a `Content Hub` app that mirrors the work project's main pattern:

```txt
UI -> Cubit -> Repository -> Dio/API -> Models
```

## What Has Been Decided

- The real work project mostly uses `Cubit`, not classic event-based `Bloc`.
- The learning project should focus on Cubit first.
- Classic `Bloc<Event, State>` should only be studied later if needed.
- The learning project should become a controlled practice version of the real job architecture.
- Strapi will be added later to mirror the production API response shape.
- Firebase will be added later for auth and mobile integrations.
- Yan should build this project himself as much as possible.
- Agents should guide with hints, explanations, and checkpoints instead of writing code or running commands.
- Agents should only implement code or run commands in this project when Yan explicitly asks them to do it.

## Skills This Project Should Teach

- Cubit state management
- `BlocProvider`
- `BlocBuilder`
- `BlocConsumer`
- `BlocListener`
- `RepositoryProvider`
- Repository Pattern
- Dio API client
- `json_serializable`
- local storage
- `HydratedCubit`
- Strapi API shape
- Strapi auth/JWT
- Firebase Auth
- Firebase Messaging/local notifications
- analytics/error tracking

## Current Documentation

Read these files before implementing:

```txt
../../index.md
ROADMAP.md
work_project_architecture_notes.md
review_checklist.md
content_hub/pubspec.yaml
```

## Next Implementation Step

The Flutter app has been initialized as `content_hub`.

Start with Phase 1 from `ROADMAP.md`:

- create static screens
- wire navigation
- avoid Cubit until the baseline UI exists

## Notes For Future Sessions

When resuming this project:

1. Read `../../index.md`.
2. Read `ROADMAP.md`.
3. Read `work_project_architecture_notes.md`.
4. Read this `session_progress.md`.
5. Read `review_checklist.md` before reviewing code.
6. Continue from the next unfinished phase.

## Review Preference Added

When Yan asks whether Flutter code is clean or asks for a review, do not only check compiler correctness.

Also review:

- widget extraction quality
- naming clarity
- layout ownership
- semantic `ColorScheme` usage
- whether `on...` colors are being used as foreground colors
- whether `AppColors` is leaking into widgets unnecessarily
- visual match against the current prototype

The full checklist is documented in:

```txt
review_checklist.md
```

## Android Emulator Color Fix

The Pixel phone emulator was showing dark colors warmer/lighter than Chrome web and the tablet emulator. The Flutter theme was not the cause: the issue was the emulator's host GPU rendering path.

Working fix:

```txt
AVD: Pixel_7_API_35
Graphics: SwiftShader software rendering
```

Command that proved the fix:

```bash
emulator -avd Pixel_7_API_35 -gpu swiftshader_indirect -no-snapshot-load
```

Permanent AVD config:

```txt
/home/yan/.android/avd/Pixel_7_API_35.avd/config.ini
```

Important values:

```ini
hw.gpu.enabled=yes
hw.gpu.mode=swiftshader_indirect
hw.lcd.depth=32
hw.ramSize=4096M
vm.heapSize=512M
disk.dataPartition.size=6G
PlayStore.enabled=yes
```

Use this emulator for UI/color work. SwiftShader may be slower than hardware GPU, but it avoids the dark-color distortion caused by the host GPU/Mesa path.
