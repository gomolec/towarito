part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final Session? currentSession;
  final int sessionProgress;
  final List<Product> bookmarkedProducts;
  final Failure? failure;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.currentSession,
    this.sessionProgress = 0,
    this.bookmarkedProducts = const [],
    this.failure,
  });

  bool get hasCurrentSession => currentSession != null;

  @override
  List<Object?> get props => [
        status,
        currentSession,
        sessionProgress,
        bookmarkedProducts,
        failure,
      ];

  DashboardState copyWith({
    DashboardStatus? status,
    Session? Function()? currentSession,
    int? sessionProgress,
    List<Product>? bookmarkedProducts,
    Failure? Function()? failure,
  }) {
    return DashboardState(
      status: status ?? this.status,
      currentSession:
          currentSession != null ? currentSession() : this.currentSession,
      sessionProgress: sessionProgress ?? this.sessionProgress,
      bookmarkedProducts: bookmarkedProducts ?? this.bookmarkedProducts,
      failure: failure != null ? failure() : this.failure,
    );
  }

  @override
  String toString() {
    return 'DashboardState(status: $status, currentSession: $currentSession, sessionProgress: $sessionProgress, bookmarkedProducts: $bookmarkedProducts, failure: $failure)';
  }
}
