import 'package:flutter/material.dart';
import 'colors.dart';

class AppFonts {
  AppFonts._();

  ///region family
  static const openSans = 'OpenSans';

  ///region weight
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
}

class AppFontStyle {
  AppFontStyle._();

  static const italic = FontStyle.italic;
}

class AppTextStyles {
  AppTextStyles._();

  static const _fontSize18 = 18.0;
  static const _fontSize20 = 20.0;

  static const size18RegularOpenSansBlack = TextStyle(
    fontSize: AppTextStyles._fontSize18,
    fontWeight: AppFonts.regular,
    color: AppColors.black,
    fontFamily: AppFonts.openSans,
  );

  static const TextStyle alertDialogTitle = TextStyle(
      color: AppColors.greyscale900,
      fontWeight: FontWeight.w500,
      fontSize: 14.0);

  static const TextStyle alertDialogItem = TextStyle(
      color: AppColors.greyscale600,
      fontWeight: FontWeight.w500,
      fontSize: 12.0);
}