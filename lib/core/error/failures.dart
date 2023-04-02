import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String text;

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
