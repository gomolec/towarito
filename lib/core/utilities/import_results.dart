import 'package:equatable/equatable.dart';

class ImportResults extends Equatable {
  final int successedProductsNumber;
  final int failedProductsNumber;
  final String errorText;

  const ImportResults({
    required this.successedProductsNumber,
    required this.failedProductsNumber,
    required this.errorText,
  });

  ImportResults copyWith({
    int? successedProductsNumber,
    int? failedProductsNumber,
    String? errorText,
  }) {
    return ImportResults(
      successedProductsNumber:
          successedProductsNumber ?? this.successedProductsNumber,
      failedProductsNumber: failedProductsNumber ?? this.failedProductsNumber,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  String toString() =>
      'ImportResults(successedProductsNumber: $successedProductsNumber, failedProductsNumber: $failedProductsNumber, errorText: $errorText)';

  @override
  List<Object> get props =>
      [successedProductsNumber, failedProductsNumber, errorText];
}
