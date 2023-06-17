part of 'import_bloc.dart';

enum FileUploadStatus { initial, loading, success, error }

abstract class ImportState extends Equatable {
  final double progress;
  const ImportState({
    this.progress = 0,
  });

  @override
  List<Object?> get props => [progress];
}

class ImportInitial extends ImportState {}

class ImportFileUploading extends ImportState {
  final ImportType importType;
  final List<InstructionFormattedText> instructionsText;
  final FileUploadStatus fileUploadStatus;
  final String selectedFileName;

  const ImportFileUploading({
    required this.importType,
    required this.instructionsText,
    this.fileUploadStatus = FileUploadStatus.initial,
    this.selectedFileName = '',
    super.progress,
  });

  @override
  List<Object?> get props => [
        importType,
        instructionsText,
        fileUploadStatus,
        selectedFileName,
        progress
      ];

  ImportFileUploading copyWith({
    ImportType? importType,
    List<InstructionFormattedText>? instructionsText,
    FileUploadStatus? fileUploadStatus,
    String? selectedFileName,
    double? progress,
  }) {
    return ImportFileUploading(
      importType: importType ?? this.importType,
      instructionsText: instructionsText ?? this.instructionsText,
      fileUploadStatus: fileUploadStatus ?? this.fileUploadStatus,
      selectedFileName: selectedFileName ?? this.selectedFileName,
      progress: progress ?? this.progress,
    );
  }
}

class ImportFieldsMapping extends ImportState {
  final List<String> fileHeaders;

  const ImportFieldsMapping({
    required this.fileHeaders,
    super.progress,
  });

  ImportFieldsMapping copyWith({
    List<String>? fileHeaders,
  }) {
    return ImportFieldsMapping(
      fileHeaders: fileHeaders ?? this.fileHeaders,
    );
  }

  @override
  String toString() => 'ImportFieldsMapping(fileHeaders: $fileHeaders)';

  @override
  List<Object> get props => [fileHeaders, progress];
}

class ImportSummary extends ImportState with EquatableMixin {
  final int successedProductsNumber;
  final int failedProductsNumber;
  final String errorText;

  const ImportSummary({
    this.successedProductsNumber = 0,
    this.failedProductsNumber = 0,
    this.errorText = '',
    super.progress = 1,
  });

  ImportSummary copyWith({
    int? successedProductsNumber,
    int? failedProductsNumber,
    String? errorText,
  }) {
    return ImportSummary(
      successedProductsNumber:
          successedProductsNumber ?? this.successedProductsNumber,
      failedProductsNumber: failedProductsNumber ?? this.failedProductsNumber,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  String toString() =>
      'ImportSummary(successedProductsNumber: $successedProductsNumber, failedProductsNumber: $failedProductsNumber, errorText: $errorText)';

  @override
  List<Object> get props =>
      [successedProductsNumber, failedProductsNumber, errorText];
}

class ImportLoading extends ImportState with EquatableMixin {
  final String infoText;

  const ImportLoading({
    this.infoText = '',
  });

  @override
  List<Object> get props => [infoText];
}
