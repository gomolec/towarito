import 'package:equatable/equatable.dart';

class InstructionFormattedText extends Equatable {
  final String text;
  final bool isHighlighted;

  const InstructionFormattedText({
    required this.text,
    this.isHighlighted = false,
  });

  InstructionFormattedText copyWith({
    String? text,
    bool? isHighlighted,
  }) {
    return InstructionFormattedText(
      text: text ?? this.text,
      isHighlighted: isHighlighted ?? this.isHighlighted,
    );
  }

  @override
  String toString() =>
      'InstructionFormattedText(text: $text, isHighlighted: $isHighlighted)';

  @override
  List<Object> get props => [text, isHighlighted];
}
