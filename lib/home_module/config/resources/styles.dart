import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

const emptyView = SizedBox(width: 0, height: 0);

/// height and width space

TextStyle textNormal(Color? color, double? fontSize) {
  return GoogleFonts.roboto(
    color: color ?? Colors.white,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: fontSize ?? 14,
  );
}

TextStyle tokenDetailAmount({
  Color color = Colors.white,
  double fontSize = 24,
  FontWeight weight = FontWeight.w400,
}) {
  return GoogleFonts.roboto(
    color: color,
    fontWeight: weight,
    fontStyle: FontStyle.normal,
    fontSize: fontSize,
  );
}

TextStyle textDetailHDSD({
  Color color = Colors.white,
  double fontSize = 24,
  FontWeight weight = FontWeight.w400,
  double textHeight = 1.9,
}) {
  return GoogleFonts.roboto(
    color: color,
    fontWeight: weight,
    fontStyle: FontStyle.normal,
    fontSize: fontSize,
  ).copyWith(height: textHeight);
}

TextStyle titleText({Color color = Colors.white, double fontSize = 20}) {
  return GoogleFonts.roboto(
    color: color,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: fontSize,
  );
}

TextStyle textNormalCustom({
  Color? color,
  double? fontSize,
  FontWeight? fontWeight,
}) {
  return GoogleFonts.roboto(
    color: color ?? Colors.white,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: fontSize ?? 14,
  );
}

TextStyle titleAppbar({Color color = titleColor, double fontSize = 18}) {
  return GoogleFonts.roboto(
    color: color,
    fontWeight: FontWeight.w500,
    fontSize: fontSize,
    fontStyle: FontStyle.normal,
  );
}

TextStyle textItalic({
  Color color = titleColor,
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
  FontStyle style = FontStyle.italic,
}) {
  return GoogleFonts.roboto(
    color: color,
    fontWeight: fontWeight,
    fontSize: fontSize,
    fontStyle: style,
  );
}
