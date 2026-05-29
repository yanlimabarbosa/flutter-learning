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
- Strapi should become the main backend/API mirror, including auth/JWT and course/lesson data.
- Content creation should be handled through Strapi admin for the MVP.
- The Flutter app should stay student-facing for now: login, signup, home, catalog, course detail, lesson/player, saved courses, progress, profile, settings, and account recovery.
- Public content creator registration and creator dashboard screens are out of scope for the MVP.
- Firebase Auth was useful as a learning detour, but it should not be treated as the final mirror of the work project.
- Firebase should be added later for mobile infrastructure such as push notifications, analytics, remote config, and diagnostics.
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
- Firebase Messaging/local notifications
- analytics/error tracking

## Current Documentation

Read these files before implementing:

```txt
../../index.md
ROADMAP.md
MIRROR_IMPLEMENTATION_PLAN.md
work_project_architecture_notes.md
review_checklist.md
content_hub/pubspec.yaml
```

## Next Implementation Step

The Flutter app has been initialized as `content_hub`.

Planning docs and prototypes were updated to match the Strapi-admin/student-app split.

Current prototype references:

```txt
prototypes/prototype_gallery.html
prototypes/login_modern_editorial.html
prototypes/signup_modern_editorial.html
prototypes/home_authenticated_modern_editorial.html
prototypes/course_catalog_modern_editorial.html
prototypes/course_detail_modern_editorial.html
prototypes/lesson_detail_modern_editorial.html
prototypes/saved_courses_modern_editorial.html
prototypes/progress_modern_editorial.html
prototypes/profile_modern_editorial.html
prototypes/settings_modern_editorial.html
prototypes/password_reset_modern_editorial.html
prototypes/account_confirmation_pending_modern_editorial.html
```

Next, follow `MIRROR_IMPLEMENTATION_PLAN.md`:

1. Create the local Strapi backend in `content_hub_api`.
2. Create `Course` and `Lesson` content types.
3. Add sample course/lesson data in Strapi admin.
4. Add Dio and fetch courses through `ApiClient -> Repository -> Cubit`.
5. Replace Firebase Auth learning code with Strapi auth/JWT when the data flow is stable.

## Notes For Future Sessions

When resuming this project:

1. Read `../../index.md`.
2. Read `ROADMAP.md`.
3. Read `MIRROR_IMPLEMENTATION_PLAN.md`.
4. Read `work_project_architecture_notes.md`.
5. Read this `session_progress.md`.
6. Read `review_checklist.md` before reviewing code.
7. Continue from the next unfinished phase.

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
