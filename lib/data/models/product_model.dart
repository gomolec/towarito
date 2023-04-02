import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: 2)
class Product extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String code;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final int targetQuantity;
  @HiveField(5)
  final DateTime created;
  @HiveField(6)
  final DateTime updated;
  @HiveField(7)
  final String note;
  @HiveField(8)
  final bool bookmarked;
  @HiveField(9)
  final String? imageUrl;
  @HiveField(10)
  final String? url;

  Product({
    String? id,
    this.name = '',
    this.code = '',
    this.quantity = 0,
    this.targetQuantity = 0,
    DateTime? created,
    DateTime? updated,
    this.note = '',
    this.bookmarked = false,
    this.imageUrl,
    this.url,
  })  : id = id ?? const Uuid().v4(),
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();

  bool get reachedTargetQuantity => quantity == targetQuantity;

  Product copyWith({
    String? id,
    String? name,
    String? code,
    int? quantity,
    int? targetQuantity,
    DateTime? created,
    DateTime? updated,
    String? note,
    bool? bookmarked,
    String? Function()? imageUrl,
    String? Function()? url,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      note: note ?? this.note,
      bookmarked: bookmarked ?? this.bookmarked,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
      url: url != null ? url() : this.url,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, code: $code, quantity: $quantity, targetQuantity: $targetQuantity, created: $created, updated: $updated, note: $note, bookmarked: $bookmarked, imageUrl: $imageUrl, url: $url)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      code,
      quantity,
      targetQuantity,
      created,
      updated,
      note,
      bookmarked,
      imageUrl,
      url,
    ];
  }
}
