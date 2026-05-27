import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/pages/login_page.dart';
import 'package:flutter_app/views/pages/onboarding_page.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 500.0,
                child: Lottie.asset(
                  'assets/lotties/wave.json',
                  fit: BoxFit.fill,
                  delegates: LottieDelegates(
                    values: [
                      ValueDelegate.colorFilter(
                        ['**'],
                        value: const ColorFilter.mode(
                          Colors.teal,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 50.0),
                    FittedBox(
                      child: Text(
                        "Flutter Mapp",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                          letterSpacing: 50.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const OnboardingPage();
                            },
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 40.0),
                      ),
                      child: Text("Get Started"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const LoginPage(title: "Register");
                            },
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(double.infinity, 40.0),
                      ),
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
