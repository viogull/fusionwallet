// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PreferencesAdapter extends TypeAdapter<Preferences> {
  @override
  final typeId = 2;

  @override
  Preferences read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
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
}
