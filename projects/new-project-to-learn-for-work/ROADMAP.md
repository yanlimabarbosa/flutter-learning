# Cubit Work-Project Learning Roadmap

This project exists to learn the architecture used in:

`/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front`

The work project mostly uses:

```txt
flutter_bloc package
Cubit, not classic Bloc
RepositoryProvider / BlocProvider
BlocBuilder / BlocConsumer / BlocListener
Dio
Repository Pattern
json_serializable models
HydratedCubit
ValueNotifier and setState for small/local state
```

The goal is not to learn every Flutter pattern.

The goal is to become comfortable with the exact style needed for the work project.

## App To Build

Build a small app called:

```txt
Content Hub
```

It should mimic the work app at a smaller scale:

- Login screen
- Home screen
- Courses/content list
- Course/content detail
- Favorites
- Downloads/offline saved items
- Settings
- Theme preference
- Basic deep-link-like navigation simulation

The app should use public/mock data at first. Later it can use a local Mockoon API or a simple fake repository.

Later, evolve it into a more realistic clone of the work project's backend style:

```txt
Flutter app -> Dio -> Strapi API -> JSON models -> Cubits/UI
```

Then add Firebase for mobile/backend integrations:

```txt
Firebase Auth
Firebase Messaging
Firebase Analytics
Firebase Crashlytics or Sentry-style error tracking comparison
```

This will make the side project cover the same kind of skills used in the job project.

## Target Architecture

Use this structure:

```txt
lib/
  main.dart
  app.dart

  services/
    api_client.dart

  models/
    auth_user.dart
    course.dart
    lesson.dart
    favorite_item.dart

  repositories/
    auth_repository.dart
    courses_repository.dart
    favorites_repository.dart
    downloads_repository.dart

  cubits/
    authentication_cubit/
      authentication_cubit.dart
      authentication_state.dart
    courses_cubit/
      courses_cubit.dart
      courses_state.dart
    course_detail_cubit/
      course_detail_cubit.dart
      course_detail_state.dart
    favorites_cubit/
      favorites_cubit.dart
      favorites_state.dart
    settings_cubit/
      settings_cubit.dart
      settings_state.dart

  views/
    pages/
      login_page.dart
      home_page.dart
      courses_page.dart
      course_detail_page.dart
      favorites_page.dart
      settings_page.dart
    widgets/
      course_card.dart
      app_error_view.dart
      app_loading_view.dart
      app_empty_view.dart
```

This mirrors the work project without copying its full complexity.

## Phase 1: Create The App And Baseline UI

Goal:

Create the Flutter project and build static screens first.

Commands:

```bash
cd /home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work
fvm flutter create .
```

Add pages:

- `LoginPage`
- `HomePage`
- `CoursesPage`
- `CourseDetailPage`
- `FavoritesPage`
- `SettingsPage`

Learn:

- `MaterialApp`
- `Scaffold`
- `Navigator.push`
- `Navigator.pushReplacement`
- `NavigationBar`
- extracting widgets

Do not add Cubit yet.

The first goal is to have screens moving around.

## Phase 2: Add flutter_bloc And First Cubit

Add:

```yaml
flutter_bloc
```

Create:

```txt
AuthenticationCubit
AuthenticationState
```

States:

```dart
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}
final class AuthenticationLoading extends AuthenticationState {}
final class Authenticated extends AuthenticationState {
  final AuthUser user;
}
final class Unauthenticated extends AuthenticationState {}
final class AuthenticationFailure extends AuthenticationState {
  final String message;
}
```

Cubit methods:

```dart
Future<void> login(String email, String password)
Future<void> logout()
void checkSession()
```

Learn:

- `Cubit<State>`
- `emit(...)`
- `BlocProvider`
- `BlocBuilder`
- `BlocConsumer`
- `context.read<MyCubit>()`
- `context.watch<MyCubit>()`

React mental model:

```txt
Cubit = store/controller with actions
State classes = discriminated union-ish states
BlocBuilder = subscriber that rebuilds UI
BlocConsumer = subscriber + side effects
```

## Phase 3: RepositoryProvider And AuthRepository

Create:

```txt
AuthRepository
```

Move fake login logic out of the Cubit.

Flow:

```txt
LoginPage
  -> AuthenticationCubit.login(...)
    -> AuthRepository.login(...)
      -> returns AuthUser
```

Provide it:

```dart
MultiRepositoryProvider(
  providers: [
    RepositoryProvider(create: (_) => AuthRepository()),
  ],
  child: MultiBlocProvider(...),
)
```

Learn:

- `RepositoryProvider`
- why Cubit should not own all data logic
- dependency injection through context
- why the work project creates repositories and Cubits separately

## Phase 4: Dio ApiClient

Add:

```yaml
dio
```

Create:

```txt
services/api_client.dart
```

It should configure:

- base URL
- timeouts
- headers
- simple logging interceptor

Example:

```dart
class ApiClient {
  late final Dio dio;

  ApiClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://example.com',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }
}
```

Flow:

```txt
CoursesCubit
  -> CoursesRepository
    -> ApiClient.dio.get(...)
```

Learn:

- why work project uses Dio instead of `http`
- interceptors
- base URL
- response parsing
- error handling

## Phase 5: Models And json_serializable

Add:

```yaml
json_annotation

dev_dependencies:
  build_runner
  json_serializable
```

Create models:

```txt
Course
Lesson
AuthUser
```

Example:

```dart
@JsonSerializable()
class Course {
  final int id;
  final String title;
  final String description;

  Course({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) =>
      _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
```

Generate:

```bash
fvm dart run build_runner build --delete-conflicting-outputs
```

Learn:

- `part 'course.g.dart';`
- generated `fromJson`
- generated `toJson`
- why generated parsing is common in production Flutter
- difference from manual `fromJson`

## Phase 6: CoursesCubit With Loading/Error/Data

Create:

```txt
CoursesCubit
CoursesState
CoursesRepository
CoursesPage
CourseCard
```

States:

```dart
sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}
final class CoursesLoading extends CoursesState {}
final class CoursesLoaded extends CoursesState {
  final List<Course> courses;
}
final class CoursesFailure extends CoursesState {
  final String message;
}
```

Cubit:

```dart
Future<void> getCourses() async {
  emit(CoursesLoading());

  try {
    final courses = await _repository.getCourses();
    emit(CoursesLoaded(courses));
  } catch (_) {
    emit(CoursesFailure('Could not load courses'));
  }
}
```

UI:

```txt
CoursesLoading -> loading widget
CoursesFailure -> error widget
CoursesLoaded -> list of CourseCard
```

Learn:

- this replaces `FutureBuilder` for production-style screens
- Cubit owns async state
- UI only reacts to state

## Phase 7: Refresh And Pagination

Add:

- pull-to-refresh
- load next page when scrolling near bottom
- keep existing list when loading next page

State:

```dart
final class CoursesLoaded extends CoursesState {
  final List<Course> courses;
  final bool isLoadingMore;
  final bool hasReachedEnd;
}
```

Cubit methods:

```dart
Future<void> getCourses()
Future<void> getNextPage()
Future<void> refreshCourses()
```

Learn:

- the pattern used in the work project's `CoursesCubit`
- storing `_currentPage`
- storing cached `_data`
- avoiding duplicate requests

## Phase 8: BlocConsumer For Login

Use `BlocConsumer` on the login screen.

Use `listener` for side effects:

- navigate after success
- show snackbar after error

Use `builder` for UI:

- disable button while loading
- show spinner

Learn:

```txt
BlocBuilder = UI only
BlocListener = side effects only
BlocConsumer = both
```

This is extremely important for the work project.

## Phase 9: FavoritesCubit

Create:

```txt
FavoritesCubit
FavoritesRepository
FavoritesPage
```

Start in memory:

```dart
final List<Course> _favorites = [];
```

Methods:

```dart
void addFavorite(Course course)
void removeFavorite(int courseId)
bool isFavorite(int courseId)
```

Learn:

- optimistic UI
- shared app state
- one Cubit being used by multiple screens

## Phase 10: HydratedCubit

Add:

```yaml
hydrated_bloc
path_provider
```

Convert one Cubit to `HydratedCubit`.

Good candidates:

- `SettingsCubit`
- `FavoritesCubit`

Learn:

- persisted Cubit state
- `fromJson`
- `toJson`
- app restart keeps state

This maps directly to the work project's persisted Bible reading/settings Cubits.

## Phase 11: Local Storage Repository

Add local persistence for downloads/offline items.

Pick one:

```yaml
hive
hive_flutter
```

Create:

```txt
DownloadsRepository
```

Methods:

```dart
Future<void> saveCourse(Course course)
Future<void> removeCourse(int id)
List<Course> getDownloadedCourses()
```

Learn:

- local repository
- async initialization
- box/storage opening
- difference between remote repository and local repository

This maps to the work project's download repositories.

## Phase 12: SettingsCubit

Create app settings:

- theme mode: system/light/dark
- compact list mode
- fake notification toggle

Use:

```txt
SettingsCubit extends HydratedCubit<SettingsState>
```

Learn:

- persisted preferences
- app-wide Cubit
- root `MaterialApp` reacting to Cubit state

## Phase 13: Error Handling Pattern

Improve API errors.

Create:

```txt
AppException
NetworkException
UnauthorizedException
ServerException
```

Repository catches Dio errors and throws app-level exceptions.

Cubit converts exceptions into user-friendly states.

Flow:

```txt
DioException
  -> Repository maps to AppException
    -> Cubit emits Failure(message)
      -> UI displays message
```

Learn:

- do not show raw technical errors to users
- keep Dio-specific errors out of UI

## Phase 14: Authentication Token Flow

Add fake token storage.

Flow:

```txt
login -> repository returns token
AuthRepository stores token
ApiClient interceptor attaches token
logout removes token
```

Learn:

- authorization headers
- interceptors
- authenticated vs unauthenticated state
- root app reacting to auth state

This maps strongly to `HesedAPI` and `AuthenticationRepository`.

## Phase 14.5: Replace Fake API With Strapi

Goal:

Use Strapi because the work project's API shape strongly resembles a Strapi-style backend:

```txt
data
attributes
meta
pagination
populate
filters
sort
```

Build or run a local Strapi backend with content types:

```txt
Course
Lesson
Banner
Category
Favorite-like relation or saved item
```

Example endpoints:

```txt
GET /api/courses?populate=*&pagination[page]=1&pagination[pageSize]=10
GET /api/courses/:id?populate=*
GET /api/lessons?filters[course][id][$eq]=1&populate=*
```

Update the Flutter app to parse Strapi-style wrappers:

```txt
PagedResponse<T>
Data<T>
Meta
Pagination
```

This should mirror the work project models:

```txt
models/core/data.dart
models/core/paged_response.dart
```

Learn:

- Strapi REST response shape
- `populate=*`
- nested `attributes`
- pagination metadata
- query parameters with Dio
- API models that wrap real content models
- why the work project has `Data<T>` and `PagedResponse<T>`

Important objective:

After this phase, the app should feel structurally similar to the work project:

```txt
CoursesRepository.getCourses()
  -> ApiClient.dio.get('courses', queryParameters: {...})
    -> PagedResponse<Course>.fromJson(...)
      -> CoursesCubit emits CoursesLoaded(...)
```

## Phase 14.6: Strapi Auth Flow

Before Firebase Auth, implement Strapi auth to understand the work project's token-based flow.

Endpoints:

```txt
POST /api/auth/local
POST /api/auth/local/register
```

Learn:

- login with identifier/password
- receive JWT
- store JWT locally
- attach JWT with Dio interceptor
- logout by clearing local token
- authenticated requests
- `401 Unauthorized` handling

This maps directly to the work project's `AuthenticationRepository` and `HesedAPI` authorization interceptor.

## Phase 15: Deep Link Simulation

You do not need real app links first.

Start with a text field or debug button:

```txt
contenthub://course/123
```

Parse it and navigate to:

```txt
CourseDetailPage(courseId: 123)
```

Then later add:

```yaml
app_links
```

Learn:

- route intent
- Cubit/service receives external event
- app opens correct screen

## Phase 17: Firebase Auth

Goal:

Add Firebase Auth after the Strapi/token flow is understood.

Use:

```yaml
firebase_core
firebase_auth
```

Implement:

- email/password sign up
- email/password login
- logout
- auth state listener
- forgot password
- email verification flow

Learn:

- Firebase initialization
- platform config files
- auth state stream
- difference between Firebase session auth and manual JWT auth
- how auth state can drive app navigation

Important comparison:

```txt
Strapi auth: app stores backend JWT and sends it through Dio
Firebase auth: Firebase SDK manages user/session and exposes auth state
```

## Phase 18: Firebase Cloud Messaging

Goal:

Learn push notifications, because the work project uses Firebase Messaging and local notifications.

Use:

```yaml
firebase_messaging
flutter_local_notifications
permission_handler
```

Implement:

- request notification permission
- get FCM token
- handle foreground messages
- handle background messages
- show local notification
- tap notification and navigate to a screen

Learn:

- Android notification permission
- iOS notification permission conceptually
- foreground vs background messages
- notification tap routing
- why push notification setup lives near app bootstrap/services

## Phase 19: Firebase Analytics And Error Tracking

Goal:

Learn app observability basics.

Use:

```yaml
firebase_analytics
```

Optional:

```yaml
firebase_crashlytics
```

Also compare with the work project's Sentry usage.

Implement:

- track screen views
- track login event
- track course opened event
- track favorite added event
- capture/report test error

Learn:

- analytics service wrapper
- event naming
- crash/error reporting
- why production apps initialize monitoring in `main.dart`

## Phase 16: Tests

Add tests after the core flow works.

Test:

- repository returns parsed models
- Cubit emits `Loading -> Loaded`
- Cubit emits `Loading -> Failure`
- login success navigates
- favorites persist

Useful packages:

```yaml
bloc_test
mocktail
```

## What Not To Study First

Do not focus on classic event-based Bloc yet.

Do not start with:

```dart
class SomeBloc extends Bloc<SomeEvent, SomeState>
```

Your work project does not use that style.

Study this first:

```dart
class SomeCubit extends Cubit<SomeState>
```

## Minimum Skill Checklist

You are ready to work more comfortably in the work project when you can build this without copying:

- Create a Cubit
- Create Cubit state classes
- Provide a Cubit with `BlocProvider`
- Read a Cubit with `context.read<T>()`
- Render state with `BlocBuilder`
- Navigate/show snackbar with `BlocListener` or `BlocConsumer`
- Create a repository
- Provide a repository with `RepositoryProvider`
- Inject a repository into a Cubit
- Use Dio through a central API client
- Parse data into generated models
- Use `json_serializable`
- Persist settings with `HydratedCubit`
- Persist records with a local repository
- Separate local UI state from app/business state

## Recommended Study Order

Study in this exact order:

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
16. Strapi auth and JWT
17. deep links
18. Firebase Auth
19. Firebase Cloud Messaging/local notifications
20. analytics/error tracking
21. tests
```

## Final Mental Model

For the work project, think:

```txt
Widget does not fetch directly.
Widget calls Cubit method.
Cubit controls state.
Cubit asks Repository for data.
Repository asks API/local storage.
API uses Dio.
Model parses JSON.
Cubit emits result.
Widget rebuilds.
```

That is the main pattern to master.
