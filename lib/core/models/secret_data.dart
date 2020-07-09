import 'package:flutter/cupertino.dart';

class SecretData {
  static SecretData transform(Map<String, dynamic> data) {
    return (data == null)
        ? null
        : SecretData(
            mnemonic: data['mnemonic'] as String,
            seed: data['seed'] as String,
            address: data['address'] as String,
            public_key: data['public_key'] as String,
            private_key: data['private_key'] as String);
  }

  final String mnemonic;
  final String seed;
  final String public_key;
  final String private_key;
  final String address;

  const SecretData(
      {@required this.mnemonic,
      this.seed,
      this.address,
      this.private_key,
      this.public_key});
}
