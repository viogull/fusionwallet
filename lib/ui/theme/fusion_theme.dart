



import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class FusionTheme {



  static int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  static Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  static int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  static Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);



  static  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  static get lightIndigo => hexToColor("##A485FD");
  static get darkGrey => hexToColor("#41463D");
  static get lightBlue => hexToColor("#B8CDF8");
  static get lightTeal => hexToColor("#95F2D9");
  static get lightGreen => hexToColor("#1CFEBA");


  static get purpleHeart => hexToColor("#5E2CD6");
  static get midnightExpress => hexToColor("#171738");
  static get christalle => hexToColor("#2E1760");
  static get wildBlue => hexToColor("#7180B9");
  static get cosmicLatte => hexToColor("#DFF3E4");


  static get lightColorScheme => ColorScheme.light(
      primary: hexToColor("#6200ee"),
      primaryVariant: hexToColor("#3700b3"),
      secondary:hexToColor("#03dac6"),
      secondaryVariant: hexToColor("#018786"),
      onPrimary:hexToColor("#ffffff"),
      onSecondary: hexToColor("#000000"),
      error: hexToColor("#b00020"),
      onError: hexToColor("#FFFFFF"),
      background: hexToColor("#ffffff"),
      onBackground: hexToColor("#6200ee"),
      surface: hexToColor("#ffffff"),
      onSurface: hexToColor("#000000")
  );

  static get darkColorScheme => ColorScheme.dark(
      primary: hexToColor("#bb86fc"),
      primaryVariant: hexToColor("#3700B3"),
      secondary:hexToColor("#03dac6"),
      secondaryVariant: hexToColor("#03dac6"),
      onPrimary:hexToColor("#000000"),
      onSecondary: hexToColor("#000000"),
      error: hexToColor("#cf6679"),
      onError:hexToColor("#6200ee"),
      background: hexToColor("#121212"),
      onBackground: hexToColor("#ffffff"),
      surface: hexToColor("#121212"),
      onSurface: hexToColor("#ffffff")
  );



  static final ThemeData light = ThemeData(
      primarySwatch: generateMaterialColor(FusionTheme.hexToColor("#6200ee")),
      brightness: Brightness.light,
      colorScheme: lightColorScheme
  );


  static final ThemeData dark = ThemeData(
      primarySwatch: generateMaterialColor(FusionTheme.hexToColor("#bb86fc")),
      brightness: Brightness.dark,
      colorScheme: darkColorScheme
  );


  static get borderRadius =>  BorderRadius.all(Radius.circular(5));



  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }


}


enum FusionThemes {
  light, dark
}

class ThemesNotifier with ChangeNotifier {


  FusionThemes _currentTheme = FusionThemes.light;
  ThemeData _currentThemeData = FusionTheme.light;

  get currentTheme => _currentTheme;

  get currentThemeData => _currentThemeData;

  void switchTheme() =>
      (_currentTheme == FusionThemes.light)
          ? currentTheme(FusionThemes.dark)
          : currentTheme(FusionThemes.light);

  set currentTheme(FusionThemes theme) {
    if (theme != null) {
      _currentTheme = theme;
      _currentThemeData =
      _currentTheme == FusionThemes.light ? FusionTheme.light : FusionTheme
          .dark;
      notifyListeners();
    }
  }

}

