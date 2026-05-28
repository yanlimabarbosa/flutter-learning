import 'package:content_hub/views/pages/login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupFormCard extends StatelessWidget {
  const SignupFormCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: colors.outline),
        color: colors.surfaceContainer,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Form(
        child: Column(
          children: [
            TextFormField(decoration: InputDecoration(hintText: 'Name')),
            SizedBox(height: 15),
            TextFormField(decoration: InputDecoration(hintText: 'Email')),
            SizedBox(height: 15),
            TextFormField(decoration: InputDecoration(hintText: "Password")),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(hintText: "Confirm Password"),
            ),
            SizedBox(height: 15),
            FilledButton(
              onPressed: () {},
              child: Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return const LoginPage();
                    },
                  ),
                );
              },
              child: Text(
                "Already have an account?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 12,
                  height: 1.45,
                ),
                children: [
                  const TextSpan(
                    text:
                        'By continuing, you agree to keep this demo aligned with the future ',
                  ),
                  TextSpan(
                    text: 'Firebase',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'API',
                    style: TextStyle(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const TextSpan(text: ' flow.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
