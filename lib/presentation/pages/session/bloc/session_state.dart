part of 'session_bloc.dart';

enum SessionStatus { initial, loading, inProgress, success, failure }

class SessionState extends Equatable {
  final SessionStatus status;
  final Session? initialSession;
  final String name;
  final String note;
  final String author;
  final bool useRemoteData;
  final Failure? failure;

  const SessionState({
    this.status = SessionStatus.initial,
    this.initialSession,
    this.name = '',
    this.note = '',
    this.author = '',
    this.useRemoteData = false,
    this.failure,
  });

  bool get isNewSession => initialSession == null;

  SessionState copyWith({
    SessionStatus? status,
    Session? initialSession,
    String? name,
    String? note,
    String? author,
    bool? useRemoteData,
    Failure? Function()? failure,
  }) {
    return SessionState(
      status: status ?? this.status,
      initialSession: initialSession ?? this.initialSession,
      name: name ?? this.name,
      note: note ?? this.note,
      author: author ?? this.author,
      useRemoteData: useRemoteData ?? this.useRemoteData,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  String toString() {
    return 'SessionState(status: $status, initialSession: $initialSession, name: $name, note: $note, author: $author, useRemoteData: $useRemoteData: failure: $failure)';
  }

  @override
  List<Object?> get props {
    return [
      status,
      initialSession,
      name,
      note,
      author,
      useRemoteData,
      failure,
    ];
  }
}
