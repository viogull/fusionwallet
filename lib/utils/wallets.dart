import 'dart:math';

import 'package:web3dart/credentials.dart';

class Wallets {
  static Future<EthereumAddress> createEthWallet() async {
    final rng = new Random.secure();
    Credentials creds = EthPrivateKey.createRandom(rng);
    return await creds.extractAddress();
  }
}
