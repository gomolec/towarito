import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? text;

  const Failure(
    this.text,
  );

  String get errorMessage => "Wystąpił błąd. $text";

  @override
  List<Object> get props => [errorMessage];
}

class CreateSessionFailure extends Failure {
  const CreateSessionFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas tworzenia sesji. $text";
}

class MaxNumberOfSessionReached extends Failure {
  const MaxNumberOfSessionReached(super.text);

  @override
  String get errorMessage =>
      "Osiągnięto maksymalną liczbę zapisanych sesji - usuń niepotrzebne. $text";
}

class CannotDeleteCurrentSession extends Failure {
  const CannotDeleteCurrentSession(super.text);

  @override
  String get errorMessage =>
      "Nie można usunąć aktualnej sesji, najpierw ją zakończ. $text";
}

class DeleteSessionFailure extends Failure {
  const DeleteSessionFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas usuwania sesji. $text";
}

class FinishCurrentSessionFailure extends Failure {
  const FinishCurrentSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas kończenia aktualnej sesji. $text";
}

class SessionNotFoundFailure extends Failure {
  const SessionNotFoundFailure(super.text);

  @override
  String get errorMessage => "Sesja z wskazanym id nie istnieje. $text";
}

class GetSessionFailure extends Failure {
  const GetSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas pobierania sesji o wskazanym id. $text";
}

class StartCurrentSessionFailure extends Failure {
  const StartCurrentSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas wznawiania aktualnej sesji. $text";
}

class UpdateSessionFailure extends Failure {
  const UpdateSessionFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas modyfikacji sesji. $text";
}
