// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferencesAdapter extends TypeAdapter<Preferences> {
  @override
  final int typeId = 2;

  @override
  Preferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Preferences()
      ..biometricEnabled = fields[0] as bool
      ..darkThemeEnabled = fields[1] as bool
      ..locale = fields[2] as String
      ..name = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, Preferences obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.biometricEnabled)
      ..writeByte(1)
      ..write(obj.darkThemeEnabled)
      ..writeByte(2)
      ..write(obj.locale)
      ..writeByte(3)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
