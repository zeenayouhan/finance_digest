import 'package:finance_digest/constants/theme/app_colors.dart';
import 'package:finance_digest/constants/theme/app_fonts.dart';
import 'package:flutter/material.dart';

ThemeData getThemeDefault() {
  return ThemeData.light().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const AppColors(
          redErrors: Color(0xffCC1000),
          black1: Color.fromRGBO(5, 2, 27, 1),
          black2: Color.fromRGBO(23, 23, 23, 1),
          black3: Color.fromRGBO(0, 0, 0, 1),
          black4: Color.fromRGBO(30, 31, 32, 1),
          white: Color(0xffFFFFFF),
          grey: Color.fromRGBO(163, 163, 163, 1),
          darkGrey: Color.fromRGBO(115, 115, 115, 1),
          primary: Color.fromRGBO(82, 58, 228, 1)),
      const AppFonts(mainFont: 'Roboto', subFont: 'Rubik', otherFont: 'Raleway')
    ],
  );
}
