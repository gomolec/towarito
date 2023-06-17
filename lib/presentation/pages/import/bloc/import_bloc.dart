import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:towarito/core/error/failures.dart';
import 'package:towarito/core/extensions/either_extension.dart';
import 'package:towarito/core/utilities/imported_file_structure.dart';
import 'package:towarito/domain/adapters/products_adapter.dart';

import '../../../../core/utilities/instruction_formatted_text.dart';

part 'import_event.dart';
part 'import_state.dart';

enum ImportType { csv, html, json }

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final ProductsAdapter _productsAdapter;
  ImportBloc({required ProductsAdapter productsAdapter})
      : _productsAdapter = productsAdapter,
        super(ImportInitial()) {
    on<ImportMethodSelected>(_onMethodSelected);
    on<ImportFileSelectStarted>(_onFileSelectStarted);
    on<ImportFileUploadEnded>(_onFileUploadEnded);
    on<ImportFieldsMappingEnded>(_onFieldsMappingEnded);
  }

  int maxImportProgress = 0;
  int progress = 0;

  File? selectedFile;

  void _onMethodSelected(
    ImportMethodSelected event,
    Emitter<ImportState> emit,
  ) {
    progress = 0;
    switch (event.importType) {
      case ImportType.csv:
        maxImportProgress = 3;
        emit(
          ImportFileUploading(
            importType: event.importType,
            instructionsText: const [
              InstructionFormattedText(
                text:
                    "Tutaj możesz przekazać plik .csv do zaimportowania. Możesz go użyskać poprzez eksport arkusza kalkulacyjnego. ",
              ),
              InstructionFormattedText(
                text:
                    "Należy zwrócić uwagę na to, że pierwszy wiersz powinien zawierać nazwy kolumn.",
                isHighlighted: true,
              ),
            ],
          ),
        );
        break;
      case ImportType.html:
        maxImportProgress = 3;
        emit(
          ImportFileUploading(
            importType: event.importType,
            instructionsText: const [
              InstructionFormattedText(
                text:
                    "Tutaj możesz przekazać plik .txt do zaimportowania lub wkleić jego zawartość. Powinna w nim być zawarta skopiowanna tabela ze strony internetowej. ",
              ),
              InstructionFormattedText(
                text:
                    "Należy zwrócić uwagę na poprawne zaznaczenie tabeli, skopiowanie innych elementów strony może spowodować błąd.",
                isHighlighted: true,
              ),
            ],
          ),
        );
        break;
      default:
    }
  }

  Future<void> _onFileSelectStarted(
    ImportFileSelectStarted event,
    Emitter<ImportState> emit,
  ) async {
    if (state is! ImportFileUploading) {
      //exit importing - critical error
      log("bład krytyczny");
      return;
    }
    emit((state as ImportFileUploading).copyWith(
      fileUploadStatus: FileUploadStatus.loading,
    ));
    List<String> allowedExtensions = [];
    if ((state as ImportFileUploading).importType == ImportType.csv) {
      allowedExtensions.add("csv");
    } else if ((state as ImportFileUploading).importType == ImportType.html) {
      allowedExtensions.add("txt");
    }
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
      );
      log(result.toString());
      if (result == null) {
        emit((state as ImportFileUploading).copyWith(
          fileUploadStatus: FileUploadStatus.initial,
        ));
        return;
      }
      if (result.files.isEmpty) {
        throw const ImportFileFailure("Nie wybrano pliku.");
      }
      selectedFile = File(result.files.single.path!);
      emit((state as ImportFileUploading).copyWith(
        selectedFileName: selectedFile!.path.split(Platform.pathSeparator).last,
        fileUploadStatus: FileUploadStatus.success,
        progress: ++progress / maxImportProgress,
      ));
    } catch (e) {
      emit((state as ImportFileUploading).copyWith(
        fileUploadStatus: FileUploadStatus.error,
      ));
    }
  }

  Future<void> _onFileUploadEnded(
    ImportFileUploadEnded event,
    Emitter<ImportState> emit,
  ) async {
    if (state is! ImportFileUploading) {
      return;
    }
    emit(const ImportLoading());

    if (selectedFile == null) {
      return;
    }
    final result = await _productsAdapter.importFile(file: selectedFile!);
    if (result.isLeft()) {
      emit(ImportSummary(errorText: result.asLeft().errorMessage));
      return;
    }
    emit(ImportFieldsMapping(
      fileHeaders: result.asRight(),
      progress: ++progress / maxImportProgress,
    ));
  }

  Future<void> _onFieldsMappingEnded(
    ImportFieldsMappingEnded event,
    Emitter<ImportState> emit,
  ) async {
    if (state is! ImportFieldsMapping) {
      return;
    }
    emit(const ImportLoading(infoText: "Trwa importowanie produktów"));
    final result = await _productsAdapter.importProducts(
      structure: ImportedFileStructure(
        nameColumn: event.nameColumnIndex,
        codeColumn: event.codeColumnIndex,
        targetQuantityColumn: event.targetQuantityColumnIndex,
        quantityColumn: event.quantityColumnIndex,
        noteColumn: event.noteColumnIndex,
      ),
    );
    if (result.isLeft()) {
      emit(ImportSummary(errorText: result.asLeft().errorMessage));
      return;
    }
    emit(ImportSummary(
      successedProductsNumber: result.asRight().successedProductsNumber,
      failedProductsNumber: result.asRight().failedProductsNumber,
      errorText: result.asRight().errorText,
    ));
  }
}
