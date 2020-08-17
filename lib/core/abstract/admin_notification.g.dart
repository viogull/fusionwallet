// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdminNotificationAdapter extends TypeAdapter<AdminNotification> {
  @override
  final int typeId = 3;

  @override
  AdminNotification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminNotification()
      .._id = fields[0] as String
      .._title = fields[1] as String
      .._message = fields[2] as String
      .._notificationId = fields[3] as String
      .._created = fields[4] as String
      .._v = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, AdminNotification obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._title)
      ..writeByte(2)
      ..write(obj._message)
      ..writeByte(3)
      ..write(obj._notificationId)
      ..writeByte(4)
      ..write(obj._created)
      ..writeByte(5)
      ..write(obj._v);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminNotificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
