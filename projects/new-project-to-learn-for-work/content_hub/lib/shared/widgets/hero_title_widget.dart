import 'package:flutter/material.dart';

class HeroTitle extends StatelessWidget {
  const HeroTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
        wordSpacing: 1,
        height: 1.2,
      ),
    );
  }
}
