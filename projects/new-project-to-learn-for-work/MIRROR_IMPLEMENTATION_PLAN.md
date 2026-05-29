# Mirror Implementation Plan

This document defines how `Content Hub` should mirror the real work project.

Real work project:

```txt
/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front
```

Target learning architecture:

```txt
Flutter UI
  -> Cubit
    -> Repository
      -> ApiClient / HesedApi-style service
        -> Dio
          -> Strapi backend
            -> JSON models
```

Firebase is not the main backend model to mirror. In the work project, Firebase is mainly supporting infrastructure such as messaging, analytics, remote config, and tooling. The app's main data/auth flow is API-driven.

## What To Mirror

Mirror these work-project patterns first:

- Cubit-based state management
- repository layer between Cubit and API
- central Dio API service
- typed JSON models
- Strapi-like response shapes
- auth token/JWT flow
- loading/success/error states
- provider-based dependency injection

Do not start with:

- full creator dashboard
- real video upload
- offline downloads
- push notifications
- analytics
- remote config
- deep links

Those are important, but not MVP-core.

## Backend Autogeneration

The backend should be generated with Strapi.

Strapi is a Node.js headless CMS. You define content types in the admin panel, and Strapi generates a backend around them.

When you create a content type, Strapi can generate:

- database tables
- admin CRUD screens
- REST API endpoints
- controllers
- services
- route definitions
- permissions UI
- media upload integration

Example content type:

```txt
Course
```

Can produce endpoints like:

```txt
GET /api/courses
GET /api/courses/:id
POST /api/courses
PUT /api/courses/:id
DELETE /api/courses/:id
```

Example auth endpoints:

```txt
POST /api/auth/local/register
POST /api/auth/local
```

This is why we do not need to hand-code a full backend first. We define the content model, then Strapi gives us the admin panel and API baseline.

## MVP Product Scope

The first MVP should be student-first.

Build only:

1. Signup
2. Login
3. Session restore
4. Authenticated home
5. Course catalog
6. Course detail
7. Lesson detail
8. Profile/sign out

Content management happens through the Strapi admin panel.

That means the MVP content workflow is:

```txt
Open Strapi admin
Create course
Create lessons
Publish content
Flutter app fetches published content
```

Do not build creator screens in Flutter for the MVP.

This product is not an open creator marketplace right now. Public users register as students/learners only.

## MVP Screen And Prototype Map

Each backend/app feature should have a screen target. This keeps the implementation practical instead of becoming abstract architecture practice.

Use prototypes as visual references, but do not let prototype copy mention implementation details like Strapi, Firebase, Dio, Cubit, or API.

### Signed-Out Auth

Screens:

```txt
LoginPage
SignupPage
```

Current prototype references:

```txt
prototypes/login_modern_editorial.html
prototypes/signup_modern_editorial.html
```

Build when working on:

- signup form
- login form
- auth loading state
- auth error state
- navigation between login and signup

Backend feature:

```txt
POST /api/auth/local/register
POST /api/auth/local
```

### Authenticated Home

Screen:

```txt
AuthenticatedHomePage
```

Current prototype reference:

```txt
prototypes/home_authenticated_modern_editorial.html
```

Build when working on:

- session restore
- first signed-in screen
- continue learning summary
- saved courses summary
- progress summary

Backend features:

```txt
GET /api/courses
GET /api/progresses
GET /api/saved-courses
```

For MVP, this can start with static/mock data.

### Course Catalog

Screen:

```txt
CourseCatalogPage
```

Prototype reference:

```txt
prototypes/course_catalog_modern_editorial.html
```

Build when working on:

- course list
- loading state
- empty state
- error state
- pull/refresh later

Backend feature:

```txt
GET /api/courses
```

### Course Detail

Screen:

```txt
CourseDetailPage
```

Prototype reference:

```txt
prototypes/course_detail_modern_editorial.html
```

Build when working on:

- selected course details
- lesson list preview
- save course action
- continue/start course action

Backend features:

```txt
GET /api/courses/:id
GET /api/lessons?filters[course][id][$eq]=:courseId
```

### Lesson Detail / Player

Screen:

```txt
LessonDetailPage
```

Prototype reference:

```txt
prototypes/lesson_detail_modern_editorial.html
```

Build when working on:

- lesson content
- video placeholder/player
- mark complete
- progress update

Backend features:

```txt
GET /api/lessons/:id
POST/PUT /api/progresses
```

### Profile

Screen:

```txt
ProfilePage
```

Prototype reference:

```txt
prototypes/profile_modern_editorial.html
```

Build when working on:

- user account info
- sign out
- saved/progress summary
- account settings later

Backend features:

```txt
GET /api/users/me
GET /api/progresses
GET /api/saved-courses
```

### Saved Courses

Screen:

```txt
SavedCoursesPage
```

Prototype reference:

```txt
prototypes/saved_courses_modern_editorial.html
```

Build when working on:

- saved course list
- removing saved courses
- opening a saved course

Backend features:

```txt
GET /api/saved-courses
POST /api/saved-courses
DELETE /api/saved-courses/:id
```

### Progress

Screen:

```txt
ProgressPage
```

Prototype reference:

```txt
prototypes/progress_modern_editorial.html
```

Build when working on:

- lesson completion
- progress history
- course progress percentage

Backend features:

```txt
GET /api/progresses
POST/PUT /api/progresses
```

### Settings

Screen:

```txt
SettingsPage
```

Prototype reference:

```txt
prototypes/settings_modern_editorial.html
```

Build when working on:

- user preferences
- download preferences
- notification preferences later

Backend/local features:

```txt
local settings storage
notification permissions later
```

### Password Reset

Screen:

```txt
PasswordResetPage
```

Prototype reference:

```txt
prototypes/password_reset_modern_editorial.html
```

Build later, after normal login/signup works.

Backend feature depends on final auth approach:

```txt
Strapi users-permissions password reset flow
```

### Account Confirmation Pending

Screen:

```txt
AccountConfirmationPendingPage
```

Prototype reference:

```txt
prototypes/account_confirmation_pending_modern_editorial.html
```

Build only if account confirmation is enabled in Strapi auth.

Backend feature:

```txt
Strapi users-permissions email confirmation flow
```

### Internal Content Management

Do not build these screens in Flutter for the MVP.

Use Strapi admin first:

```txt
Strapi Admin -> Course CRUD
Strapi Admin -> Lesson CRUD
```

If this ever becomes a marketplace-style product, then creator screens can be planned later as a separate product track:

```txt
creator applications
creator approval
creator dashboard
course submission
admin review
```

That track is out of scope for the work-project mirror MVP.

## Backend MVP

Create a backend beside the Flutter app:

```txt
projects/new-project-to-learn-for-work/content_hub_api
```

Use Strapi for this backend.

First content types:

```txt
Course
Lesson
```

Optional later content types:

```txt
Category
Progress
SavedCourse
AppUserProfile
```

## Course Content Type

Fields:

```txt
title: text, required
description: rich text or long text
thumbnail: media, optional
category: text or relation later
difficulty: enum or text
durationMinutes: number
publishedAt: Strapi draft/publish field
```

Keep it simple first. Do not over-model.

## Lesson Content Type

Fields:

```txt
title: text, required
description: long text
order: number
durationMinutes: number
videoUrl: text, optional
course: relation to Course
isPreview: boolean
```

For the first MVP, `videoUrl` can be a placeholder. Real upload/playback can come later.

## Flutter MVP Layers

The Flutter app should have these layers.

### API Layer

Create a central API client:

```txt
lib/services/content_hub_api.dart
```

or:

```txt
lib/services/api_client.dart
```

Purpose:

- configure Dio
- set `baseUrl`
- add auth token later
- add logging in development
- expose endpoint methods

This mirrors the work project's `HesedAPI`.

### Repository Layer

Create repositories:

```txt
lib/repositories/auth_repository.dart
lib/repositories/courses_repository.dart
lib/repositories/lessons_repository.dart
```

Repositories should hide API details from Cubits.

Bad:

```txt
Widget -> Dio
```

Good:

```txt
Widget -> Cubit -> Repository -> API -> Dio
```

### Cubit Layer

Create Cubits:

```txt
lib/cubits/authentication_cubit
lib/cubits/courses_cubit
lib/cubits/course_detail_cubit
```

Each Cubit should emit explicit states:

```txt
Initial
Loading
Loaded
Failure
```

### Model Layer

Create typed models:

```txt
lib/models/course.dart
lib/models/lesson.dart
lib/models/data.dart
lib/models/paged_response.dart
```

Strapi usually wraps responses, so learn this shape early:

```txt
PagedResponse<Course>
  -> List<Data<Course>>
    -> id
    -> attributes
```

## Firebase Role In This Learning Project

Current Firebase Auth code is useful as a learning detour, but it is not the final target if the goal is to mirror the work project.

Target role for Firebase later:

- Firebase Cloud Messaging
- local notifications integration
- Analytics
- Remote Config
- Crashlytics or diagnostics if useful

Target role for Strapi/API:

- signup/login
- JWT auth token
- courses
- lessons
- progress
- saved courses
- roles

## Step-By-Step Build Order

### Step 1: Update The Plan

Document that:

- Firebase Auth is temporary learning code.
- Strapi auth/JWT is the target mirror.
- Strapi is the generated backend.
- Firebase comes later for mobile infrastructure.

Done when:

```txt
PRODUCT_PLAN.md and session docs no longer imply Firebase Auth is the final architecture.
```

### Step 2: Create The Strapi Backend

Create:

```txt
projects/new-project-to-learn-for-work/content_hub_api
```

Use Strapi.

Done when:

```txt
Strapi runs locally.
The admin panel opens.
The project has an admin user.
```

### Step 3: Create Course And Lesson Content Types

In Strapi admin:

1. Create `Course`.
2. Create `Lesson`.
3. Add relation from `Lesson` to `Course`.
4. Add a few fake courses.
5. Add lessons under those courses.
6. Publish them.

Done when:

```txt
The Strapi admin has visible courses and lessons.
```

### Step 4: Enable Public Read Permissions

In Strapi permissions:

```txt
Public role -> Course -> find, findOne
Public role -> Lesson -> find, findOne
```

Done when:

```txt
GET /api/courses works in browser/Postman/curl.
GET /api/lessons works in browser/Postman/curl.
```

### Step 5: Add Dio To Flutter

In the Flutter app:

```txt
content_hub
```

Add Dio.

Done when:

```txt
pubspec.yaml includes dio.
flutter pub get succeeds.
```

### Step 6: Create The API Service

Create:

```txt
lib/services/content_hub_api.dart
```

First methods:

```txt
getCourses()
getCourse(courseId)
getLessonsByCourse(courseId)
```

Done when:

```txt
The API service can call Strapi and return raw response data.
```

### Step 7: Create Models

Create:

```txt
Course
Lesson
Data<T>
PagedResponse<T>
```

Start manually if needed. Later add:

```txt
json_serializable
build_runner
```

Done when:

```txt
Raw Strapi JSON can become typed Dart objects.
```

### Step 8: Create CoursesRepository

Create:

```txt
lib/repositories/courses_repository.dart
```

Purpose:

```txt
CoursesRepository calls ContentHubApi and returns typed course models.
```

Done when:

```txt
Cubit does not know about Dio or raw JSON.
```

### Step 9: Create CoursesCubit

Create:

```txt
CoursesInitial
CoursesLoading
CoursesLoaded
CoursesFailure
```

Done when:

```txt
CoursesCubit can load courses through CoursesRepository.
```

### Step 10: Render Course Catalog

Create or update a course catalog page.

Prototype reference:

```txt
prototypes/course_catalog_modern_editorial.html
```

UI should handle:

- loading
- error
- empty
- loaded list

Done when:

```txt
Courses created in Strapi appear in the Flutter app.
```

### Step 11: Course Detail And Lesson List

Add:

```txt
CourseDetailPage
LessonList
```

Prototype references:

```txt
prototypes/course_detail_modern_editorial.html
prototypes/lesson_detail_modern_editorial.html
```

Done when:

```txt
Tapping a course opens its detail page with lessons from Strapi.
```

### Step 12: Replace Firebase Auth With Strapi Auth

After course fetching works, move auth to the Strapi-like flow.

Implement:

```txt
POST /api/auth/local/register
POST /api/auth/local
JWT storage
Dio auth interceptor
sign out clears token
session restore reads token
```

Done when:

```txt
Signup/login use Strapi API.
Firebase Auth is removed or clearly marked as a past learning experiment.
```

Screen references:

```txt
LoginPage -> prototypes/login_modern_editorial.html
SignupPage -> prototypes/signup_modern_editorial.html
AuthenticatedHomePage -> prototypes/home_authenticated_modern_editorial.html
ProfilePage -> prototypes/profile_modern_editorial.html
```

## Rule For Every Feature

For each new feature, build in this order:

```txt
1. Prototype/mock UI
2. Model
3. Repository method
4. Cubit state
5. Cubit method
6. UI loading/error/loaded rendering
7. Real API wiring
```

This prevents the app from becoming random widget code with API calls sprinkled everywhere.
