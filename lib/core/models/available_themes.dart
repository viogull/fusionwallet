import 'package:flutter/material.dart';

import '../../themes.dart';
import 'settings_item.dart';

enum ThemeOptions { LIGHT, DARK }

/// Represent notification on/off setting
class ThemeSetting extends SettingSelectionItem {
  ThemeOptions theme;

  ThemeSetting(this.theme);

  String getDisplayName(BuildContext context) {
    switch (theme) {
      case ThemeOptions.LIGHT:
        return "Thorium";
      case ThemeOptions.LIGHT:
        return "Neptunium";
      default:
        return "Natrium";
    }
  }

  BaseTheme getTheme() {
    switch (theme) {
      case ThemeOptions.LIGHT:
        return ThoriumTheme();
      case ThemeOptions.DARK:
        return NeptuniumTheme();
      default:
        return LightTheme();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return theme.index;
  }
}
