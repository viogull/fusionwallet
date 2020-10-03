import 'package:hive/hive.dart';

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
  String pin;
  @HiveField(7)
  bool showRewards = true;
  @HiveField(8)
  String sessionKey = ""; // used to persist DB ID
  @HiveField(9)
  String hash;
  @HiveField(10)
  bool hasAccess = true;
  @HiveField(11)
  String uuid;

  Account(
      {this.name,
      this.mnemonic,
      this.seed,
      this.address,
      this.publicKey,
      this.privateKey});
}
