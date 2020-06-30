



import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fusion_wallet/core/models/address.dart';
import 'package:logger/logger.dart';
import 'package:nanodart/nanodart.dart';
import 'package:validators/validators.dart';

import '../service_locator.dart';


enum DataType { RAW, URL, ADDRESS, MANTA_ADDRESS, SEED }

class QRScanErrs {
  static const String PERMISSION_DENIED = "qr_denied";
  static const String UNKNOWN_ERROR = "qr_unknown";
  static const String CANCEL_ERROR = "qr_cancel";
  static const List<String> ERROR_LIST = [PERMISSION_DENIED, UNKNOWN_ERROR, CANCEL_ERROR];
}

class IOTools {
  static final Logger log = injector.get<Logger>();

  static const MethodChannel _channel = const MethodChannel('fappchannel');
  static StreamSubscription<dynamic> setStream;

  static String _parseData(String data, DataType type) {
    data = data.trim();
    if (type == DataType.RAW) {
      return data;
    } else if (type == DataType.URL) {
      if (isIP(data)) {
        return data;
      } else if (isURL(data)) {
        return data;
      }
    } else if (type == DataType.ADDRESS) {
      Address address = Address(data);
      if (address.isValid()) {
        return address.address;
      }
    } else if (type == DataType.MANTA_ADDRESS) {
      // Check if an address or manta result
      Address address = Address(data);
      if (address.isValid()) {
        return data;
      } /* else if (MantaWallet.parseUrl(data) != null) {
        return data;
      } */
    } else if (type == DataType.SEED) {
      // Check if valid seed
      if (NanoSeeds.isValidSeed(data)) {
        return data;
      }
    }
    return null;
  }

  static Future<String> getClipboardText(DataType type) async {
    ClipboardData data = await Clipboard.getData("text/plain");
    if (data == null || data.text == null) {
      return null;
    }
    return _parseData(data.text, type);
  }


  static Future<void> setSecureClipboardItem(String value) async {
    if (Platform.isIOS) {
      final Map<String, dynamic> params = <String, dynamic>{
        'value': value,
      };
      await _channel.invokeMethod("setSecureClipboardItem", params);
    } else {
      // Set item in clipboard
      await Clipboard.setData(new ClipboardData(text: value));
      // Auto clear it after 2 minutes
      if (setStream != null) {
        setStream.cancel();
      }
      Future<dynamic> delayed = new Future.delayed(new Duration(minutes: 2));
      delayed.then((_) {
        return true;
      });
      setStream = delayed.asStream().listen((_) {
        Clipboard.getData("text/plain").then((data) {
          if (data != null && data.text != null && NanoSeeds.isValidSeed(data.text)) {
            Clipboard.setData(ClipboardData(text: ""));
          }
        });
      });
    }
  }
}