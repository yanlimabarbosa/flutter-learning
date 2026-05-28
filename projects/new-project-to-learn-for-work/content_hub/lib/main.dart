import 'package:content_hub/theme/app_theme.dart';
import 'package:content_hub/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ContentHubApp());
}

class ContentHubApp extends StatelessWidget {
  const ContentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Content Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const LoginPage(),
    );
  }
}
