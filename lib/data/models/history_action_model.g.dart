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
      id: fields[0] as int,
      oldProduct: fields[1] as Product?,
      updatedProduct: fields[2] as Product?,
      isRedo: fields[3] as bool,
      actionType: fields[4] as HistoryActionType?,
      updateType: fields[5] as HistoryUpdateType?,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryAction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.oldProduct)
      ..writeByte(2)
      ..write(obj.updatedProduct)
      ..writeByte(3)
      ..write(obj.isRedo)
      ..writeByte(4)
      ..write(obj.actionType)
      ..writeByte(5)
      ..write(obj.updateType);
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
        return HistoryActionType.created;
      case 1:
        return HistoryActionType.updated;
      case 2:
        return HistoryActionType.deleted;
      default:
        return HistoryActionType.created;
    }
  }

  @override
  void write(BinaryWriter writer, HistoryActionType obj) {
    switch (obj) {
      case HistoryActionType.created:
        writer.writeByte(0);
        break;
      case HistoryActionType.updated:
        writer.writeByte(1);
        break;
      case HistoryActionType.deleted:
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

class HistoryUpdateTypeAdapter extends TypeAdapter<HistoryUpdateType> {
  @override
  final int typeId = 5;

  @override
  HistoryUpdateType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HistoryUpdateType.quantity;
      case 1:
        return HistoryUpdateType.bookmarking;
      case 2:
        return HistoryUpdateType.none;
      default:
        return HistoryUpdateType.quantity;
    }
  }

  @override
  void write(BinaryWriter writer, HistoryUpdateType obj) {
    switch (obj) {
      case HistoryUpdateType.quantity:
        writer.writeByte(0);
        break;
      case HistoryUpdateType.bookmarking:
        writer.writeByte(1);
        break;
      case HistoryUpdateType.none:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryUpdateTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
