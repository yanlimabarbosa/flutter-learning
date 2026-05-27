# Work Project Architecture Notes

Project analyzed:

`/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front`

## Short Answer

The work project is not pure Clean Architecture.

It is mostly a custom, pragmatic Flutter architecture based on:

- BLoC/Cubit for app/business state
- Repository Pattern for data access
- A centralized API service using Dio
- `json_serializable` model classes
- Provider-based dependency injection with `RepositoryProvider` and `BlocProvider`
- Some newer feature-first modules that are closer to Clean Architecture

Best label:

```txt
Hybrid layered Flutter architecture:
UI -> Cubit/Bloc -> Repository -> API/Service -> Models
```

Or shorter:

```txt
BLoC + Repository Pattern, with a hybrid layer-first/feature-first structure.
```

## Main Data Flow

The common flow looks like this:

```txt
Screen / Widget
  -> Cubit / Bloc
    -> Repository
      -> HesedAPI / Service
        -> Dio / native plugin / local storage
          -> JSON / database / platform result
            -> Model
```

Example from courses:

```txt
CoursesScreen
  -> CoursesCubit
    -> CoursesRepository
      -> HesedAPI
        -> Dio
          -> Course model
```

Relevant files:

- `lib/ui/screens/courses_screen/courses_screen.dart`
- `lib/blocs/courses_cubit/courses_cubit.dart`
- `lib/repositories/courses_repository.dart`
- `lib/services/hesed_api.dart`
- `lib/models/course/course.dart`

## Folder Structure

The project mixes two styles.

### Layer-First Structure

Most of the app uses broad technical folders:

```txt
lib/blocs
lib/models
lib/repositories
lib/services
lib/ui
lib/utils
lib/values
lib/resources
```

This means code is grouped by technical role.

Example:

```txt
All Cubits/Blocs live under lib/blocs
All models live under lib/models
Most screens live under lib/ui/screens
Most repositories live under lib/repositories
```

This is common in older or medium-sized Flutter apps.

### Feature-First Structure

Some newer areas use feature folders:

```txt
lib/features/download
lib/features/bible
```

Example:

```txt
lib/features/download/data
lib/features/download/domain
lib/features/download/presentation
```

This is closer to Clean Architecture because each feature owns its layers.

## Is It Clean Architecture?

Mostly, no.

Strict Clean Architecture usually has:

```txt
presentation
domain
data
```

And usually:

- domain entities
- repository interfaces in domain
- repository implementations in data
- use cases/interactors
- DTOs/data models separated from domain entities
- dependencies pointing inward

The work project does not consistently do that.

Most of the app:

- has concrete repositories directly under `lib/repositories`
- has no use-case layer
- passes API-shaped models into Cubits and UI
- uses a large centralized `HesedAPI`
- wires many dependencies directly in `RootScreen`

So it is layered, but not strict Clean Architecture.

## Clean-ish Parts

The `download` feature is the closest to Clean Architecture:

```txt
lib/features/download/domain/repositories/downloads_repository.dart
lib/features/download/data/repositories/downloads_repository_impl.dart
lib/features/download/presentation/manager
lib/features/download/presentation/widgets
```

This has:

- domain repository contract
- data repository implementation
- presentation Cubits/widgets

But it is still not perfectly clean because the domain layer imports a presentation type:

```dart
import '../../presentation/manager/downloadable_item/downloadable_item_cubit.dart';
```

In strict Clean Architecture, domain should not depend on presentation.

## State Management

The main state management library is:

```yaml
flutter_bloc
```

The project uses:

- `Cubit`
- `BlocBuilder`
- `BlocConsumer`
- `BlocListener`
- `MultiBlocProvider`
- `RepositoryProvider`
- `HydratedCubit`

Common state flow:

```txt
UI event
  -> Cubit method
    -> repository call
      -> emit loading/success/error state
        -> UI rebuilds through BlocBuilder/BlocConsumer
```

Example:

```txt
CoursesScreen calls _coursesCubit.getCourses()
CoursesCubit emits CoursesLoading
CoursesCubit awaits CoursesRepository.getCourses()
CoursesCubit emits CoursesLoaded or CoursesFailed
CoursesList rebuilds from Bloc state
```

## Local UI State

The app also uses `setState`.

This is normal.

`setState` is used for local screen/widget state such as:

- password visibility
- selected UI values
- local booleans
- temporary interaction states
- form field UI details
- small animation/display toggles

So the mental model is:

```txt
setState -> local UI-only state
Cubit/BLoC -> business/app/async state
ValueNotifier -> tiny shared reactive state
HydratedCubit -> persisted Cubit state
```

## ValueNotifier Usage

The project also uses `ValueNotifier`, `ValueListenableBuilder`, and `ListenableBuilder`.

Examples:

- foreground/background app state
- bottom navigation current index
- live service notifiers
- small global reactive values

This is not replacing BLoC. It is used for smaller reactive values where creating a full Cubit would be heavier.

## Dependency Injection

The app mainly uses provider-based dependency injection from `flutter_bloc`:

```dart
RepositoryProvider
BlocProvider
MultiRepositoryProvider
MultiBlocProvider
RepositoryProvider.of<T>(context)
BlocProvider.of<T>(context)
```

The root wiring is in:

```txt
lib/ui/screens/root_screen/root_screen.dart
```

`get_it` is listed in `pubspec.yaml`, but the inspected code mostly uses `RepositoryProvider` and `BlocProvider` rather than `get_it` as the main dependency injection system.

## API Layer

The main HTTP client is:

```yaml
dio
```

Related libraries:

```yaml
dio_cache_interceptor
dio_cache_interceptor_hive_store
sentry_dio
```

The central API class is:

```txt
lib/services/hesed_api.dart
```

It configures:

- base URL from remote config
- `Dio`
- authorization interceptor
- cache interceptor
- Sentry integration
- API request methods

Typical HTTP flow:

```txt
Repository method
  -> HesedAPI method
    -> _dio.get/post/put/delete
      -> response.data
        -> model.fromJson(...)
```

## Repository Layer

Repositories are usually concrete classes.

Example:

```dart
class CoursesRepository {
  final HesedAPI hesedAPI;

  Future<PagedResponse<Course>> getCourses(...) {
    return hesedAPI.getCourses(...);
  }
}
```

In many cases, repositories are thin wrappers around `HesedAPI`.

Their job is usually:

- expose feature-specific data methods
- hide direct API calls from Cubits
- sometimes coordinate local storage
- sometimes normalize data access

## Models

The project uses:

```yaml
json_serializable
json_annotation
build_runner
```

Models often look like:

```dart
@JsonSerializable(explicitToJson: true)
class Course {
  final String? title;

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
```

Generated files:

```txt
*.g.dart
```

These are created by `build_runner`.

Important difference from the learning app:

```txt
Learning app: manual fromJson / pattern matching
Work app: generated fromJson / toJson with json_serializable
```

## Persistence And Local Storage

The project uses several persistence tools:

```yaml
hive
hive_flutter
hydrated_bloc
shared_preferences
sqflite_sqlcipher
path_provider
```

Common uses:

- `Hive`: local boxes/cache/download metadata
- `HydratedBloc`: automatically persists Cubit state
- `shared_preferences`: simple key-value storage
- `sqflite_sqlcipher`: encrypted SQLite database
- `path_provider`: file paths for app storage

## Navigation

The project mostly uses classic Flutter navigation:

```dart
Navigator.push(...)
MaterialPageRoute(...)
```

It also has:

```yaml
app_links
```

For deep links.

It does not appear to use `go_router` as the main routing system.

So routing is more imperative:

```txt
button/action -> Navigator.push(...)
deep link -> Cubit/service decides what screen to open
```

This is different from React Router or Next.js App Router.

## Mobile-Specific Features In The Project

The app uses many mobile/platform-specific libraries:

```yaml
firebase_core
firebase_messaging
flutter_local_notifications
permission_handler
image_picker
image_cropper
app_links
flutter_inappwebview
webview_flutter
flutter_downloader
just_audio
audio_service
audio_session
app_tracking_transparency
device_info_plus
disk_space_plus
open_settings_plus
flutter_fgbg
wakelock_plus
flutter_timezone
```

These map to mobile concepts:

- push notifications
- local notifications
- permissions
- camera/gallery
- image cropper
- deep links
- WebViews
- downloads/files
- background/foreground app state
- audio playback/background audio
- tracking permission
- device info
- disk space
- system settings
- wakelock
- timezone

## Services

The `services` folder contains app-wide or platform-wide behavior:

```txt
HesedAPI
RemoteConfigService
PushNotificationsService
DonationService
LivesService
HiveService
SentryService
AnalyticsService
HesedAudioService
```

These are not purely data repositories. They are closer to app/system services.

Examples:

- configure push notifications
- configure Dio/API
- initialize Hive
- capture errors
- manage live updates
- initialize audio

## App Bootstrap

`main.dart` does substantial app bootstrapping:

- `WidgetsFlutterBinding.ensureInitialized()`
- orientation setup
- system UI setup
- HydratedBloc storage setup
- Firebase initialization
- Remote Config initialization
- Hive initialization
- Sentry initialization
- timezone setup
- API configuration
- push notification setup
- downloader setup
- audio service setup
- `runApp(RootScreen(...))`

This is closer to an app composition/bootstrap file than a simple UI entry.

## RootScreen Responsibility

`RootScreen` is a major composition root.

It:

- creates repositories
- creates Cubits
- provides them with `MultiRepositoryProvider`
- provides them with `MultiBlocProvider`
- builds `MaterialApp`
- handles splash video logic
- listens to foreground/background changes
- checks push notification permissions

This is practical, but large.

In stricter architecture, some of this setup might be split into:

- dependency injection module
- app bootstrap service
- notification coordinator
- app lifecycle service
- route/app shell file

## Strengths

- Clear use of Cubit/BLoC for state.
- Repositories keep many API calls out of UI.
- `Dio` is configured centrally.
- Models use generated JSON serialization.
- App uses real production mobile libraries.
- Many app-wide dependencies are provided through `RepositoryProvider` and `BlocProvider`.
- Newer feature folders show movement toward feature-first architecture.

## Weaknesses / Tradeoffs

- Not strict Clean Architecture.
- `HesedAPI` is very large and centralizes many unrelated endpoints.
- `RootScreen` has many responsibilities.
- Repositories are often thin wrappers over `HesedAPI`.
- API-shaped models leak into Cubits/UI.
- Some features are layer-first while others are feature-first.
- Some domain-ish code depends on presentation types.
- Some services use singleton/global state patterns.
- There is a mix of state tools: Cubit, setState, ValueNotifier, service listeners.

This does not mean the app is bad. It means it is pragmatic and evolved over time.

## What To Mirror In The Learning App

For now, the best learning path is:

```txt
1. models/
2. repositories/
3. cubits/
4. views/pages + views/widgets
5. services/api client
```

Example learning structure:

```txt
lib/
  models/
    activity.dart
  repositories/
    activity_repository.dart
  cubits/
    activity_cubit.dart
    activity_state.dart
  views/
    pages/
      course_page.dart
    widgets/
      activity_details.dart
  services/
    api_client.dart
```

Then later, for larger features, practice:

```txt
lib/features/activity/
  data/
  domain/
  presentation/
```

## Best Mental Model

Coming from React:

```txt
Flutter Widget = React component
Cubit = Zustand/Redux slice or React Query state machine
Repository = API/data module
HesedAPI = Axios instance + API endpoint methods
Model = TypeScript interface/class plus parser
BlocBuilder = reactive UI subscriber
RepositoryProvider/BlocProvider = Context Provider
HydratedCubit = persisted store
```

Important difference:

```txt
React Query owns server cache/query lifecycle.
This project mostly owns async state manually through Cubits and repositories.
```

So when learning Flutter for this project, focus less on `FutureBuilder` long-term and more on:

```txt
Cubit emits Loading/Loaded/Failed
Repository fetches data
Dio handles HTTP
json_serializable parses models
UI renders with BlocBuilder/BlocConsumer
```

