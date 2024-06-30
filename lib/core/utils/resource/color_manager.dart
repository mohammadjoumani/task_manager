import 'package:flutter/material.dart';

class ColorManager {
  static const Color colorPrimaryLight = Color(0xff3669C9);
  static const Color colorPrimaryDark = Color(0xff3669C9);

  static const Color colorPrimaryLight1 = Color(0x443669c9);

  static const Color colorSecondaryLight = Color(0xCC3669C9);
  static const Color colorSecondaryDark = Color(0xCC3669C9);

  static const Color colorBackgroundLight = Color(0xffFFFFFF);
  static const Color colorBackgroundDark = Color(0xff0C0C0C);

  static const Color colorTextFieldLight = Color(0xFFFAFAFA);
  static const Color colorTextFieldDark = Color(0xFFFAFAFA);

  static const Color colorPlaceHolderLight = Color(0xFFC4C5C4);
  static const Color colorPlaceHolderDark = Color(0xFFC4C5C4);

  static const Color colorFontPrimaryLight = Color(0xFF0C1A30);
  static const Color colorFontPrimaryDark = Color(0xFF0C1A30);

  static const Color colorFontSecondaryLight = Color(0xFF838589);
  static const Color colorFontSecondaryDark = Color(0xFF838589);

  static const Color colorCardLight = Color(0xFFE7E7E7);
  static const Color colorCardDark = Color(0xFF0E141C);

  static const Color colorGrey1 = Color(0xFFC4C5C4);
  static const Color colorGrey2 = Color(0xff797979);
  static const Color colorError = Color(0xffe61f34);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack = Color(0xff0C0C0C);

  static const Color colorGreen = Color(0xff00ff3c);

  static const genericBoxShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 10,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static const MaterialColor primarySwatch = MaterialColor(
    0xFFffffff,
    <int, Color>{
      50: Color(0xFFffffff),
      100: Color(0xFFffffff),
      200: Color(0xFFffffff),
      300: Color(0xFFffffff),
      400: Color(0xFFffffff),
      500: Color(0xFFffffff),
      600: Color(0xFFffffff),
      700: Color(0xFFffffff),
      800: Color(0xFFffffff),
      900: Color(0xFFffffff),
    },
  );
}
