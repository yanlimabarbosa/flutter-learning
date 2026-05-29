# Content Hub Product Plan

This document defines what `Content Hub` is as a product, not only as a Flutter learning project.

The app should stay small enough to build while learning, but realistic enough to teach the same patterns used in the work project:

```txt
UI -> Cubit -> Repository -> API/Firebase/local storage -> Models
```

## Product Description

`Content Hub` is a mobile learning platform where users can discover, save, and continue learning from structured course content.

The first version is student-first:

- create an account
- sign in and restore a session
- browse learning content
- save content
- continue lessons
- track basic progress
- manage profile/account

Content management is internal:

- admins/content managers use the Strapi admin panel in the browser
- admins create courses
- admins create lessons
- admins publish/unpublish content
- mobile users consume published courses

The MVP is not an open creator marketplace. Users cannot register as content creators from the mobile app.

The product is intentionally shaped like a small course/content app because it gives useful practice with auth, lists, detail pages, forms, remote data, local persistence, media, roles, and API architecture.

## Product Positioning

Short version:

```txt
A mobile learning hub for saving courses, continuing lessons, and tracking study progress across devices.
```

Longer version:

```txt
Content Hub helps learners keep a personal library of courses and lessons, continue where they stopped, and sync their learning progress between devices.
```

Do not describe implementation details in the UI. Words like Firebase, Strapi, API, Cubit, or local cache belong in docs, not product copy.

## Primary Users

### Student

The student is the first user type to build.

Student goals:

- create account
- sign in
- browse courses
- open course details
- view lesson list
- continue current lesson
- save courses
- track progress
- manage profile

### Internal Content Manager

The content manager is not a public mobile-app user type in the MVP.

Content manager goals:

- use Strapi admin in the browser
- create course draft
- add course metadata
- upload thumbnails or attach media URLs
- organize lesson order
- publish/unpublish courses

### Admin

The admin is handled through Strapi admin for the MVP.

Admin goals:

- manage users
- manage published content
- manage course/lesson records
- configure permissions

## Core Product Rules

- A user can sign up with email/password.
- A signed-in user lands on the authenticated home screen.
- A signed-out user lands on login/signup.
- Course metadata comes from an API/repository.
- Video/media files are not stored inside the app repository.
- Progress is associated with a signed-in user.
- Saved courses are associated with a signed-in user.
- Content creation happens in Strapi admin, not in the Flutter app.
- Public creator registration is out of scope.

## Content And Video Storage Model

Videos should not live directly in the Flutter app or Git repository.

Recommended model:

```txt
Video/media file -> storage/video provider
Course/lesson metadata -> backend/API
Flutter app -> fetch metadata and display/play media URL
```

Possible storage providers:

- Strapi Media Library for learning/local prototype
- Firebase Storage for simple Firebase-based experiments
- Cloudflare R2/S3 for object storage
- Mux/Vimeo for more production-grade video workflows

Learning recommendation:

```txt
Start with fake/mock course data.
Then use Strapi for course/lesson metadata.
Only add real media upload/playback after the API flow is solid.
```

## Data Model

### Authenticated User

Target mirror: Strapi/API owns the app auth flow through email/password and JWT.

Firebase Auth may stay temporarily as a learning experiment, but it is not the final architecture to mirror from the work project.

Important fields:

- `id`
- `email`
- `username`
- `confirmed`
- `blocked`
- `jwt`
- `createdAt`
- `updatedAt`

The Flutter app should treat auth as an API/repository concern, not as direct widget code.

### App User Profile

Stored later in Strapi or another backend.

Fields:

- `id`
- `userId`
- `name`
- `email`
- `role`
- `avatarUrl`
- `createdAt`
- `updatedAt`

Roles:

- `student`
- `admin`

### Course

Fields:

- `id`
- `title`
- `description`
- `thumbnailUrl`
- `category`
- `difficulty`
- `durationMinutes`
- `published`
- `createdAt`
- `updatedAt`

### Lesson

Fields:

- `id`
- `courseId`
- `title`
- `description`
- `order`
- `durationMinutes`
- `videoUrl`
- `isPreview`

### Progress

Fields:

- `id`
- `userId`
- `courseId`
- `lessonId`
- `completed`
- `lastPositionSeconds`
- `updatedAt`

### Saved Course

Fields:

- `id`
- `userId`
- `courseId`
- `createdAt`

## MVP Scope

Build this first:

1. Login page
2. Signup page
3. Authenticated home page
4. Profile page with sign out
5. Static course list
6. Static course detail
7. Static lesson detail

The first MVP can use hardcoded/mock data. The goal is to make navigation, auth, and state architecture clear before adding real APIs.

## Post-MVP Scope

After the MVP:

1. Replace hardcoded courses with repository data.
2. Add Dio API client.
3. Add Strapi backend for courses and lessons.
4. Add JSON models and generated parsing.
5. Add favorites/saved courses.
6. Add progress tracking.
7. Add local persistence with HydratedCubit or another local storage option.
8. Add offline-ready saved content metadata.
9. Add account confirmation/password reset if needed.
10. Add internal content workflow documentation for Strapi admin.

## Production Requirements

### Authentication

Required:

- email/password signup
- email/password login
- logout
- session restore
- auth loading/error states
- form validation
- API/Firebase error mapping during the transition
- final Strapi/JWT error mapping

Recommended before production:

- email verification
- password reset
- account deletion path
- reauthentication for sensitive actions
- terms/privacy consent

### Authorization

Required when protected content or admin features exist:

- user role
- protected admin routes
- backend permission checks

Never rely only on UI hiding buttons. The backend must enforce roles.

### API

Required:

- Dio API client
- base URL config
- auth token handling
- request/response logging in development
- error normalization
- retry/timeout strategy
- typed models

### Course Content

Required:

- course list
- course detail
- lesson list
- lesson detail
- media URL handling
- loading, empty, and error states

### Media

Required before real video production:

- storage provider
- upload strategy
- playback strategy
- bandwidth/cost estimate
- access control for private content
- thumbnail generation or upload

### Local Persistence

Useful:

- auth session/JWT stored through the app auth repository
- saved UI preferences
- cached course metadata
- progress cache
- downloaded/offline metadata

Later:

- real offline video/download handling
- conflict resolution when syncing progress

### Observability

Required before production:

- crash/error tracking
- auth failure logging without leaking passwords
- API error logging
- analytics for signup/login/content open/progress

Potential tools:

- Firebase Analytics
- Crashlytics
- Sentry

### Security

Required:

- never log passwords
- validate on client and backend
- protect API endpoints
- secure file access for paid/private content
- avoid storing tokens manually unless required
- use HTTPS only

### Legal/Product

Required before real public launch:

- privacy policy
- terms of service
- content ownership rules
- user deletion/export path
- internal content publishing rules

## App Flow

### Signed Out

```txt
App starts
App initializes
AuthenticationCubit checks saved JWT/session
No valid session
AuthenticationUnauthenticated
Show LoginPage
```

### Signup

```txt
User fills signup form
Form validates locally
SignupFormCard calls AuthenticationCubit.signUp
Cubit emits AuthenticationLoading
Repository calls POST /api/auth/local/register
API returns user and JWT
Repository stores JWT/session
Cubit emits AuthenticationAuthenticated
App redirects to HomePage
```

### Login

```txt
User fills login form
Form validates locally
LoginFormCard calls AuthenticationCubit.signIn
Cubit emits AuthenticationLoading
Repository calls POST /api/auth/local
API returns user and JWT
Repository stores JWT/session
Cubit emits AuthenticationAuthenticated
App redirects to HomePage
```

### Logout

```txt
User taps sign out
ProfilePage calls AuthenticationCubit.signOut
Repository clears saved JWT/session
Cubit emits AuthenticationUnauthenticated
App redirects to LoginPage
```

## Screen List

Prototype all of these before full implementation:

1. Login
2. Signup
3. Authenticated Home
4. Profile
5. Course Catalog
6. Course Detail
7. Lesson Detail / Player
8. Saved Courses
9. Progress
10. Settings
11. Password Reset
12. Account Confirmation Pending, only if enabled in Strapi auth

## Implementation Plan

### Phase 1: Auth Foundation

Build:

- `AuthRepository`
- `AuthenticationCubit`
- auth states
- login form wiring
- signup form wiring
- loading/error UI
- redirect after auth
- sign out

Learning focus:

- `RepositoryProvider`
- `BlocProvider`
- `BlocBuilder`
- `BlocListener`
- Strapi auth/JWT as the target mirror
- Firebase Auth only as a temporary comparison if it remains in the app

### Phase 2: App Shell

Build:

- authenticated home
- bottom navigation or simple route structure
- profile page
- sign out action

Learning focus:

- navigation after auth
- app-level state
- separating signed-in and signed-out views

### Phase 3: Static Content

Build:

- course catalog from static/mock data
- course detail
- lesson detail
- saved courses UI

Learning focus:

- models without API
- lists/cards/detail navigation
- clean UI composition

### Phase 4: Repository Data

Build:

- `CoursesRepository`
- fake async loading
- `CoursesCubit`
- loading/success/failure states

Learning focus:

- work-project Cubit flow
- repository isolation
- error and empty states

### Phase 5: Dio API

Build:

- `ApiClient`
- Dio setup
- courses endpoint
- typed model parsing

Learning focus:

- HTTP architecture similar to work project
- interceptors/logging
- error handling

### Phase 6: Strapi

Build:

- local Strapi project
- course collection
- lesson collection
- lesson-to-course relation
- public read permissions for published content
- authenticated permissions for user-owned data later

Learning focus:

- backend CMS shape
- real API responses
- Strapi auth/JWT comparison with Firebase Auth

### Phase 7: Persistence

Build:

- saved courses
- progress tracking
- local cache

Learning focus:

- HydratedCubit/local storage
- persistence tradeoffs
- offline-ready patterns

### Phase 8: Strapi Admin Workflow

Document and practice:

- creating courses in Strapi admin
- creating lessons in Strapi admin
- relating lessons to courses
- publishing/unpublishing records
- checking generated REST responses

Learning focus:

- CMS-managed content
- generated backend APIs
- Strapi permissions
- why the Flutter app stays consumer-focused

### Phase 9: Media

Build:

- lesson video URL
- basic player
- upload/storage experiment

Learning focus:

- media storage
- streaming tradeoffs
- mobile playback

## Prototype Plan

Create prototypes in this order:

1. Login
2. Signup
3. Authenticated Home
4. Profile
5. Course Catalog
6. Course Detail
7. Lesson Detail
8. Saved Courses
9. Settings
10. Password Reset
11. Account Confirmation Pending, only if enabled

Prototype rule:

```txt
Prototype copy should describe user value, not implementation details.
Implementation notes belong in docs.
```

Prototype files:

```txt
prototypes/prototype_gallery.html
prototypes/login_modern_editorial.html
prototypes/signup_modern_editorial.html
prototypes/home_authenticated_modern_editorial.html
prototypes/profile_modern_editorial.html
prototypes/course_catalog_modern_editorial.html
prototypes/course_detail_modern_editorial.html
prototypes/lesson_detail_modern_editorial.html
prototypes/saved_courses_modern_editorial.html
prototypes/progress_modern_editorial.html
prototypes/settings_modern_editorial.html
prototypes/password_reset_modern_editorial.html
prototypes/account_confirmation_pending_modern_editorial.html
```
