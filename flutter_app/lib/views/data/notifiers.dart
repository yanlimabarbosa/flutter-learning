import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);

ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

const String _themeModeKey = 'themeMode';

Future<void> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final savedThemeMode = prefs.getString(_themeModeKey);

  themeModeNotifier.value = switch (savedThemeMode) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}

Future<void> setThemeMode(ThemeMode themeMode) async {
  final prefs = await SharedPreferences.getInstance();

  themeModeNotifier.value = themeMode;

  await prefs.setString(_themeModeKey, switch (themeMode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  });
}
