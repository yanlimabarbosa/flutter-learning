import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const bg = Color(0xFF101114);
  static const bgDeep = Color(0xFF0B0C0F);
  static const surface = Color(0xFF181A20);
  static const surfaceDim = Color(0xFF101114);
  static const surfaceBright = Color(0xFF2B303A);
  static const surfaceLowest = Color(0xFF0B0C0F);
  static const surfaceLow = Color(0xFF14161B);
  static const surfaceStrong = Color(0xFF20232B);
  static const surfaceHighest = Color(0xFF2A2E38);
  static const primary = Color(0xFF8BDAFF);
  static const primaryLight = Color(0xFFF8FCFF);
  static const primarySoft = Color(0xFF233946);
  static const secondary = Color(0xFFF4C95D);
  static const secondarySoft = Color(0xFF3B321B);
  static const tertiary = Color(0xFFA7F3D0);
  static const tertiarySoft = Color(0xFF19362C);
  static const error = Color(0xFFFF6B6B);
  static const errorSoft = Color(0xFF4A1F24);
  static const text = Color(0xFFF5F7FA);
  static const muted = Color(0xFFA8AFBD);
  static const border = Color(0x1FF5F7FA);
  static const borderStrong = Color(0x3DF5F7FA);
  static const placeholder = Color(0xFF777F8F);
  static const buttonText = Color(0xFF081218);
  static const shadow = Color(0xFF000000);
  static const scrim = Color(0xB3000000);

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,

    // Brand/action background: buttons, links, active states.
    primary: primary,

    // Text/icon color on primary.
    onPrimary: buttonText,

    // Soft brand background: badges, selected areas, gradient end.
    primaryContainer: primaryLight,

    // Text/icon color on primaryContainer.
    onPrimaryContainer: buttonText,

    // Fixed primary colors: keep stable if dynamic color is added later.
    primaryFixed: primaryLight,
    primaryFixedDim: primary,
    onPrimaryFixed: buttonText,
    onPrimaryFixedVariant: primarySoft,

    // Secondary accent background: labels and supporting highlights.
    secondary: secondary,

    // Text/icon color on secondary.
    onSecondary: bg,

    // Soft secondary background.
    secondaryContainer: secondarySoft,
    onSecondaryContainer: text,

    // Fixed secondary colors: keep stable if dynamic color is added later.
    secondaryFixed: secondary,
    secondaryFixedDim: secondarySoft,
    onSecondaryFixed: bg,
    onSecondaryFixedVariant: text,

    // Third accent background: future tags/categories/success-like accents.
    tertiary: tertiary,
    onTertiary: bg,
    tertiaryContainer: tertiarySoft,
    onTertiaryContainer: text,

    // Fixed tertiary colors: keep stable if dynamic color is added later.
    tertiaryFixed: tertiary,
    tertiaryFixedDim: tertiarySoft,
    onTertiaryFixed: bg,
    onTertiaryFixedVariant: text,

    // Error/destructive backgrounds and their readable text colors.
    error: error,
    onError: bg,
    errorContainer: errorSoft,
    onErrorContainer: text,

    // Default neutral background: panels, sheets, inputs, app surfaces.
    surface: surface,

    // Default text/icon color on surfaces.
    onSurface: text,

    // Neutral background scale. Higher = more visible/elevated.
    surfaceDim: surfaceDim,
    surfaceBright: surfaceBright,
    surfaceContainerLowest: bg,
    surfaceContainerLow: surfaceLow,
    surfaceContainer: surface,
    surfaceContainerHigh: surfaceStrong,
    surfaceContainerHighest: surfaceHighest,

    // Muted text/icon color on surfaces: descriptions, helper text, icons.
    onSurfaceVariant: muted,

    // Borders/dividers. Variant is stronger.
    outline: border,
    outlineVariant: borderStrong,

    // Non-content overlays.
    shadow: shadow,
    scrim: scrim,

    // Inverted UI colors: snackbars or temporary high-contrast surfaces.
    inverseSurface: text,
    onInverseSurface: bg,
    inversePrimary: primarySoft,

    // Material elevation/surface tint.
    surfaceTint: primary,

    // Deprecated fields, kept as reference only:
    // background: use surface instead.
    // onBackground: use onSurface instead.
    // surfaceVariant: use surfaceContainerHighest instead.
  );
}
