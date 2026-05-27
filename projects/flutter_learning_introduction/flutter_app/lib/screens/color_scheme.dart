// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ColorSchemePage extends StatelessWidget {
  const ColorSchemePage({super.key});

  static bool _printed = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = _colorSchemeEntries(scheme);

    if (!_printed) {
      _printed = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        debugPrint('--- ColorScheme.fromSeed generated values ---');
        debugPrint('brightness: ${scheme.brightness}');
        for (final entry in colors.entries) {
          debugPrint(
            '${entry.key}: ${_colorToHex(entry.value)} ${entry.value}',
          );
        }
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Color Scheme')),
      body: ListView(
        children: colors.entries.map((entry) {
          return Container(
            color: entry.value,
            padding: const EdgeInsets.all(16),
            child: Text(
              '${entry.key}: ${_colorToHex(entry.value)}',
              style: TextStyle(color: _textColorFor(entry.value)),
            ),
          );
        }).toList(),
      ),
    );
  }

  static Map<String, Color> _colorSchemeEntries(ColorScheme scheme) {
    return {
      // Primary colors
      'primary': scheme.primary,
      'onPrimary': scheme.onPrimary,
      'primaryContainer': scheme.primaryContainer,
      'onPrimaryContainer': scheme.onPrimaryContainer,
      'primaryFixed': scheme.primaryFixed,
      'primaryFixedDim': scheme.primaryFixedDim,
      'onPrimaryFixed': scheme.onPrimaryFixed,
      'onPrimaryFixedVariant': scheme.onPrimaryFixedVariant,

      // Secondary colors
      'secondary': scheme.secondary,
      'onSecondary': scheme.onSecondary,
      'secondaryContainer': scheme.secondaryContainer,
      'onSecondaryContainer': scheme.onSecondaryContainer,
      'secondaryFixed': scheme.secondaryFixed,
      'secondaryFixedDim': scheme.secondaryFixedDim,
      'onSecondaryFixed': scheme.onSecondaryFixed,
      'onSecondaryFixedVariant': scheme.onSecondaryFixedVariant,

      // Tertiary colors
      'tertiary': scheme.tertiary,
      'onTertiary': scheme.onTertiary,
      'tertiaryContainer': scheme.tertiaryContainer,
      'onTertiaryContainer': scheme.onTertiaryContainer,
      'tertiaryFixed': scheme.tertiaryFixed,
      'tertiaryFixedDim': scheme.tertiaryFixedDim,
      'onTertiaryFixed': scheme.onTertiaryFixed,
      'onTertiaryFixedVariant': scheme.onTertiaryFixedVariant,

      // Error colors
      'error': scheme.error,
      'onError': scheme.onError,
      'errorContainer': scheme.errorContainer,
      'onErrorContainer': scheme.onErrorContainer,

      // Surface colors
      'surface': scheme.surface,
      'onSurface': scheme.onSurface,
      'surfaceDim': scheme.surfaceDim,
      'surfaceBright': scheme.surfaceBright,
      'surfaceContainerLowest': scheme.surfaceContainerLowest,
      'surfaceContainerLow': scheme.surfaceContainerLow,
      'surfaceContainer': scheme.surfaceContainer,
      'surfaceContainerHigh': scheme.surfaceContainerHigh,
      'surfaceContainerHighest': scheme.surfaceContainerHighest,
      'surfaceVariant': scheme.surfaceVariant,
      'onSurfaceVariant': scheme.onSurfaceVariant,

      // Outline colors
      'outline': scheme.outline,
      'outlineVariant': scheme.outlineVariant,

      // System overlay colors
      'shadow': scheme.shadow,
      'scrim': scheme.scrim,

      // Inverse colors
      'inverseSurface': scheme.inverseSurface,
      'onInverseSurface': scheme.onInverseSurface,
      'inversePrimary': scheme.inversePrimary,

      // Elevation tint
      'surfaceTint': scheme.surfaceTint,

      // Deprecated background aliases
      'background': scheme.background,
      'onBackground': scheme.onBackground,
    };
  }

  static String _colorToHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static Color _textColorFor(Color background) {
    return ThemeData.estimateBrightnessForColor(background) == Brightness.dark
        ? Colors.white
        : Colors.black;
  }
}
