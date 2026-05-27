# Session Progress

This file tracks practical progress for the work-focused learning project.

Project path:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
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
```

## Next Implementation Step

Create the Flutter app in this folder:

```bash
cd /home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
fvm flutter create .
```

Then start with Phase 1 from `ROADMAP.md`:

- create static screens
- wire navigation
- avoid Cubit until the baseline UI exists

## Notes For Future Sessions

When resuming this project:

1. Read `../../index.md`.
2. Read `ROADMAP.md`.
3. Read `work_project_architecture_notes.md`.
4. Read this `session_progress.md`.
5. Continue from the next unfinished phase.

