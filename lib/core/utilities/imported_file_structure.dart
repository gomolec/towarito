import 'package:equatable/equatable.dart';

class ImportedFileStructure extends Equatable {
  final int nameColumn;
  final int codeColumn;
  final int targetQuantityColumn;
  final int? quantityColumn;
  final int? noteColumn;

  const ImportedFileStructure({
    required this.nameColumn,
    required this.codeColumn,
    required this.targetQuantityColumn,
    this.quantityColumn,
    this.noteColumn,
  });

  ImportedFileStructure copyWith({
    int? nameColumn,
    int? codeColumn,
    int? targetQuantityColumn,
    int? quantityColumn,
    int? noteColumn,
  }) {
    return ImportedFileStructure(
      nameColumn: nameColumn ?? this.nameColumn,
      codeColumn: codeColumn ?? this.codeColumn,
      targetQuantityColumn: targetQuantityColumn ?? this.targetQuantityColumn,
      quantityColumn: quantityColumn ?? this.quantityColumn,
      noteColumn: noteColumn ?? this.noteColumn,
    );
  }

  @override
  String toString() {
    return 'ImportedFileStructure(nameColumn: $nameColumn, codeColumn: $codeColumn, targetQuantityColumn: $targetQuantityColumn, quantityColumn: $quantityColumn, noteColumn: $noteColumn)';
  }

  @override
  List<Object?> get props {
    return [
      nameColumn,
      codeColumn,
      targetQuantityColumn,
      quantityColumn,
      noteColumn,
    ];
  }
}
