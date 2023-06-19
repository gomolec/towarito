import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';

import '../../data/models/models.dart';
import '../error/exceptions.dart';
import '../utilities/imported_file_structure.dart';

class ImportService {
  List<List<String>>? _cachedData;

  List<List<String>>? get cachedData => _cachedData;

  //return only headers of file to structurize data
  Future<List<String>> importFile({File? file, String? text}) async {
    if (file == null && text == null) {
      throw FileExtensionNotSupportedException();
    }

    late final String importedData;
    late final String fileExtension;
    if (file != null) {
      importedData = await file.readAsString();
      fileExtension = getFileExtension(file.path);
    }
    if (text != null) {
      importedData = text;
      fileExtension = 'txt';
    }

    late final List<List<String>> data;
    switch (fileExtension) {
      case 'csv':
        data = _importCsvData(importedData);
        break;
      case 'txt':
        data = _importTextData(importedData);
        break;
      default:
        throw FileExtensionNotSupportedException();
    }

    if (data.isEmpty || data.first.isEmpty) {
      throw EmptyFileException();
    }

    _cachedData = data;

    return data.first;
  }

  List<String> getFileHeaders({
    required List<List<String>> data,
    required String filePath,
  }) {
    final fileExtension = getFileExtension(filePath);

    switch (fileExtension) {
      case 'csv':
        return data.first;
      default:
        throw FileExtensionNotSupportedException();
    }
  }

  Product convertDataToProduct({
    required ImportedFileStructure structure,
    required List<String> data,
  }) {
    return Product(
      name: data[structure.nameColumn],
      code: data[structure.codeColumn].replaceAll(' ', ''),
      targetQuantity:
          int.parse(data[structure.targetQuantityColumn].split(' ').first),
      quantity: structure.quantityColumn != null
          ? int.parse(data[structure.quantityColumn!].split(' ').first)
          : 0,
      note: structure.noteColumn != null ? data[structure.noteColumn!] : '',
    );
  }

  List<List<String>> _importCsvData(String data) {
    List<List<String>> csvData = const CsvToListConverter().convert(
      data,
      shouldParseNumbers: false,
      allowInvalid: false,
    );
    return csvData;
  }

  List<List<String>> _importTextData(String data) {
    final rows = data.split('\n');
    if (rows.isEmpty) {
      return [];
    }
    final headers = rows.removeAt(0).split('\t');
    final rawData =
        rows.map((row) => row.split('\t')).toList().flattened.toList();
    List<List<String>> finalData = [headers];
    int index = 0;
    for (var i = 0; i < (rawData.length / headers.length).floor(); i++) {
      List<String> row = [];
      for (var i = 0; i < headers.length; i++) {
        row.add(rawData[index++]);
      }
      finalData.add(row);
    }
    return finalData;
  }

  String getFileExtension(String filePath) {
    return filePath.split(Platform.pathSeparator).last.split('.').last;
  }

  void clearCache() {
    _cachedData = null;
  }
}
