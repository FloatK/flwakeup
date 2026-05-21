import 'package:flutter/material.dart';

import '../../presentation/providers/theme_provider.dart';

ThemeData buildTheme(int colorIndex, Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: ThemeSettings.presetThemeColors[colorIndex % ThemeSettings.presetThemeColors.length],
    brightness: brightness,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: colorScheme.primaryContainer,
      foregroundColor: colorScheme.onPrimaryContainer,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
  );
}
