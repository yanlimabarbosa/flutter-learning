import 'package:flutter/material.dart';

class HeroDescription extends StatelessWidget {
  const HeroDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Text(
      description,
      style: TextStyle(
        color: colors.onSurfaceVariant,
        fontSize: 16,
        height: 1.6,
      ),
    );
  }
}
