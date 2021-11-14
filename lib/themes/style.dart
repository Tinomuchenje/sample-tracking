import 'package:flutter/material.dart';

ThemeData appTheme() {
  const purple = Color(0xFFF72670);
  return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: purple,
      shadowColor: Colors.grey,
      scaffoldBackgroundColor: const Color(0xffF5F6FB),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.grey));
}
