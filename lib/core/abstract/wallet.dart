import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../models.dart';

part 'wallet.g.dart';

class Wallet = _Wallet with _$Wallet;

abstract class _Wallet with Store {
  @observable
  Account account;

  @action
  void loadAccount({@required Account account}) {
    this.account = account;
  }
}
