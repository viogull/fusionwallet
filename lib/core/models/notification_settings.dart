import 'package:flutter/material.dart';

import '../../localizations.dart';
import 'settings_item.dart';

enum NotificationOptions { ON, OFF }

/// Represent notification on/off setting
class NotificationSetting extends SettingSelectionItem {
  NotificationOptions setting;

  NotificationSetting(this.setting);

  String getDisplayName(BuildContext context) {
    switch (setting) {
      case NotificationOptions.ON:
        return AppLocalizations.of(context).labelYes();
      case NotificationOptions.OFF:
      default:
        return AppLocalizations.of(context).labelNo();
    }
  }

  // For saving to shared prefs
  int getIndex() {
    return setting.index;
  }
}
