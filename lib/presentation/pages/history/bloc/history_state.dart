part of 'history_bloc.dart';

enum HistoryStatus { initial, loading, success }

class HistoryState extends Equatable {
  final HistoryStatus status;
  final List<HistoryAction> history;
  final bool canUndo;
  final bool canRedo;
  final Failure? failure;

  const HistoryState(
      {this.status = HistoryStatus.initial,
      this.history = const [],
      this.canUndo = false,
      this.canRedo = false,
      this.failure});

  HistoryState copyWith({
    HistoryStatus? status,
    List<HistoryAction>? history,
    bool? canUndo,
    bool? canRedo,
    Failure? Function()? failure,
  }) {
    return HistoryState(
        status: status ?? this.status,
        history: history ?? this.history,
        canUndo: canUndo ?? this.canUndo,
        canRedo: canRedo ?? this.canRedo,
        failure: failure != null ? failure() : this.failure);
  }

  @override
  String toString() {
    return 'HistoryState(status: $status, history: $history, canUndo: $canUndo, canRedo: $canRedo, failure: $failure)';
  }

  @override
  List<Object?> get props => [status, history, canUndo, canRedo, failure];
}
