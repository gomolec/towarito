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

class UnnamedFailure extends Failure {
  const UnnamedFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd. $text";
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

class GetCurrentSessionFailure extends Failure {
  const GetCurrentSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas pobierania aktualnej sesji. $text";
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

class OpenProductsSessionFailure extends Failure {
  const OpenProductsSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas otwierania sesji z produktami. $text";
}

class CloseProductsSessionFailure extends Failure {
  const CloseProductsSessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas zamykania sesji z produktami. $text";
}

class CreateProductFailure extends Failure {
  const CreateProductFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas tworzenia produktu. $text";
}

class DeleteProductFailure extends Failure {
  const DeleteProductFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas usuwania produktu. $text";
}

class UpdateProductFailure extends Failure {
  const UpdateProductFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas modyfikowania produktu. $text";
}

class ProductNotFoundFailure extends Failure {
  const ProductNotFoundFailure(super.text);

  @override
  String get errorMessage => "Nie znaleziono produktu o wskazanym id. $text";
}

class GetProductFailure extends Failure {
  const GetProductFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas pobierania produktu o wskazanym id. $text";
}

class HistoryUndoFailure extends Failure {
  const HistoryUndoFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd podczas cofania czynności. $text";
}

class HistoryRedoFailure extends Failure {
  const HistoryRedoFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas ponawiania czynności. $text";
}

class OpenHistorySessionFailure extends Failure {
  const OpenHistorySessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas otwierania sesji z historią. $text";
}

class CloseHistorySessionFailure extends Failure {
  const CloseHistorySessionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas zamykania sesji z historią. $text";
}

class CreateHistoryActionFailure extends Failure {
  const CreateHistoryActionFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas tworzenia nowej akcji historii. $text";
}

class ImportFileFailure extends Failure {
  const ImportFileFailure(super.text);

  @override
  String get errorMessage => "Wystąpił błąd importowania pliku. $text";
}

class ImportProductsFailure extends Failure {
  const ImportProductsFailure(super.text);

  @override
  String get errorMessage =>
      "Wystąpił błąd podczas importowania produktów. $text";
}

// class FileExtensionNotSupportedFailure extends Failure {
//   const FileExtensionNotSupportedFailure(super.text);

//   @override
//   String get errorMessage =>
//       "Plik o tym rozszerzeniu nie jest wspierany. $text";
// }
// class EmptyFileFailure extends Failure {
//   const EmptyFileFailure(super.text);

//   @override
//   String get errorMessage => "Plik nie zawiera żadnych informacji. $text";
// }
