# Codex Workspace Guide

This workspace belongs to Yan and is used to learn Flutter for work.

Primary goal:

```txt
Learn enough Flutter, Cubit, repositories, Dio, mobile tooling, Strapi, and Firebase
to work confidently on the real job project:
/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front
```

Yan is a JavaScript/fullstack web developer learning Flutter. Explanations should often map concepts back to React, React Router, Next.js, React Query, Zustand/Redux, Axios, and common web mental models.

## Projects In This Workspace

### 1. Flutter Basics App

Project wrapper path:

```txt
/home/yan/codes/flutter-learning/projects/flutter_learning_introduction
```

Flutter app path:

```txt
/home/yan/codes/flutter-learning/projects/flutter_learning_introduction/flutter_app
```

Purpose:

```txt
Small Flutter course/practice app where Yan learned Flutter basics.
```

Use this project for:

- Flutter fundamentals
- Widgets
- `StatefulWidget` / `StatelessWidget`
- `setState`
- layout practice
- Material widgets
- navigation basics
- forms and inputs
- `ValueNotifier`
- first HTTP/FutureBuilder practice
- animations like `Hero` and `AnimatedCrossFade`

Important docs:

```txt
/home/yan/codes/flutter-learning/projects/flutter_learning_introduction/flutter_learning_progress.md
```

This file is the chronological learning log for the basics learned inside the nested `flutter_app` app.

### 2. Work-Focused Learning Project

Path:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
```

Flutter app path:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/content_hub
```

Purpose:

```txt
Future side project designed to mirror the architecture and tools used in the real work project.
```

Use this project for:

- Cubit
- `flutter_bloc`
- `BlocProvider`
- `BlocBuilder`
- `BlocConsumer`
- `BlocListener`
- `RepositoryProvider`
- Repository Pattern
- Dio
- `json_serializable`
- `HydratedCubit`
- local storage
- Strapi API shape
- Strapi auth/JWT
- Firebase Auth
- Firebase Messaging/local notifications
- analytics/error tracking

Important docs:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/ROADMAP.md
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/work_project_architecture_notes.md
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/session_progress.md
```

`ROADMAP.md` describes the app Yan should build to learn the job-relevant stack.

`work_project_architecture_notes.md` explains the architecture of the real work project and how to mirror it.

`session_progress.md` tracks practical progress and the next implementation step for this work-focused learning project.

### 3. Other Docs

Path:

```txt
/home/yan/codes/flutter-learning/other_docs/mobile_specific_roadmap.md
```

Purpose:

```txt
Later-stage roadmap of mobile-specific topics Yan should learn after the
current Cubit/Repository/Dio/Strapi/Firebase learning track is underway.
```

This is not the main roadmap right now. Treat it as a later reference.

Topics include:

- permissions
- push notifications
- deep links
- file storage
- camera/gallery
- background tasks
- payments
- WebViews
- keyboard behavior
- safe areas/notches
- back button behavior
- native config files

## Real Work Project

Path:

```txt
/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front
```

This is the production-style project Yan is preparing to work on.

Architecture summary:

```txt
Hybrid layered Flutter architecture:
UI -> Cubit/Bloc -> Repository -> HesedAPI/Dio -> Models
```

More precise label:

```txt
BLoC package with mostly Cubit usage,
Repository Pattern,
Dio API service,
json_serializable models,
provider-based dependency injection,
partial feature-first Clean Architecture in newer modules.
```

Important notes:

- The project uses the `flutter_bloc` package.
- It mostly uses `Cubit`, not classic event-based `Bloc`.
- `BlocProvider`, `BlocBuilder`, `BlocConsumer`, and `BlocListener` are still used with Cubits.
- It uses `RepositoryProvider` for dependency injection.
- It uses `Dio` for HTTP.
- It uses `json_serializable` and generated `*.g.dart` files for models.
- It uses `HydratedCubit` in some places for persisted state.
- It has both layer-first folders (`lib/blocs`, `lib/repositories`, `lib/models`, `lib/ui`) and feature-first folders (`lib/features/download`, `lib/features/bible`).

When guiding Yan, prioritize this pattern:

```txt
Widget calls Cubit method.
Cubit emits loading/success/error states.
Cubit calls Repository.
Repository calls API/local storage.
API uses Dio.
Models parse JSON.
UI rebuilds with BlocBuilder/BlocConsumer.
```

Do not over-focus on classic event-based Bloc unless Yan explicitly asks. The work project has many Cubits and almost no classic `Bloc<Event, State>` classes.

## Preferred Learning Direction

For Yan's next serious learning work, use:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
```

The Flutter app inside that project is:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/content_hub
```

The intended app is described in:

```txt
projects/new-project-to-learn-for-work/ROADMAP.md
```

Study order:

```txt
1. Cubit basics
2. State classes
3. BlocProvider
4. BlocBuilder
5. BlocListener
6. BlocConsumer
7. RepositoryProvider
8. Repository Pattern
9. Dio
10. json_serializable
11. HydratedCubit
12. local storage repository
13. token/interceptor auth flow
14. pagination
15. Strapi API shape
16. Strapi auth/JWT
17. deep links
18. Firebase Auth
19. Firebase Cloud Messaging/local notifications
20. analytics/error tracking
21. tests
```

## Communication Notes

Yan learns best with:

- direct explanations
- honest judgment
- practical code examples
- React/web analogies
- "why this exists" explanations
- clear distinction between course/demo code and production-style code

Useful analogies:

```txt
Flutter Widget = React component
build() = render/return
setState = local component state update
Cubit = Zustand/Redux-like store/controller with methods
BlocBuilder = component subscribed to store state
BlocConsumer = subscribed component plus side-effect listener
Repository = API/data module
Dio = Axios-like HTTP client
RepositoryProvider/BlocProvider = Context Provider
HydratedCubit = persisted store
Future = Promise
```

Yan can get frustrated when Flutter behavior is surprising. Be concrete about hot reload vs hot restart, state ownership, and where errors appear.

## Learning Project Guidance Rule

For the work-focused learning project, Yan wants to build things himself.

Project:

```txt
projects/new-project-to-learn-for-work/content_hub
```

When Yan asks how to do something in this project, the agent should usually:

- explain the goal
- describe the next step
- give hints and checkpoints
- explain what to look for in the output
- let Yan type commands and code himself

Do not write full code or run commands for Yan in this project unless he explicitly asks with wording like:

```txt
do it for me
write the code
run it
implement it
fix it
create it
```

If Yan asks for help while learning, prefer guidance over implementation.

## Documentation Update Protocol

When Yan says something like:

```txt
update the docs
update progress
document this
add this to the docs
```

the agent must update every relevant documentation file, not just one default file.

Before editing docs, determine the current context:

```txt
1. Which project is Yan working in?
2. Was the topic Flutter basics, work-project architecture, or later mobile-specific learning?
3. Is this a new decision, a completed implementation step, a debugging lesson, or a future plan?
4. Does the workspace index need a new path/reference?
```

Use this routing:

```txt
Flutter basics learned in projects/flutter_learning_introduction/flutter_app
  -> update projects/flutter_learning_introduction/flutter_learning_progress.md

Work-focused learning project progress
  -> update projects/new-project-to-learn-for-work/session_progress.md

Work-focused roadmap changes or future implementation phases
  -> update projects/new-project-to-learn-for-work/ROADMAP.md

Real work project architecture/pattern analysis
  -> update projects/new-project-to-learn-for-work/work_project_architecture_notes.md

Workspace structure, moved files, new docs, new projects, or important reading order
  -> update index.md

Later mobile-specific topics not needed immediately
  -> update other_docs/mobile_specific_roadmap.md
```

If multiple files are relevant, update all of them in the same turn.

Examples:

```txt
If Yan learns a new Flutter widget in flutter_app:
  update flutter_learning_progress.md.

If Yan implements Cubit in the work-focused project:
  update session_progress.md and possibly ROADMAP.md.

If Yan changes the project folder structure:
  update index.md.

If Yan analyzes how the real work project uses Dio/Cubit/repositories:
  update work_project_architecture_notes.md.

If Yan says a topic is for later mobile learning:
  update other_docs/mobile_specific_roadmap.md and keep it out of the immediate roadmap unless requested.
```

Never let docs become stale after moving files, changing paths, adding projects, or making architectural decisions.

## Documentation Map

Read these first in a new session:

```txt
AGENTS.md
projects/flutter_learning_introduction/flutter_learning_progress.md
projects/flutter_learning_introduction/flutter_app/pubspec.yaml
projects/new-project-to-learn-for-work/ROADMAP.md
projects/new-project-to-learn-for-work/work_project_architecture_notes.md
projects/new-project-to-learn-for-work/session_progress.md
projects/new-project-to-learn-for-work/content_hub/pubspec.yaml
```

Use `projects/flutter_learning_introduction/flutter_learning_progress.md` for what Yan already learned.

Use `projects/flutter_learning_introduction/flutter_app` as the actual Flutter basics app source.

Use `projects/new-project-to-learn-for-work/ROADMAP.md` for what to build next.

Use `projects/new-project-to-learn-for-work/work_project_architecture_notes.md` to keep guidance aligned with the real job project.

Use `projects/new-project-to-learn-for-work/session_progress.md` to know what has already been decided and what to implement next.

Use `projects/new-project-to-learn-for-work/content_hub` as the actual work-focused Flutter app source.

Use `other_docs/mobile_specific_roadmap.md` only as a later-stage reference for mobile-specific topics, not as the immediate learning plan.
