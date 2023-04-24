part of 'sessions_bloc.dart';

abstract class SessionsEvent extends Equatable {
  const SessionsEvent();

  @override
  List<Object> get props => [];
}

class SessionsSubscriptionRequested extends SessionsEvent {
  const SessionsSubscriptionRequested();
}

class SessionDeleted extends SessionsEvent {
  const SessionDeleted({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class SessionStarted extends SessionsEvent {
  const SessionStarted({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}

class SessionFinished extends SessionsEvent {
  const SessionFinished({
    required this.id,
  });

  final String id;

  @override
  List<Object> get props => [id];
}
