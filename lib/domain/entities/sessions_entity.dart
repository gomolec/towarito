import 'package:equatable/equatable.dart';

import '../../data/models/models.dart';

class SessionsEntity extends Equatable {
  final List<Session> sessions;
  final Session? currentSession;

  const SessionsEntity({
    required this.sessions,
    this.currentSession,
  });

  bool get hasCurrentSession => currentSession != null;

  SessionsEntity copyWith({
    List<Session>? sessions,
    Session? Function()? currentSession,
  }) {
    return SessionsEntity(
      sessions: sessions ?? this.sessions,
      currentSession:
          currentSession != null ? currentSession() : this.currentSession,
    );
  }

  @override
  String toString() =>
      'SessionsEntity(sessions: $sessions, currentSession: $currentSession)';

  @override
  List<Object?> get props => [sessions, currentSession];
}
