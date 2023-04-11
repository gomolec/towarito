// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_action_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryActionAdapter extends TypeAdapter<HistoryAction> {
  @override
  final int typeId = 3;

  @override
  HistoryAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryAction(
      id: fields[0] as String?,
      oldProduct: fields[1] as Product?,
      updatedProduct: fields[2] as Product?,
      isRedo: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryAction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.oldProduct)
      ..writeByte(2)
      ..write(obj.updatedProduct)
      ..writeByte(3)
      ..write(obj.isRedo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryActionTypeAdapter extends TypeAdapter<HistoryActionType> {
  @override
  final int typeId = 4;

  @override
  HistoryActionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HistoryActionType.productCreated;
      case 1:
        return HistoryActionType.productUpdated;
      case 2:
        return HistoryActionType.productDeleted;
      default:
        return HistoryActionType.productCreated;
    }
  }

  @override
  void write(BinaryWriter writer, HistoryActionType obj) {
    switch (obj) {
      case HistoryActionType.productCreated:
        writer.writeByte(0);
        break;
      case HistoryActionType.productUpdated:
        writer.writeByte(1);
        break;
      case HistoryActionType.productDeleted:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryActionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
