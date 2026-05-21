# Flutter Learning Progress

## Setup And Tooling

- Installed/used FVM as the Flutter version manager, similar to `nvm` for Node.
- Learned that `flutter` is the SDK/CLI, while `fvm flutter` runs Flutter through the selected FVM version.
- Set Flutter `3.32.6` as the FVM global/project SDK.
- Created a Flutter app in `flutter_app`.
- Ran the app on Chrome and on an Android Pixel emulator.
- Learned that VS Code's device selector chooses the run target: Chrome, Linux, Android emulator, etc.
- Learned that selecting `Start pixel` starts the emulator, but pressing `F5`/Start Debugging installs and runs the app.
- Learned that Android emulator issues can come from Android SDK/build tools, not Flutter code.
- Learned where to look for errors:
  - `Problems` for analyzer/static issues.
  - `Debug Console` for runtime/debug logs.
  - `Terminal` for `flutter run` output.
  - `adb logcat` for Android-level logs.

## Git

- Initialized Git in the `flutter-learning` workspace.
- Committed the Flutter learning app scaffold.
- Committed the mobile-specific learning roadmap.
- Verified generated Flutter build/cache folders are ignored.

## Flutter App Structure

- Learned that `lib/main.dart` is similar to a mix of React's `main.tsx` and `App.tsx`.
- Learned that `main()` is the app entrypoint.
- Learned that `runApp(const MyApp())` is similar to rendering `<App />` in React.
- Learned that `build(BuildContext context)` is similar to a React component's `return`.
- Learned that `BuildContext` represents where the widget lives in the widget tree.
- Learned that `super.key` forwards an optional Flutter key to the parent widget.
- Learned that `@override` means a class is implementing/replacing a method from its parent class.

## Widgets And Layout

- Learned that widgets are similar to React components.
- Learned the difference between `StatelessWidget` and `StatefulWidget`.
- Learned that `StatefulWidget` stores immutable configuration, while its `State` class stores mutable state.
- Learned how `createState()` connects a `StatefulWidget` to its `State` class.
- Learned that `setState()` changes local state and tells Flutter to rebuild that widget subtree.
- Learned that multiple state values can be changed inside one `setState()` call.
- Learned that `Scaffold` is a page shell with slots like:
  - `appBar`
  - `body`
  - `floatingActionButton`
  - `bottomNavigationBar`
  - `drawer`
- Learned that `MaterialApp` is the app shell/provider, while `Scaffold` is the screen layout.
- Learned that `AppBar` implements `PreferredSizeWidget`, which is why `Scaffold.appBar` accepts it.
- Learned that custom app bars can implement `PreferredSizeWidget`.
- Learned that `Container.alignment` uses `Alignment`, not `CrossAxisAlignment`.
- Learned that `CrossAxisAlignment` belongs to `Row` and `Column`.
- Learned that `Wrap` lays children onto multiple lines and uses `WrapAlignment`.
- Learned that `Stack` overlays children on top of each other.
- Learned that `SizedBox` can define a fixed area so centered overlay text aligns with an image.

## Common Layout Pitfalls

- Learned that `height: double.infinity` inside a `Column` can cause runtime layout problems.
- Learned to use fixed height, `Expanded`, `Flexible`, or remove the `Column` depending on intent.
- Learned that `Image.asset` needs a real image file; an HTML file renamed to `.jpeg` causes `Invalid image data`.
- Learned that asset changes may need hot restart/full restart, not just hot reload.
- Learned that hot reload can reject invalid changes and keep the last valid running app.
- Learned that hot restart/full restart is safer after structural changes like renaming fields or constructors.

## Material, Cupertino, And Theming

- Learned that Material Design is Google's design system.
- Learned that Flutter ships with Material widgets by default through `material.dart`.
- Learned that Cupertino means iOS-style UI, named after Apple's location in Cupertino.
- Learned that most Flutter apps use `MaterialApp`, even when they are customized heavily.
- Learned that `MaterialApp` does not own `appBar`/`body`; `Scaffold` does.
- Learned that `ColorScheme.fromSeed` generates a full color palette from a seed color.
- Learned that `seedColor` does not mean every background becomes that exact color.
- Learned that `Scaffold` uses theme background/surface colors unless `backgroundColor` is set directly.
- Learned that `useMaterial3: true` enables Material Design 3 defaults.
- Created a `ColorSchemePage` to print and display generated `ColorScheme` values.
- Moved `ColorSchemePage` into its own file under `lib/screens/color_scheme.dart`.
- Learned Dart file naming convention: `snake_case.dart`.
- Learned that `scrim` means a dimming overlay color used behind modals/drawers/dialogs.

## Lists, Tabs, And Navigation UI

- Learned that `ListTile` is a ready-made row item for list/menu/settings UI.
- Learned `leading` means the start side and `trailing` means the end side.
- Learned that `leading`/`trailing` are direction-aware, not hardcoded left/right.
- Learned that `ListTile.tileColor` paints through Material behavior; `Container(color: ...)` is simpler for backgrounds.
- Learned the tab trio:
  - `DefaultTabController`
  - `TabBar`
  - `TabBarView`
- Learned that `DefaultTabController.length`, number of `Tab`s, and number of `TabBarView` children must match.
- Learned that `NavigationBar` is different from `TabBar`.
- Learned that `NavigationBar` requires at least two `NavigationDestination`s.

## Dart Basics

- Learned that Dart `Map<String, dynamic>` is similar to a JavaScript object used as a dictionary.
- Learned Dart map access uses brackets: `map['key']`.
- Learned Dart prefers classes/models for structured app data.
- Learned arrow callbacks like `() => doSomething()` are similar to JavaScript arrow functions.
- Learned block callbacks like `() { ... }` are used for multiple statements.
- Learned that passing `onTap: functionName` gives Flutter a function to run later, while `onTap: functionName()` runs it immediately.

## Assets

- Added an image asset under `assets/images/bg.jpg`.
- Declared asset folders in `pubspec.yaml`.
- Learned to verify files with the `file` command when image decoding fails.

## Formatting

- Learned that Dart formatter keeps short widget constructor calls on one line.
- Learned that trailing commas help the formatter preserve multiline widget trees.
- Learned that the course formatting may differ because of narrower editor width or different line length settings.

## Work Project Context

- Inspected `/home/yan/codes/workspaces/workspace-headers/app-ihs-mobile-front`.
- Learned that the work app uses:
  - `MaterialApp`
  - `Scaffold`
  - custom app bars/bottom navigation
  - `Navigator.push`
  - `flutter_bloc`
  - repositories/services
  - Firebase
  - Sentry
  - Hive/SQLite
  - WebViews
  - push notifications
  - deep links
  - downloads
  - audio/video
- Learned that the work app does not use `go_router`; it mostly uses classic `Navigator` and custom tab navigation.
- Learned that matching the work app means prioritizing `flutter_bloc`, `Navigator`, repositories, services, and mobile integrations.

## Mobile-Specific Topics Identified

- Native config files.
- Push notifications.
- Local notifications.
- Deep links and app links.
- App lifecycle.
- File downloads.
- File storage.
- Storage permissions.
- Offline persistence.
- Background audio.
- Video playback.
- WebViews.
- External URL handling.
- Camera/gallery.
- Image cropping/upload.
- Analytics and tracking permission.
- Crash reporting.
- Safe areas and system UI.
- Android back behavior.
- Keyboard behavior.
- Device info and platform checks.
- Disk space checks.
- Share sheet.
- Remote config.
- Firebase setup.
- App icons and splash screen.
- Build/release setup.
- Payments/donation flows.
- Secure auth/token storage.
- Orientation handling.
- Open app settings.

