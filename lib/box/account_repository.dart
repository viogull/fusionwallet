import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'models/account.dart';

class AccountRepository {
  final Box<Account> accounts;

  const AccountRepository({@required this.accounts});

  Account getLastAccount() {
    var last = accounts.getAt(accounts.length - 1);
    debugPrint("Last Account Get: $last");
    return last;
  }
}
