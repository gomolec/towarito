import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'session_model.g.dart';

@HiveType(typeId: 1)
class Session extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime created;
  @HiveField(3)
  final DateTime updated;
  @HiveField(4)
  final DateTime? finished;
  @HiveField(5)
  final String author;
  @HiveField(6)
  final String note;
  @HiveField(7)
  final bool useRemoteData;

  Session({
    String? id,
    this.name = '',
    DateTime? created,
    DateTime? updated,
    this.finished,
    this.author = '',
    this.note = '',
    this.useRemoteData = false,
  })  : id = id ?? const Uuid().v4(),
        created = created ?? DateTime.now(),
        updated = updated ?? DateTime.now();

  bool get isFinished => finished != null;

  Session copyWith({
    String? id,
    String? name,
    DateTime? created,
    DateTime? updated,
    DateTime? Function()? finished,
    String? author,
    String? note,
    bool? useRemoteData,
  }) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      created: created ?? this.created,
      updated: updated,
      finished: finished != null ? finished() : this.finished,
      author: author ?? this.author,
      note: note ?? this.note,
      useRemoteData: useRemoteData ?? this.useRemoteData,
    );
  }

  @override
  String toString() {
    return 'Session(id: $id, name: $name, created: $created, updated: $updated, finished: $finished, author: $author, note: $note, useRemoteData: $useRemoteData)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      created,
      updated,
      finished,
      author,
      note,
      useRemoteData,
    ];
  }
}
