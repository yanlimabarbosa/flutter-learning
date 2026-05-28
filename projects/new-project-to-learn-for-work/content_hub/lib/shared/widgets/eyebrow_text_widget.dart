import 'package:flutter/material.dart';

class EyebrowText extends StatelessWidget {
  const EyebrowText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Text(
      text,
      style: TextStyle(
        color: colors.secondary,
        fontWeight: FontWeight.w700,
        letterSpacing: 3,
      ),
    );
  }
}
