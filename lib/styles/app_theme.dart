import 'package:flutter/material.dart';

class AppTheme {
  final Color scaffoldBackgroundColor = Colors.white.withOpacity(.9);
  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: _outlineInputBorder(),
    focusedErrorBorder: _outlineInputBorder(),
    focusedBorder: _outlineInputBorder(borderWidth: 4),
    disabledBorder: _outlineInputBorder(),
    errorBorder: _outlineInputBorder(),
    enabledBorder: _outlineInputBorder(),
  );
  final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      primary: Colors.white,
      textStyle: TextStyle(
        color: Colors.white.withOpacity(.9),
        fontSize: 16,
      ),
    ),
  );

  final TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w800,
    ),
    headline2: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  );

  ThemeData theme() {
    return ThemeData.dark().copyWith(
      textButtonTheme: textButtonThemeData,
      textTheme: textTheme,
    );
  }
}

OutlineInputBorder _outlineInputBorder({
  double circularBorder = 12,
  double gapPadding = 4,
  double borderWidth = 2,
  BorderRadius? borderRadius,
  BorderSide? borderSide,
  Color? borderColor,
}) {
  borderColor = borderColor ?? Colors.blue;
  borderRadius = borderRadius ?? BorderRadius.circular(circularBorder);
  borderSide = borderSide ?? BorderSide(color: borderColor, width: borderWidth);
  return OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: borderSide,
      gapPadding: gapPadding);
}
