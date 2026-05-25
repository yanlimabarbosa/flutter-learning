import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_page_route.dart';
import 'package:flutter_app/views/widget_tree.dart';
import 'package:flutter_app/views/widgets/hero_widget.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroWidget(),
            FilledButton(
              onPressed: () {
                Navigator.push(context, slideFadeRoute(const WidgetTree()));
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
