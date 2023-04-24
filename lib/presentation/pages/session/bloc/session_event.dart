part of 'session_bloc.dart';

abstract class SessionEvent extends Equatable {
  const SessionEvent();

  @override
  List<Object?> get props => [];
}

class SessionSubscriptionRequested extends SessionEvent {
  final String? initialSessionId;

  const SessionSubscriptionRequested({
    this.initialSessionId,
  });

  @override
  List<Object?> get props => [initialSessionId];
}

class SessionNameChanged extends SessionEvent {
  final String name;

  const SessionNameChanged({
    required this.name,
  });

  @override
  List<Object> get props => [name];
}

class SessionNoteChanged extends SessionEvent {
  final String note;

  const SessionNoteChanged({
    required this.note,
  });

  @override
  List<Object> get props => [note];
}

class SessionAuthorChanged extends SessionEvent {
  final String author;

  const SessionAuthorChanged({
    required this.author,
  });

  @override
  List<Object> get props => [author];
}

class SessionUseRemoteDataChanged extends SessionEvent {
  final bool useRemoteData;

  const SessionUseRemoteDataChanged({
    required this.useRemoteData,
  });

  @override
  List<Object> get props => [useRemoteData];
}

class SessionSubmitted extends SessionEvent {
  const SessionSubmitted();
}
