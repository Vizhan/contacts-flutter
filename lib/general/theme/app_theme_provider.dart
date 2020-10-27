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
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: app_font_family,
      cursorColor: Colors.indigo,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cupertinoOverrideTheme: CupertinoThemeData(
        primaryColor: Colors.indigo,
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ///////////////////////////////////////////////
      /////////////////Font Style////////////////////
      ///////////////////////////////////////////////
      textTheme: TextTheme(
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
        fillColor: Colors.grey[100],
        filled: true,
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
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.white,
      ),
      ///////////////////////////////////////////////
      /////////////////Button style//////////////////
      ///////////////////////////////////////////////
      buttonTheme: ButtonThemeData(
        height: 64,
        buttonColor: Colors.indigo,
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme.light().copyWith(
          primary: Colors.grey[700]
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.indigo,
      )
    );
  }
}
