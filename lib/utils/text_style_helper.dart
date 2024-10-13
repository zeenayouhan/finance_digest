import 'package:flutter/material.dart';

import '../constants/theme/app_colors.dart';
import '../constants/theme/app_fonts.dart';

TextStyle reusableTextStyle({
  required BuildContext context,
  Color? color,
  double fontSize = 14,
  String? fontFamily,
  FontWeight fontWeight = FontWeight.w400,
}) {
  final appColors = Theme.of(context).extension<AppColors>();
  final appFonts = Theme.of(context).extension<AppFonts>();
  return TextStyle(
    color: color ?? appColors?.black3,
    fontSize: fontSize,
    fontFamily: fontFamily ?? appFonts?.mainFont,
    fontWeight: fontWeight,
  );
}
