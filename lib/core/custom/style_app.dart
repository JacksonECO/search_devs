import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search_devs/core/custom/color_app.dart';

class StylesApp {
  StylesApp._();
  static final StylesApp _instance = StylesApp._();
  static StylesApp get i => _instance;

  //? Google Fonts Basic
  TextStyle get title => GoogleFonts.inter(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        color: ColorApp.i.eerieBlack,
      );
  TextStyle get body => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: ColorApp.i.independence,
      );
  TextStyle get captions => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: ColorApp.i.independence,
      );

  TextStyle get inputFloating => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: ColorApp.i.eerieBlack,
      );
  TextStyle get inputText => GoogleFonts.roboto(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: ColorApp.i.eerieBlack,
      );
}

extension StylesAppExtension on BuildContext {
  StylesApp get styles => StylesApp.i;
}

/*
  ? Helper
  FontWeight.w100: 'Thin',
  FontWeight.w200: 'ExtraLight',
  FontWeight.w300: 'Light',
  FontWeight.w400: 'Regular',
  FontWeight.w500: 'Medium',
  FontWeight.w600: 'SemiBold',
  FontWeight.w700: 'Bold',
  FontWeight.w800: 'ExtraBold',
  FontWeight.w900: 'Black',
*/
