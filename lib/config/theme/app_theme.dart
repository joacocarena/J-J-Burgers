import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    // colorSchemeSeed: Colors.orange.shade300,
    colorSchemeSeed: const Color.fromRGBO(181, 120, 63, 100),
    brightness: Brightness.light
  );
}