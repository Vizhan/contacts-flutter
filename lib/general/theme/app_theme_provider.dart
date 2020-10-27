import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppThemeProvider {
  static const String app_font_family = "Rubik";

  static const Color light_grey = Color(0xFFECF0F3);
  static const Color dark_red = Color(0xFFE75668);

  static ThemeData get() {
    TextStyle basicTextStyle = TextStyle(
      fontSize: 16,
      fontFamily: app_font_family,
      fontWeight: FontWeight.w400,
      color: Colors.grey[700],
    );

    return ThemeData(
      accentColor: dark_red,
      primaryColor: Colors.indigo,
      backgroundColor: light_grey,
      scaffoldBackgroundColor: light_grey,
      fontFamily: app_font_family,
      cursorColor: Colors.indigo,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.indigo,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ///////////////////////////////////////////////
      /////////////////Font Style////////////////////
      ///////////////////////////////////////////////
      textTheme: TextTheme(
        headline6: basicTextStyle.copyWith(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: basicTextStyle.copyWith(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: basicTextStyle,
      ),
      ///////////////////////////////////////////////
      ///////////////Input decoration////////////////
      ///////////////////////////////////////////////
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(16.0),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.indigo,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
        ),
      ),
    );
  }
}
