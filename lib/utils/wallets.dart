import 'dart:math';

import 'package:fusion_wallet/core/abstract/erc20_wallet.dart';
import 'package:fusion_wallet/main.dart';
import 'package:hive/hive.dart';
import 'package:web3dart/credentials.dart';

import '../inject.dart';

class Wallets {


  final log = injector.get<Logger>();

  Box<Erc20Wallet> _erc20walletsBox;

   Wallets() {
    _erc20walletsBox = Hive.box(erc20walletsBox);
    log.d("Checking if wallet exist. -> $isErcWalletExist");
    if(isErcWalletExist) {
      log.d("ERC-20 Wallet exists.");
    } else {
      log.d("ERC-20 Wallet not exists. Creating...");
      createEthWallet().then((wallet) => {
      }).catchError((onError) {
        log.e(onError);
      });
    }
  }

  bool get isErcWalletExist  => _erc20walletsBox.isNotEmpty;


 Erc20Wallet get wallet => _erc20walletsBox.getAt(0);



  static Future<Wallet> createEthWallet({String password}) async {
    final rng = new Random.secure();
    Credentials creds = EthPrivateKey.createRandom(rng);
    final wallet = Wallet.createNew(creds, password, rng);
    return wallet;
  }
}
