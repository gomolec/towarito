import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'history_action_model.g.dart';

@HiveType(typeId: 4)
enum HistoryActionType {
  @HiveField(0)
  productCreated,
  @HiveField(1)
  productUpdated,
  @HiveField(2)
  productDeleted,
}

@HiveType(typeId: 3)
class HistoryAction extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final Product? oldProduct;
  @HiveField(2)
  final Product? updatedProduct;
  @HiveField(3)
  final bool isRedo;

  HistoryAction({
    String? id,
    this.oldProduct,
    this.updatedProduct,
    this.isRedo = false,
  }) : id = id ?? const Uuid().v4();

  HistoryActionType get historyActionType {
    if (oldProduct != null && updatedProduct != null) {
      return HistoryActionType.productUpdated;
    }
    if (oldProduct != null) {
      return HistoryActionType.productDeleted;
    }
    return HistoryActionType.productCreated;
  }

  HistoryAction copyWith({
    String? id,
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
    return 'HistoryAction(id: $id, oldProduct: $oldProduct, updatedProduct: $updatedProduct, isRedo: $isRedo)';
  }

  @override
  List<Object?> get props => [id, oldProduct, updatedProduct, isRedo];
}
