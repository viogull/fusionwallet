// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountAdapter extends TypeAdapter<Account> {
  @override
  final int typeId = 0;

  @override
  Account read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Account(
      name: fields[0] as String,
      mnemonic: fields[1] as String,
      seed: fields[2] as String,
      address: fields[3] as String,
      publicKey: fields[4] as String,
      privateKey: fields[5] as String,
    )
      ..pin = fields[6] as String
      ..showRewards = fields[7] as bool
      ..sessionKey = fields[8] as String
      ..hash = fields[9] as String
      ..hasAccess = fields[10] as bool
      ..uuid = fields[11] as String;
  }

  @override
  void write(BinaryWriter writer, Account obj) {
    writer
      ..writeByte(12)
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
      ..writeByte(6)
      ..write(obj.pin)
      ..writeByte(7)
      ..write(obj.showRewards)
      ..writeByte(8)
      ..write(obj.sessionKey)
      ..writeByte(9)
      ..write(obj.hash)
      ..writeByte(10)
      ..write(obj.hasAccess)
      ..writeByte(11)
      ..write(obj.uuid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
