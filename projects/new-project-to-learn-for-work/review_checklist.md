# Review Checklist

Use this checklist when Yan asks for a review of the work-focused Flutter app.

Project:

```txt
/home/yan/codes/flutter-learning/projects/new-project-to-learn-for-work/content_hub
```

The review should not only answer "does it compile?" It should judge whether the code is clean enough to keep learning/building on top of.

## Review Priorities

1. Correctness

- Run or recommend `fvm flutter analyze`.
- Run or recommend `fvm flutter test` when tests exist.
- Check for compile errors, missing required parameters, stale renamed props, and broken imports.
- Check whether widgets are valid in their current parent. Example: `Expanded` only belongs under `Row`, `Column`, or another `Flex`.

2. Flutter Layout Semantics

- Check whether layout widgets are owning the right job.
- Prefer `Column`/`Row`/`Stack`/`ListView` for structure, and `Padding`/`SizedBox`/`SafeArea` for layout glue.
- Avoid extracting layout-only decisions into child widgets when that makes the child only work in one parent.
- Watch for overflow risks on small screens and tablets.
- Check whether `Text` has bounded width when it needs to wrap.

3. Widget Extraction Quality

- Prefer extracting widgets that represent meaningful UI concepts, not random chunks.
- Good extraction examples:
  - `BrandMark`
  - `StatusPill`
  - `LoginHeroSection`
  - `FeatureCard`
  - `AuthTextField`
- Be skeptical of extracting one-off spacing or tiny layout fragments too early.
- If a widget is reusable, pass text/content as constructor parameters.
- If a widget is page-specific, keep it near that page, such as `lib/views/pages/login/widgets/`.
- If a widget becomes shared across screens, move it to a shared widgets folder.

4. Naming

- Prefer clear Flutter names:
  - `backgroundColor` instead of `bgColor`
  - `textColor` instead of vague names
  - `StatusPill` instead of hardcoded `MemberAccessPill` if the label is configurable
- Avoid names that imply a widget is reusable when its content is still hardcoded.
- Prefer page-specific names when the widget only belongs to one screen, such as `LoginHeroTitle`.

5. Theme And Color Semantics

- In widgets, prefer reading colors from:

```dart
final colors = Theme.of(context).colorScheme;
```

- Use semantic `ColorScheme` slots correctly:
  - `primary`: main brand/action color
  - `onPrimary`: text/icon on top of `primary`
  - `surface`: background surface
  - `onSurface`: text/icon on top of surface
  - `onSurfaceVariant`: muted/secondary text or icons
  - `primaryContainer`: softer/container version of primary
  - `surfaceContainerHigh`: stronger surface/card background
  - `outline`: borders/dividers
  - `error`: error/destructive color
- Remember that `on...` colors are foreground colors, usually text/icons, not backgrounds or gradient stops.
- Do not use `inverseSurface` unless the UI really needs an inverted surface, such as snackbar-like contrast.
- If a widget imports `AppColors`, ask whether that color should instead be mapped through `ColorScheme` or a future `ThemeExtension`.
- `AppColors` should usually be the raw token source used by theme files, not imported everywhere.

6. Visual Match And Product Taste

- Compare against the current prototype when relevant:

```txt
projects/new-project-to-learn-for-work/prototypes/
```

- Check whether spacing, typography, color opacity, and hierarchy match the intended look.
- Point out when code is technically valid but semantically odd, such as using a muted text color as a gradient color.
- Be honest about visual issues, even if the code compiles.

7. Learning Value

- Explain issues in React/web terms when useful.
- Separate "this is broken" from "this is polish."
- Give Yan the smallest next fix first.
- Avoid rewriting everything unless Yan explicitly asks to implement.

## Current Theme Direction

The project currently prefers:

```txt
ColorScheme.fromSeed + copyWith for semantic theme slots.
Widgets should mostly use Theme.of(context).colorScheme.
AppColors should mainly feed AppTheme.
```

When reviewing color usage, push toward semantic context colors first.

