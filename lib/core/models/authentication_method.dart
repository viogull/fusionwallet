import 'package:flutter/material.dart';

import '../../localizations.dart';
import 'settings_item.dart';

enum AuthMethod { PIN, BIOMETRICS }

/// Represent the available authentication methods our app supports
class AuthenticationMethod extends SettingSelectionItem {
  AuthMethod method;

  AuthenticationMethod(this.method);

  String getDisplayName(BuildContext context) {
    switch (method) {
      case AuthMethod.BIOMETRICS:
        return AppLocalizations.of(context).settingsItemBiometricFeature();
      case AuthMethod.PIN:
        return AppLocalizations.of(context).inputEnterScanPasshpraseHintText();
      default:
        return AppLocalizations.of(context).inputEnterScanPasshpraseHintText();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return method.index;
  }
}
