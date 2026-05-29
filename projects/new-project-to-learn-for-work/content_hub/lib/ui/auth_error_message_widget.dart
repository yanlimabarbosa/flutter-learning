import 'package:flutter/material.dart';

class AuthErrorMessage extends StatelessWidget {
  const AuthErrorMessage({super.key, required this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            axisAlignment: -1,
            child: child,
          ),
        );
      },
      child: message == null
          ? const SizedBox.shrink(key: ValueKey('empty-error'))
          : Padding(
              key: ValueKey(message),
              padding: const EdgeInsets.only(bottom: 15),
              child: Text(message!, style: TextStyle(color: colors.error)),
            ),
    );
  }
}
