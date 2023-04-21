import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const warning = Color(0xFFFFBE00);
const success = Color(0xFF238723);


CustomColors lightCustomColors = const CustomColors(
  sourceWarning: Color(0xFFFFBE00),
  warning: Color(0xFF7A5900),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDEA1),
  onWarningContainer: Color(0xFF261900),
  sourceSuccess: Color(0xFF238723),
  success: Color(0xFF006E0E),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF95FA86),
  onSuccessContainer: Color(0xFF002201),
);

CustomColors darkCustomColors = const CustomColors(
  sourceWarning: Color(0xFFFFBE00),
  warning: Color(0xFFFCBC00),
  onWarning: Color(0xFF402D00),
  warningContainer: Color(0xFF5C4300),
  onWarningContainer: Color(0xFFFFDEA1),
  sourceSuccess: Color(0xFF238723),
  success: Color(0xFF7ADC6D),
  onSuccess: Color(0xFF003A04),
  successContainer: Color(0xFF005308),
  onSuccessContainer: Color(0xFF95FA86),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
  });

  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;

  @override
  CustomColors copyWith({
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
  }) {
    return CustomColors(
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///   * [CustomColors.sourceWarning]
  ///   * [CustomColors.warning]
  ///   * [CustomColors.onWarning]
  ///   * [CustomColors.warningContainer]
  ///   * [CustomColors.onWarningContainer]
  ///   * [CustomColors.sourceSuccess]
  ///   * [CustomColors.success]
  ///   * [CustomColors.onSuccess]
  ///   * [CustomColors.successContainer]
  ///   * [CustomColors.onSuccessContainer]
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
      sourceWarning: sourceWarning!.harmonizeWith(dynamic.primary),
      warning: warning!.harmonizeWith(dynamic.primary),
      onWarning: onWarning!.harmonizeWith(dynamic.primary),
      warningContainer: warningContainer!.harmonizeWith(dynamic.primary),
      onWarningContainer: onWarningContainer!.harmonizeWith(dynamic.primary),
      sourceSuccess: sourceSuccess!.harmonizeWith(dynamic.primary),
      success: success!.harmonizeWith(dynamic.primary),
      onSuccess: onSuccess!.harmonizeWith(dynamic.primary),
      successContainer: successContainer!.harmonizeWith(dynamic.primary),
      onSuccessContainer: onSuccessContainer!.harmonizeWith(dynamic.primary),
    );
  }
}