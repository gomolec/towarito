part of 'sessions_bloc.dart';

enum SessionsStatus { initial, loading, success, failure }

class SessionsState extends Equatable {
  final SessionsStatus status;
  final Session? currentSession;
  final List<Session> sessions;
  final Failure? failure;

  const SessionsState({
    this.status = SessionsStatus.initial,
    this.currentSession,
    this.sessions = const [],
    this.failure,
  });

  bool get hasCurrentSession => currentSession != null;

  SessionsState copyWith({
    SessionsStatus? status,
    Session? Function()? currentSession,
    List<Session>? sessions,
    Failure? Function()? failure,
  }) {
    return SessionsState(
      status: status ?? this.status,
      currentSession:
          currentSession != null ? currentSession() : this.currentSession,
      sessions: sessions ?? this.sessions,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  String toString() {
    return 'SessionsState(status: $status, currentSession: $currentSession, sessions: $sessions, failure: $failure)';
  }

  @override
  List<Object?> get props => [status, currentSession, sessions, failure];
}
