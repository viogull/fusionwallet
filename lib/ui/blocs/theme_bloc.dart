import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:fusion_wallet/ui/theme/theme_event.dart';
import 'package:fusion_wallet/ui/theme/theme_state.dart';
import 'package:fusion_wallet/utils/prefs.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final Prefs prefs = Prefs();

  @override
  ThemeState get initialState => ThemeState(themeData: FusionTheme.light);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      var currentTheme = (await prefs.getTheme() == Prefs.THEME_LIGHT)
          ? FusionThemes.light
          : FusionThemes.dark;
      debugPrint('Loaded theme from storage -> $currentTheme');
      var changed = ThemeState(
          themeData: (event.theme == FusionThemes.light)
              ? FusionTheme.light
              : FusionTheme.dark);
      await prefs.setTheme((event.theme == FusionThemes.light)
          ? Prefs.THEME_DARK
          : Prefs.THEME_LIGHT);
      yield changed;
    }
  }
}
