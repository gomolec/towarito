part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class HistorySubscriptionRequested extends HistoryEvent {
  const HistorySubscriptionRequested();
}

class HistoryUndone extends HistoryEvent {
  const HistoryUndone();
}

class HistoryRedone extends HistoryEvent {
  const HistoryRedone();
}
