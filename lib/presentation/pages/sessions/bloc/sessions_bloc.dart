import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/app/app_scaffold_messager.dart';
import '../../../../core/error/failures.dart';
import '../../../../data/models/models.dart';
import '../../../../domain/adapters/sessions_adapter.dart';
import '../../../../domain/entities/sessions_entity.dart';

part 'sessions_event.dart';
part 'sessions_state.dart';

class SessionsBloc extends Bloc<SessionsEvent, SessionsState> {
  final SessionsAdapter _sessionsAdapter;
  final AppScaffoldMessager _appScaffoldMessager;

  SessionsBloc({
    required SessionsAdapter sessionsAdapter,
    required AppScaffoldMessager appScaffoldMessager,
  })  : _sessionsAdapter = sessionsAdapter,
        _appScaffoldMessager = appScaffoldMessager,
        super(const SessionsState()) {
    on<SessionsSubscriptionRequested>(_onSubscriptionRequested);
    on<SessionDeleted>(_onSessionDeleted);
    on<SessionStarted>(_onSessionStarted);
    on<SessionFinished>(_onSessionFinished);
  }

  Future<void> _onSubscriptionRequested(
    SessionsSubscriptionRequested event,
    Emitter<SessionsState> emit,
  ) async {
    emit(state.copyWith(
      status: SessionsStatus.loading,
    ));

    await emit.onEach<SessionsEntity>(
      _sessionsAdapter.observeSessionsData(),
      onData: (data) => emit(state.copyWith(
        status: SessionsStatus.success,
        currentSession: () => data.currentSession,
        sessions: List.of(data.sessions),
        failure: () => null,
      )),
      onError: (error, stackTrace) {
        emit(state.copyWith(
          status: SessionsStatus.failure,
          failure: () => UnnamedFailure(error.toString()),
        ));
        _appScaffoldMessager.showSnackbar(message: error.toString());
      },
    );
  }

  Future<void> _onSessionDeleted(
    SessionDeleted event,
    Emitter<SessionsState> emit,
  ) async {
    final result = await _sessionsAdapter.deleteSession(
      id: event.id,
    );
    emitEitherResult(
      emit,
      result,
      snackbarSuccessMessage: "Sesja została usunięta.",
    );
  }

  Future<void> _onSessionStarted(
    SessionStarted event,
    Emitter<SessionsState> emit,
  ) async {
    final result = await _sessionsAdapter.startCurrentSession(
      id: event.id,
    );
    emitEitherResult(
      emit,
      result,
      snackbarSuccessMessage: "Sesja została rozpoczęta.",
    );
  }

  Future<void> _onSessionFinished(
    SessionFinished event,
    Emitter<SessionsState> emit,
  ) async {
    final result = await _sessionsAdapter.finishCurrentSession();
    emitEitherResult(
      emit,
      result,
      snackbarSuccessMessage: "Sesja została zakończona.",
    );
  }

  void emitEitherResult(
    Emitter<SessionsState> emit,
    Either<Failure, dynamic> result, {
    String? snackbarSuccessMessage,
  }) {
    result.fold(
      (l) {
        emit(state.copyWith(
          status: SessionsStatus.failure,
          failure: () => l,
        ));
        _appScaffoldMessager.showSnackbar(message: l.errorMessage);
      },
      (r) {
        emit(state.copyWith(
          status: SessionsStatus.success,
          failure: () => null,
        ));
        if (snackbarSuccessMessage != null) {
          _appScaffoldMessager.showSnackbar(message: snackbarSuccessMessage);
        }
      },
    );
  }
}
