import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:vibrate/vibrate.dart';

class HapticUtil {
  /// Return true if this device supports taptic engine (iPhone 7+)
  Future<bool> hasTapicEngine() async {
    if (!Platform.isIOS) {
      return false;
    }
    IosDeviceInfo deviceInfo = await DeviceInfoPlugin().iosInfo;
    String deviceIdentifier = deviceInfo.utsname.machine;
    switch (deviceIdentifier) {
      case 'iPhone5,1': // iPhone 5
      case 'iPhone5,2': // iPhone 5
      case 'iPhone5,3': // iPhone 5C
      case 'iPhone5,4': // iPhone 5C
      case 'iPhone6,1': // iPhone 5S
      case 'iPhone6,2': // iPhone 5S
      case 'iPhone7,2': // iPhone 6
      case 'iPhone7,1': // iPhone 6 plus
      case 'iPhone8,1': // iPhone 6s
      case 'iPhone8,2': // iPhone 6s plus
        return false;
      default:
        return true;
    }
  }

  /// Feedback for error
  Future<void> error() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.error);
      } else {
        HapticFeedback.vibrate();
      }
    } else {
      HapticFeedback.vibrate();
    }
  }

  Future<void> impact() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.impact);
      } else {
        HapticFeedback.vibrate();
      }
    } else {
      HapticFeedback.vibrate();
    }
  }

  Future<void> warn() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.warning);
      } else {
        HapticFeedback.vibrate();
      }
    } else {
      HapticFeedback.vibrate();
    }
  }

  Future<void> selection() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.selection);
      } else {
        HapticFeedback.vibrate();
      }
    } else {
      HapticFeedback.vibrate();
    }
  }

  /// Feedback for success
  Future<void> success() async {
    if (Platform.isIOS) {
      // If this is simulator or this device doesnt have tapic then we can't use this
      if (await hasTapicEngine() && await Vibrate.canVibrate) {
        Vibrate.feedback(FeedbackType.medium);
      } else {
        HapticFeedback.lightImpact();
      }
    } else {
      HapticFeedback.mediumImpact();
    }
  }

  /// Feedback for fingerprint success
  /// iOS-only, since Android already gives us feedback on success
  Future<void> fingerprintSucess() async {
    if (Platform.isIOS) {
      Future.delayed(Duration(milliseconds: 111), () => success());
    }
  }

  base() {
    if (Platform.isIOS) {
      Future.delayed(
          Duration(milliseconds: 120), () => HapticFeedback.selectionClick());
    }
  }
}
