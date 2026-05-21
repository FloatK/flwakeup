import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings {
  final bool followSystem;
  final Brightness brightness;
  final int colorIndex;
  final double cornerRadius;
  final double blockHeight;

  const ThemeSettings({
    this.followSystem = true,
    this.brightness = Brightness.light,
    this.colorIndex = 0,
    this.cornerRadius = 8.0,
    this.blockHeight = 60.0,
  });

  static const List<Color> presetThemeColors = [
    Color(0xFF1565C0), // 蓝色
    Color(0xFFD32F2F), // 红色
    Color(0xFF2E7D32), // 绿色
    Color(0xFF6A1B9A), // 紫色
    Color(0xFFE65100), // 橙色
    Color(0xFFAD1457), // 粉色
    Color(0xFF00838F), // 青色
    Color(0xFF4E342E), // 棕色
  ];
}

Future<ThemeSettings> loadThemeSettings() async {
  final prefs = await SharedPreferences.getInstance();
  return ThemeSettings(
    followSystem: prefs.getBool('theme_follow_system') ?? true,
    brightness:
        prefs.getString('theme_brightness') == 'dark'
            ? Brightness.dark
            : Brightness.light,
    colorIndex: prefs.getInt('theme_color_index') ?? 0,
    cornerRadius: prefs.getDouble('theme_corner_radius') ?? 8.0,
    blockHeight: prefs.getDouble('theme_block_height') ?? 60.0,
  );
}

Future<void> saveThemeSettings(ThemeSettings settings) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('theme_follow_system', settings.followSystem);
  await prefs.setString(
    'theme_brightness',
    settings.brightness == Brightness.dark ? 'dark' : 'light',
  );
  await prefs.setInt('theme_color_index', settings.colorIndex);
  await prefs.setDouble('theme_corner_radius', settings.cornerRadius);
  await prefs.setDouble('theme_block_height', settings.blockHeight);
}

final themeSettingsProvider = StateProvider<ThemeSettings>((ref) {
  throw UnimplementedError('Must be overridden from main');
});
