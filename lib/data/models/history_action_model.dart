import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models.dart';

part 'history_action_model.g.dart';

@HiveType(typeId: 4)
enum HistoryActionType {
  @HiveField(0)
  created,
  @HiveField(1)
  updated,
  @HiveField(2)
  deleted,
}

@HiveType(typeId: 5)
enum HistoryUpdateType {
  @HiveField(0)
  quantity,
  @HiveField(1)
  bookmarking,
  @HiveField(2)
  none,
}

@HiveType(typeId: 3)
class HistoryAction extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final Product? oldProduct;
  @HiveField(2)
  final Product? updatedProduct;
  @HiveField(3)
  final bool isRedo;
  @HiveField(4)
  final HistoryActionType actionType;
  @HiveField(5)
  final HistoryUpdateType updateType;

  HistoryAction({
    required this.id,
    this.oldProduct,
    this.updatedProduct,
    this.isRedo = false,
    HistoryActionType? actionType,
    HistoryUpdateType? updateType,
  })  : actionType = actionType ??
            _historyActionType(
              oldProduct: oldProduct,
              updatedProduct: updatedProduct,
            ),
        updateType = updateType ??
            _historyUpdateType(
              oldProduct: oldProduct,
              updatedProduct: updatedProduct,
            );

  HistoryAction copyWith({
    int? id,
    Product? Function()? oldProduct,
    Product? Function()? updatedProduct,
    bool? isRedo,
  }) {
    return HistoryAction(
      id: id ?? this.id,
      oldProduct: oldProduct != null ? oldProduct() : this.oldProduct,
      updatedProduct:
          updatedProduct != null ? updatedProduct() : this.updatedProduct,
      isRedo: isRedo ?? this.isRedo,
    );
  }

  @override
  String toString() {
    return 'HistoryAction(id: $id, oldProduct: $oldProduct, updatedProduct: $updatedProduct, isRedo: $isRedo, actionType: $actionType, updateType: $updateType)';
  }

  @override
  List<Object?> get props => [
        id,
        oldProduct,
        updatedProduct,
        isRedo,
      ];

  static HistoryActionType _historyActionType({
    Product? oldProduct,
    Product? updatedProduct,
  }) {
    if (oldProduct != null && updatedProduct != null) {
      return HistoryActionType.updated;
    }
    if (oldProduct != null) {
      return HistoryActionType.deleted;
    }
    return HistoryActionType.created;
  }

  static HistoryUpdateType _historyUpdateType({
    Product? oldProduct,
    Product? updatedProduct,
  }) {
    if (oldProduct == null || updatedProduct == null) {
      return HistoryUpdateType.none;
    }
    if (oldProduct.bookmarked != updatedProduct.bookmarked) {
      return HistoryUpdateType.bookmarking;
    }
    if (oldProduct.quantity != updatedProduct.quantity) {
      return HistoryUpdateType.quantity;
    }
    return HistoryUpdateType.none;
  }
}
