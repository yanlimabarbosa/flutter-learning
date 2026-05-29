import 'package:content_hub/cubits/authentication_cubit/authentication_cubit.dart';
import 'package:content_hub/repositories/auth_repository.dart';
import 'package:content_hub/theme/app_theme.dart';
import 'package:content_hub/views/pages/login/login_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ContentHubApp());
}

class ContentHubApp extends StatelessWidget {
  const ContentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            AuthenticationCubit(authRepository: context.read<AuthRepository>()),
        child: MaterialApp(
          title: 'Content Hub',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          home: const LoginPage(),
        ),
      ),
    );
  }
}
