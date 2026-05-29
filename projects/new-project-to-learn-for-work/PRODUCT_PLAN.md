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

Later versions add creator/admin workflows:

- content creators can create courses
- content creators can manage lessons
- admins can review/publish content
- users can consume published courses

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

### Content Creator

The creator is a later user type.

Creator goals:

- create course draft
- add course metadata
- upload or attach lesson media
- organize lesson order
- publish/unpublish course
- view basic engagement stats

### Admin

The admin is optional and later-stage.

Admin goals:

- manage users
- manage published content
- review creator submissions
- moderate unsafe or invalid content

## Core Product Rules

- A user can sign up with email/password.
- A signed-in user lands on the authenticated home screen.
- A signed-out user lands on login/signup.
- Course metadata comes from an API/repository.
- Video/media files are not stored inside the app repository.
- Progress is associated with a signed-in user.
- Saved courses are associated with a signed-in user.
- Creator features should not block the student MVP.

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

### Firebase Auth User

Firebase owns auth identity.

Important fields:

- `uid`
- `email`
- `displayName`
- `emailVerified`
- `metadata.creationTime`
- `metadata.lastSignInTime`

Firebase Auth should not become the full app database.

### App User Profile

Stored later in Strapi or another backend.

Fields:

- `id`
- `firebaseUid`
- `name`
- `email`
- `role`
- `avatarUrl`
- `createdAt`
- `updatedAt`

Roles:

- `student`
- `creator`
- `admin`

### Course

Fields:

- `id`
- `title`
- `description`
- `thumbnailUrl`
- `creatorId`
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
9. Add Firebase email verification.
10. Add creator mode.

## Production Requirements

### Authentication

Required:

- email/password signup
- email/password login
- logout
- session restore
- auth loading/error states
- form validation
- Firebase Auth error mapping

Recommended before production:

- email verification
- password reset
- account deletion path
- reauthentication for sensitive actions
- terms/privacy consent

### Authorization

Required when creator/admin features exist:

- user role
- protected creator routes
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

- auth session handled by Firebase
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
- creator upload/content rules

## App Flow

### Signed Out

```txt
App starts
Firebase initializes
AuthenticationCubit listens to authStateChanges
No user
AuthenticationUnauthenticated
Show LoginPage
```

### Signup

```txt
User fills signup form
Form validates locally
SignupFormCard calls AuthenticationCubit.signUp
Cubit emits AuthenticationLoading
Repository calls FirebaseAuth.createUserWithEmailAndPassword
Firebase creates user and signs user in
authStateChanges emits User
Cubit emits AuthenticationAuthenticated
App redirects to HomePage
```

### Login

```txt
User fills login form
Form validates locally
LoginFormCard calls AuthenticationCubit.signIn
Cubit emits AuthenticationLoading
Repository calls FirebaseAuth.signInWithEmailAndPassword
Firebase signs user in
authStateChanges emits User
Cubit emits AuthenticationAuthenticated
App redirects to HomePage
```

### Logout

```txt
User taps sign out
ProfilePage calls AuthenticationCubit.signOut
Repository calls FirebaseAuth.signOut
authStateChanges emits null
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
12. Email Verification Pending
13. Creator Dashboard
14. Creator Course Form
15. Creator Lesson Form

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
- Firebase Auth

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
- creator relation
- API permissions

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

### Phase 8: Creator Tools

Build:

- creator dashboard
- create/edit course
- create/edit lesson

Learning focus:

- roles
- forms
- protected UI
- protected backend actions

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
10. Email Verification Pending
11. Password Reset
12. Creator Dashboard
13. Creator Course Form
14. Creator Lesson Form

Prototype rule:

```txt
Prototype copy should describe user value, not implementation details.
Implementation notes belong in docs.
```

