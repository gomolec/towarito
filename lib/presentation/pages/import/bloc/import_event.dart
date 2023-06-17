part of 'import_bloc.dart';

abstract class ImportEvent extends Equatable {
  const ImportEvent();

  @override
  List<Object?> get props => [];
}

class ImportMethodSelected extends ImportEvent {
  final ImportType importType;

  const ImportMethodSelected({
    required this.importType,
  });

  @override
  List<Object> get props => [importType];
}

class ImportFileSelectStarted extends ImportEvent {
  const ImportFileSelectStarted();
}

class ImportFileUploadEnded extends ImportEvent {
  const ImportFileUploadEnded();
}

class ImportFieldsMappingEnded extends ImportEvent {
  final int nameColumnIndex;
  final int codeColumnIndex;
  final int targetQuantityColumnIndex;
  final int? quantityColumnIndex;
  final int? noteColumnIndex;

  const ImportFieldsMappingEnded({
    required this.nameColumnIndex,
    required this.codeColumnIndex,
    required this.targetQuantityColumnIndex,
    this.quantityColumnIndex,
    this.noteColumnIndex,
  });

  @override
  List<Object?> get props {
    return [
      nameColumnIndex,
      codeColumnIndex,
      targetQuantityColumnIndex,
      quantityColumnIndex,
      noteColumnIndex,
    ];
  }
}
