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
- Learned that mutable UI state must live as a field on the `State` class, not as a local variable inside `build()`.
- Learned that local variables inside `build()` are recreated on every rebuild.
- Learned that `NavigationBar.selectedIndex` must read from persistent state if tapping a destination should update the selected page/item.
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
- Learned that `Column` defaults to `crossAxisAlignment: CrossAxisAlignment.center`.
- Learned that `Column(crossAxisAlignment: CrossAxisAlignment.start)` is the Flutter equivalent of left-aligning children on the horizontal axis.
- Learned that a `Column`'s main axis is vertical and its cross axis is horizontal.
- Learned that a `Row`'s main axis is horizontal and its cross axis is vertical.
- Learned that `const` widgets can be reused because their values are compile-time constants.
- Learned to use `const` for static widgets like `Text`, `Icon`, pages, and custom widgets when their constructor values do not depend on runtime state.

## Common Layout Pitfalls

- Learned that `height: double.infinity` inside a `Column` can cause runtime layout problems.
- Learned to use fixed height, `Expanded`, `Flexible`, or remove the `Column` depending on intent.
- Learned that `Image.asset` needs a real image file; an HTML file renamed to `.jpeg` causes `Invalid image data`.
- Learned that asset changes may need hot restart/full restart, not just hot reload.
- Learned that hot reload can reject invalid changes and keep the last valid running app.
- Learned that hot restart/full restart is safer after structural changes like renaming fields or constructors.
- Learned that hot reload patches method bodies, but does not reliably reshape existing classes/objects.
- Learned that changing fields, removing fields, changing constructors, or changing root app setup may require hot restart.
- Learned that values declared inside `build()` are generally more hot-reload-friendly than widget instance fields.
- Learned that a rejected hot reload can show messages like `Const class cannot remove fields`.

## State Management

- Learned that `setState()` is best for local UI state inside one widget/screen.
- Learned that `ValueNotifier` is useful for tiny shared reactive values.
- Learned that `ValueListenableBuilder` subscribes the UI to a `ValueNotifier` and rebuilds when the value changes.
- Learned that importing a notifier and reading `.value` only reads the current value; it does not subscribe the widget to rebuilds.
- Learned the rule: direct notifier access is fine for changing a value, but UI that visually depends on that value needs a listener/builder.
- Added `selectedPageNotifier` to control the selected bottom navigation page.
- Added `isDarkModeNotifier` to control dark/light mode.
- Learned that the root `MaterialApp` should listen to `isDarkModeNotifier` because the app theme depends on it.
- Learned that only the dark/light icon button needs its own small `ValueListenableBuilder` if the icon changes between moon and sun.
- Replaced the simple dark-mode bool with `ValueNotifier<ThemeMode>` so the app can represent `system`, `light`, and `dark`.
- Learned that `bool` is not enough for theme preference when the app needs a third "follow phone preference" option.
- Added `loadThemeMode()` to load a saved theme preference before `runApp(...)`.
- Added `setThemeMode(...)` to update the theme and persist the user choice.
- Learned that `ValueNotifier + ValueListenableBuilder` is good for learning and small UI state, while larger business/app state in the work project uses Cubit/Bloc heavily.
- Learned that the work project also uses `setState`, `ValueNotifier`, `ValueListenableBuilder`, `ListenableBuilder`, and `.addListener(...)`.
- Learned that the work project's bottom navigation uses `TabController`, `ListenableBuilder`, and a global `ValueNotifier<int>` for the current bottom navigation index.

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
- Learned that `ThemeData(colorScheme: ColorScheme.fromSeed(...))` can generate light or dark color schemes by changing `brightness`.
- Learned that dark/light mode can be implemented by rebuilding `MaterialApp` with a different `ThemeData`.
- Learned that `theme`, `darkTheme`, and `themeMode` work together:
  - `theme` is the light theme.
  - `darkTheme` is the dark theme.
  - `themeMode` decides whether to use light, dark, or the phone preference.
- Learned that `ThemeMode.system` follows the phone/emulator dark-mode setting.
- Added a theme popup menu with System, Light, and Dark choices.
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

## Navigation And Animations

- Added a welcome/login screen that navigates into the main `WidgetTree`.
- Added a reusable `slideFadeRoute(...)` helper using `PageRouteBuilder` so route animation code stays out of button handlers.
- Replaced repeated `CupertinoPageRoute` calls with the reusable route helper.
- Learned that `Hero` animations need matching `Hero` tags on two different routes.
- Learned that route animation and `Hero` animation are connected: the `Hero` flight happens during a `Navigator` route transition.
- Learned that replacing a widget in `body` with `pages.elementAt(index)` is not the same as pushing a route, so it does not create a route transition by itself.
- Learned that `CupertinoPageRoute` can make transitions look more obvious, but it also gives the route an iOS-style navigation feel.
- Learned that `PageRouteBuilder` is more verbose inline, but a helper function makes custom route transitions reusable.
- Learned that first animations can look broken in Flutter debug mode on the Android emulator because debug builds are slower and may skip early frames.
- Learned to use `flutter run --profile` when judging animation/performance behavior.

## Dart Basics

- Learned that Dart `Map<String, dynamic>` is similar to a JavaScript object used as a dictionary.
- Learned Dart map access uses brackets: `map['key']`.
- Learned Dart prefers classes/models for structured app data.
- Learned arrow callbacks like `() => doSomething()` are similar to JavaScript arrow functions.
- Learned block callbacks like `() { ... }` are used for multiple statements.
- Learned that passing `onTap: functionName` gives Flutter a function to run later, while `onTap: functionName()` runs it immediately.
- Learned that Dart string interpolation uses `$variable` and `${expression}`.
- Learned that `bool` is non-nullable, while `bool?` can be `true`, `false`, or `null`.
- Learned that `Checkbox.onChanged` receives `bool?` because Flutter checkboxes can support a third `null` state.
- Learned that `=>` implicitly returns one expression.
- Learned that `() => { doSomething() }` is not a block body in Dart; `{}` after `=>` creates a Set/Map literal.
- Learned to prefer `() { doSomething(); }` for side-effect callbacks.
- Learned that one-expression callbacks can use `() => doSomething()`.

## Forms And Inputs

- Added a `TextField` with a `TextEditingController`.
- Learned that `TextEditingController.text` stores the current text field value.
- Learned that `onEditingComplete` can call `setState()` to rebuild text shown from the controller.
- Added `shared_preferences` for simple persisted local settings, similar to browser `localStorage`.
- Added a `DropdownButton` with `DropdownMenuItem`s and nullable `String?` state.
- Learned that dropdown selected values must match one of the item values.
- Added `Checkbox` and `CheckboxListTile`.
- Learned that normal controls like `Checkbox` and `Switch` are only the control itself.
- Learned that tile controls like `CheckboxListTile` and `SwitchListTile` are full row widgets with title/subtitle/tap area.
- Learned that `tristate: true` allows a checkbox value to cycle through `false`, `true`, and `null`.
- Learned that `value ?? false` removes the `null` state, so it should not be used when intentionally practicing tristate behavior.
- Added `Switch` and `SwitchListTile`.
- Added a `Slider` with local `double` state.
- Wrapped the profile page content in `SingleChildScrollView` so the controls can scroll when they exceed the screen height.
- Added practice examples for `ElevatedButton`, `FilledButton`, `TextButton`, `OutlinedButton`, `CloseButton`, and `BackButton`.
- Added an `InkWell` tap area and learned that it provides Material tap/splash behavior.

## Testing

- Replaced the default counter widget test with tests that match the current app.
- Added a widget test that verifies the app title, home page, and bottom navigation to the profile page.
- Added a widget test that taps the dark mode icon and verifies it changes to the light mode icon.
- Learned that generated starter tests can fail after the UI changes and should be updated to test the actual app behavior.
- Updated tests for the welcome/login flow before reaching the main `WidgetTree`.
- Updated the theme test to use the new System/Light/Dark popup menu.
- Learned that infinite animations like Lottie can make `pumpAndSettle()` time out in widget tests.
- Learned to use fixed-duration `pump(...)` calls when the widget tree has ongoing animations.

## Assets

- Added an image asset under `assets/images/bg.jpg`.
- Declared asset folders in `pubspec.yaml`.
- Learned to verify files with the `file` command when image decoding fails.

## Formatting

- Learned that Dart formatter keeps short widget constructor calls on one line.
- Learned that trailing commas help the formatter preserve multiline widget trees.
- Learned that the course formatting may differ because of narrower editor width or different line length settings.

## Emulator And Platform Notes

- Learned that Android emulator keyboard behavior can depend on focus, emulator extended controls, and AVD config.
- Learned that `hw.keyboard=yes` in `/home/yan/.android/avd/pixel.avd/config.ini` enables hardware keyboard support for the Pixel AVD.
- Learned that a nicer Android device frame depends on the emulator skin/device profile, not only `showDeviceFrame=yes`.
- Learned that creating a new Pixel emulator profile in Android Studio Device Manager may be needed for a nicer device frame.
- Learned that iOS Simulator and normal iOS local builds require macOS and Xcode.
- Learned that Linux is fine for Flutter code, Android emulator, tests, and Android builds, but iOS build/sign/simulator workflow needs access to macOS.
- Learned that Docker-OSX/Hackintosh exist as unofficial workarounds, but they are not the supported/professional path for company iOS development.

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
