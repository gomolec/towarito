import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

class HistoryEntity extends Equatable {
  final List<HistoryAction>? history;
  final bool canUndo;
  final bool canRedo;

  const HistoryEntity({
    this.history,
    this.canUndo = false,
    this.canRedo = false,
  });

  bool get isSessionOpened => history != null;

  HistoryEntity copyWith({
    List<HistoryAction>? history,
    bool? canUndo,
    bool? canRedo,
  }) {
    return HistoryEntity(
      history: history ?? this.history,
      canUndo: canUndo ?? this.canUndo,
      canRedo: canRedo ?? this.canRedo,
    );
  }

  @override
  String toString() =>
      'HistoryEntity(history: $history, canUndo: $canUndo, canRedo: $canRedo)';

  @override
  List<Object?> get props => [history, canUndo, canRedo];
}
