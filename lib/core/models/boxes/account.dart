import 'package:hive/hive.dart';

import 'contact.dart';

part 'account.g.dart';

@HiveType(typeId: 0)
class Account extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String mnemonic;
  @HiveField(2)
  String seed;
  @HiveField(3)
  String address;

  @HiveField(4)
  String publicKey;

  @HiveField(5)
  String privateKey;

  @HiveField(6)
  List<Contact> contacts;

  @HiveField(7)
  String pin;

  @HiveField(8)
  bool biometricEnabled;

  @HiveField(9)
  String locale = 'ru';

  @HiveField(10)
  bool darkModeEnabled = false;

  @HiveField(11)
  bool showRewards = true;

  Account(
      {this.name,
      this.mnemonic,
      this.seed,
      this.address,
      this.publicKey,
      this.privateKey});
}
