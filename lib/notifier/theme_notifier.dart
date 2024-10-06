import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todoapp/utils/share_preference.dart';

part 'theme_notifier.g.dart';

@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String keyThemeMode = 'theme_mode';

  final _prefs = SharedPreferencesInstance().prefs;

  @override
  ThemeMode build() {
    final themeName = _prefs.getString(keyThemeMode);

    if (themeName == null) {
      return ThemeMode.system;
    }
    final themeMode = ThemeMode.values.byName(themeName);

    return themeMode;
  }

  void setThemeMode(ThemeMode themeMode) {
    _prefs.setString(keyThemeMode, themeMode.name);
    state = themeMode;
  }

  void toggle() {
    final currentTheme = state;
    ThemeMode themeMode;

    switch (currentTheme) {
      case ThemeMode.light:
        themeMode = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        themeMode = ThemeMode.system;
        break;
      case ThemeMode.system:
        themeMode = ThemeMode.light;
        break;
    }

    setThemeMode(themeMode);

    // setThemeMode(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
