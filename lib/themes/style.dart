import 'package:flutter/material.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
      primaryColor: Colors.grey,
      shadowColor: Colors.grey,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.grey,
            displayColor: Colors.grey,
          ),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.grey));
}
