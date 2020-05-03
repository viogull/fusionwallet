import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nanodart/nanodart.dart';
import 'package:pointycastle/api.dart' show ParametersWithIV, KeyParameter;
import 'package:pointycastle/export.dart';
import 'package:pointycastle/pointycastle.dart';

class Encryptor {
  final String key;
  final String iv;
  final ParametersWithIV<KeyParameter> _params;
  final Salsa20Engine _cipher = Salsa20Engine();

  Encryptor(this.key, this.iv)
      : _params = ParametersWithIV<KeyParameter>(
            KeyParameter(Uint8List.fromList(key.codeUnits)),
            Uint8List.fromList(iv.codeUnits));

  String encrypt(String plainText) {
    _cipher
      ..reset()
      ..init(true, _params);

    final input = Uint8List.fromList(plainText.codeUnits);
    final output = _cipher.process(input);

    return NanoHelpers.byteToHex(output);
  }

  String decrypt(String cipherText) {
    _cipher
      ..reset()
      ..init(false, _params);

    final input = NanoHelpers.hexToBytes(cipherText);
    final output = _cipher.process(input);

    return String.fromCharCodes(output);
  }

  static String generateEncryptionSecret(int length) {
    String result = ""; // Resulting passcode
    String chars =
        "abcdefghijklmnopqrstuvwxyz0123456789!?&+\\-'."; // Characters a passcode may contain
    var rng = new Random.secure();
    for (int i = 0; i < length; i++) {
      result += chars[rng.nextInt(chars.length)];
    }
    return result;
  }
}

class CryptoUtil {
  CryptoUtil();

  static String seedToPrivate(Map<dynamic, dynamic> params) {
    return NanoKeys.seedToPrivate(params['seed'], params['index']);
  }

  Future<String> seedToPrivateInIsolate(String seed, int index) async {
    return await compute(seedToPrivate, {'seed': seed, 'index': index});
  }

  static String seedToAddress(Map<dynamic, dynamic> params) {
    return NanoAccounts.createAccount(
        NanoAccountType.NANO, NanoKeys.createPublicKey(seedToPrivate(params)));
  }

  Future<String> seedToAddressInIsolate(String seed, int index) async {
    return await compute(seedToAddress, {'seed': seed, 'index': index});
  }

  Future<void> loginAccount(String seed, BuildContext context) async {
//    Account selectedAcct = await sl.get<DBHelper>().getSelectedAccount(seed);
//    if (selectedAcct == null) {
//      selectedAcct = Account(
//          index: 0,
//          lastAccess: 0,
//          name: AppLocalizations.of(context).defaultAccountName,
//          selected: true);
//     // await sl.get<DBHelper>().saveAccount(selectedAcct);
//    }
//    StateContainer.of(context).update(account: selectedAcct);
  }

  static Uint8List sha256(List<Uint8List> byteArrays) {
    Digest digest = Digest("SHA-256");
    Uint8List hashed = Uint8List(32);
    byteArrays.forEach((byteArray) {
      digest.update(byteArray, 0, byteArray.lengthInBytes);
    });
    digest.doFinal(hashed, 0);
    return hashed;
  }
}
