import 'package:flutter/material.dart';

ThemeData appTheme() {
  const purple = Color(0xFFF72670);
  return ThemeData(
      primaryColor: purple,
      shadowColor: Colors.grey,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.grey));
}
