import 'package:flutter/material.dart';

@immutable
class AppFonts extends ThemeExtension<AppFonts> {
  const AppFonts(
      {required this.mainFont, required this.subFont, required this.otherFont});

  final String mainFont;
  final String subFont;
  final String otherFont;

  @override
  AppFonts copyWith({String? mainFont, String? subFont, String? otherFont}) {
    return AppFonts(
        mainFont: mainFont ?? this.mainFont,
        subFont: subFont ?? this.subFont,
        otherFont: otherFont ?? this.otherFont);
  }

  @override
  AppFonts lerp(ThemeExtension<AppFonts>? other, double t) {
    if (other is! AppFonts) {
      return this;
    }
    return AppFonts(
        mainFont: other.mainFont,
        subFont: other.subFont,
        otherFont: other.otherFont);
  }
}
