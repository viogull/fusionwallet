// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'erc20_wallet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Erc20WalletAdapter extends TypeAdapter<Erc20Wallet> {
  @override
  final int typeId = 4;

  @override
  Erc20Wallet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Erc20Wallet(
      name: fields[0] as String,
      address: fields[2] as String,
      privateKey: fields[1] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, Erc20Wallet obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.privateKey)
      ..writeByte(2)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Erc20WalletAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
