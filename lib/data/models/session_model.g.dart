// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SessionAdapter extends TypeAdapter<Session> {
  @override
  final int typeId = 1;

  @override
  Session read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Session(
      id: fields[0] as String?,
      name: fields[1] as String,
      created: fields[2] as DateTime?,
      updated: fields[3] as DateTime?,
      finished: fields[4] as DateTime?,
      author: fields[5] as String,
      note: fields[6] as String,
      useRemoteData: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Session obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.updated)
      ..writeByte(4)
      ..write(obj.finished)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.note)
      ..writeByte(7)
      ..write(obj.useRemoteData);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
