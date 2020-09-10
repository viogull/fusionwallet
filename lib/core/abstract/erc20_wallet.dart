




import 'dart:typed_data';

import 'package:hive/hive.dart';


part 'erc20_wallet.g.dart';

@HiveType(typeId: 4)
class Erc20Wallet extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  Uint8List privateKey;
  @HiveField(2)
  String address;

  Erc20Wallet(
      {this.name,
        this.address,
        this.privateKey});
}

