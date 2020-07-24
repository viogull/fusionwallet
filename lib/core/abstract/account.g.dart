// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final typeId = 0;

  @override
  Account read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      name: fields[0] as String,
      mnemonic: fields[1] as String,
      seed: fields[2] as String,
      address: fields[3] as String,
      publicKey: fields[4] as String,
      privateKey: fields[5] as String,
    )
      ..pin = fields[7] as String
      ..showRewards = fields[11] as bool
      ..sessionKey = fields[12] as String;
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mnemonic)
      ..writeByte(2)
      ..write(obj.seed)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.publicKey)
      ..writeByte(5)
      ..write(obj.privateKey)
      ..writeByte(7)
      ..write(obj.pin)
      ..writeByte(11)
      ..write(obj.showRewards)
      ..writeByte(12)
      ..write(obj.sessionKey);
  }
}
