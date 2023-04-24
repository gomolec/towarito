import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/sessions_adapter.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AppScaffoldMessager _appScaffoldMessager;
  final SessionsAdapter _sessionsAdapter;
  SessionBloc({
    required SessionsAdapter sessionsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _sessionsAdapter = sessionsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const SessionState()) {
    on<SessionSubscriptionRequested>(_onSessionSubscriptionRequested);
    on<SessionNameChanged>(_onSessionNameChanged);
    on<SessionNoteChanged>(_onSessionNoteChanged);
    on<SessionAuthorChanged>(_onSessionAuthorChanged);
    on<SessionUseRemoteDataChanged>(_onSessionUseRemoteDataChanged);
    on<SessionSubmitted>(_onSessionSubmitted);
  }

  Future<void> _onSessionSubscriptionRequested(
    SessionSubscriptionRequested event,
    Emitter<SessionState> emit,
  ) async {
    Session? initialSession;
    emit(state.copyWith(status: SessionStatus.loading));
    if (event.initialSessionId != null) {
      final result =
          await _sessionsAdapter.getSession(id: event.initialSessionId!);
      result.fold(
        (l) {
          emit(state.copyWith(
            status: SessionStatus.failure,
            failure: () => l,
          ));
          _appScaffoldMessager.showSnackbar(message: l.errorMessage);
        },
        (r) => initialSession = r,
      );
    }
    emit(state.copyWith(
      status: SessionStatus.inProgress,
      initialSession: initialSession,
      name: initialSession?.name,
      note: initialSession?.note,
      author: initialSession?.author,
      useRemoteData: initialSession?.useRemoteData,
      failure: () => null,
    ));
  }

  void _onSessionNameChanged(
    SessionNameChanged event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      status: SessionStatus.inProgress,
      failure: () => null,
    ));
  }

  void _onSessionNoteChanged(
    SessionNoteChanged event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(
      note: event.note,
      status: SessionStatus.inProgress,
      failure: () => null,
    ));
  }

  void _onSessionAuthorChanged(
    SessionAuthorChanged event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(
      author: event.author,
      status: SessionStatus.inProgress,
      failure: () => null,
    ));
  }

  void _onSessionUseRemoteDataChanged(
    SessionUseRemoteDataChanged event,
    Emitter<SessionState> emit,
  ) {
    emit(state.copyWith(
      useRemoteData: event.useRemoteData,
      status: SessionStatus.inProgress,
      failure: () => null,
    ));
  }

  Future<void> _onSessionSubmitted(
    SessionSubmitted event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(status: SessionStatus.loading));

    final result = state.initialSession == null
        ? await _sessionsAdapter.createSession(
            session: Session(
            name: state.name,
            note: state.note,
            author: state.author,
            useRemoteData: state.useRemoteData,
          ))
        : await _sessionsAdapter.updateSession(
            session: state.initialSession!.copyWith(
            name: state.name,
            note: state.note,
            author: state.author,
            useRemoteData: state.useRemoteData,
          ));

    result.fold(
      (l) {
        emit(state.copyWith(
          status: SessionStatus.failure,
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(status: SessionStatus.success));
        _appScaffoldMessager.showSnackbar(
            message: state.initialSession == null
                ? "Sesja została utworzona."
                : "Sesja została zaktualizowana.");
      },
    );
  }
}
