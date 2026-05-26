import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/main.dart';
import 'package:flutter_app/views/data/notifiers.dart';

void main() {
  testWidgets('App shows home page and navigates to profile', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.binding.setSurfaceSize(const Size(1200, 1200));

    await tester.pumpWidget(const MyApp());

    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Basic Layout'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Theme menu changes theme mode', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    themeModeNotifier.value = ThemeMode.system;

    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byIcon(Icons.brightness_6), findsOneWidget);

    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    await tester.tap(find.byType(PopupMenuItem<ThemeMode>).last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(themeModeNotifier.value, ThemeMode.dark);
  });
}
