import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key, required this.title, this.nextPage});

  final String title;
  final Widget? nextPage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextPage == null ? null : () => _handleTap(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Hero(
            tag: "hero-1",
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20.0),
              child: Image.asset(
                "assets/images/bg.jpg",
                color: Colors.teal,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          FittedBox(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 50.0,
                letterSpacing: 50.0,
                color: Colors.white30,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(BuildContext context) {
    final page = nextPage;

    if (page == null) return;

    Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
  }
}
