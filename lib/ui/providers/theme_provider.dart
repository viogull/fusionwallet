

import 'package:flutter/material.dart';
import 'package:fusion_wallet/ui/theme/fusion_theme.dart';
import 'package:fusion_wallet/utils/prefs.dart';

class ThemeProvider with ChangeNotifier {


  final Prefs prefs = Prefs();
 
 ThemeProvider()  {
   initTheme();
 }
 ThemeData _themeData;
 
 /// Use this method on UI to get selected theme.
 ThemeData get themeData =>_themeData;
 
 void initTheme() async {
     if (_themeData == null) {
     var theme = await prefs.getTheme();
     _themeData = (theme == Prefs.THEME_LIGHT) ? FusionTheme.light : FusionTheme.dark;
   };
 }

 /// Sets theme and notifies listeners about change. 
 setTheme(int theme) async {
   _themeData = (theme == Prefs.THEME_LIGHT) ? FusionTheme.light : FusionTheme.dark;
   prefs.setTheme(theme);
   // Here we notify listeners that theme changed 
   // so UI have to be rebuild
   notifyListeners();
 }
}
