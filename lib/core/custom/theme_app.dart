import 'package:flutter/material.dart';
import 'package:search_devs/core/custom/color_app.dart';
import 'package:search_devs/core/custom/style_app.dart';

class ThemeApp {
  ThemeApp._();

  static final InputBorder _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
      color: ColorApp.i.sonicSilver,
      width: 1,
    ),
  );

  static final defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.blue,
    backgroundColor: Colors.white,
    secondaryHeaderColor: const Color(0xFF4A5568),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelStyle: StylesApp.i.inputFloating,
      hintStyle: StylesApp.i.inputText,
      labelStyle: StylesApp.i.inputText,
      errorStyle: StylesApp.i.inputText.copyWith(color: Colors.red),
      iconColor: ColorApp.i.quartz,
      border: _border,
      focusedBorder: _border,
      enabledBorder: _border,
      errorBorder: _border,
      focusedErrorBorder: _border,
      disabledBorder: _border,
    ),
  );
}
