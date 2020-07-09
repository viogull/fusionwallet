import 'package:flutter/material.dart';
import 'package:nanodart/nanodart.dart';

class NanoUtil {
  static String seedToPrivate(String seed, int index) {
    return NanoKeys.seedToPrivate(seed, index);
  }

  static String seedToAddress(String seed, int index) {
    return NanoAccounts.createAccount(NanoAccountType.NANO,
        NanoKeys.createPublicKey(seedToPrivate(seed, index)));
  }

  Future<void> loginAccount(String seed, BuildContext context) async {
    //Account selectedAcct ;
    // if (selectedAcct == null) {
    //  selectedAcct = Account(index: 0, lastAccess: 0, name: AppLocalizations.of(context).defaultAccountName, selected: true);
    //await injector.get<DBHelper>().saveAccount(selectedAcct);
  }
  // StateContainer.of(context).updateWallet(account: selectedAcct);

}
