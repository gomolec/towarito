import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

class HistoryEntity extends Equatable {
  final List<HistoryAction> history;
  final bool canUndo;
  final bool canRedo;

  const HistoryEntity({
    required this.history,
    required this.canUndo,
    required this.canRedo,
  });

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
  List<Object> get props => [history, canUndo, canRedo];
}
