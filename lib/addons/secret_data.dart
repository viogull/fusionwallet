import 'package:flutter/cupertino.dart';

class SecretData {
  static SecretData transform(Map<String, dynamic> channelAddressData) {
    return (channelAddressData == null)
        ? null
        : SecretData(
            mnemonic: channelAddressData['mnemonic'],
            seed: channelAddressData['seed'],
            public_key: channelAddressData['public_key'],
            private_key: channelAddressData['private_key']);
  }

  String mnemonic;
  String seed;
  String public_key;
  String private_key;

  SecretData(
      {@required this.mnemonic,
      this.seed,
      this.private_key,
      this.public_key}) {}
}
