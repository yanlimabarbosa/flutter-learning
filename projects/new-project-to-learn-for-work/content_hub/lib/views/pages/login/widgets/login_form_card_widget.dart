import 'package:content_hub/views/pages/signup/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginFormCard extends StatelessWidget {
  const LoginFormCard({super.key});

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
            TextFormField(decoration: InputDecoration(hintText: 'Email')),
            SizedBox(height: 15),
            TextFormField(decoration: InputDecoration(hintText: "Password")),
            SizedBox(height: 15),
            FilledButton(
              onPressed: () {},
              child: Text(
                "Sign In",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return const SignupPage();
                    },
                  ),
                );
              },
              child: Text(
                "Create account",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Demo account available',
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Forgot password?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
