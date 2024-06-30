import 'package:flutter/material.dart';

import 'color_manager.dart';
import 'font_manager.dart';

abstract class StyleManager {
  static TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, color) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static TextStyle getRegularStyle({double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.regular, color);
  }

  static TextStyle getMediumStyle({double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.medium, color);
  }

  static TextStyle getLightStyle({double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.light, color);
  }

  static TextStyle getBoldStyle({double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.bold, color);
  }

  static TextStyle getSemiBoldStyle({double fontSize = FontSize.s14, required Color color}) {
    return _getTextStyle(fontSize, FontWeightManager.semiBold, color);
  }

  // Outline Input Border
  static OutlineInputBorder outlineInputBorderGray = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: const BorderSide(color: ColorManager.colorGrey1, width: 1),
  );

  static ShapeDecoration cardDecoration = ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    shadows: const [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 10,
        offset: Offset(0, 2),
        spreadRadius: 0,
      )
    ],
  );
}
