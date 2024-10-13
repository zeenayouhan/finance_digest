import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors(
      {required this.black1,
      required this.black2,
      required this.black3,
      required this.black4,
      required this.redErrors,
      required this.white,
      required this.grey,
      required this.darkGrey,
      required this.primary});

  final Color redErrors;
  final Color black1;
  final Color black2;
  final Color black3;
  final Color black4;
  final Color white;
  final Color grey;
  final Color darkGrey;
  final Color primary;

  @override
  AppColors copyWith(
      {Color? white,
      Color? redErrors,
      Color? black1,
      Color? black2,
      Color? black3,
      Color? black4,
      Color? grey,
      Color? darkGrey,
      Color? primary}) {
    return AppColors(
        white: white ?? this.white,
        black1: black1 ?? this.black1,
        black2: black2 ?? this.black2,
        black3: black3 ?? this.black3,
        black4: black4 ?? this.black4,
        redErrors: redErrors ?? this.redErrors,
        grey: grey ?? this.grey,
        darkGrey: darkGrey ?? this.darkGrey,
        primary: primary ?? this.primary);
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
        white: Color.lerp(white, other.white, t) ?? white,
        black1: Color.lerp(black1, other.black1, t) ?? black1,
        black2: Color.lerp(black2, other.black2, t) ?? black2,
        black3: Color.lerp(black3, other.black3, t) ?? black3,
        black4: Color.lerp(black4, other.black4, t) ?? black4,
        redErrors: Color.lerp(redErrors, other.redErrors, t) ?? redErrors,
        grey: Color.lerp(grey, other.grey, t) ?? grey,
        darkGrey: Color.lerp(darkGrey, other.darkGrey, t) ?? darkGrey,
        primary: Color.lerp(primary, other.primary, t) ?? primary);
  }
}
