import 'package:flutter/material.dart';


class ThemeService {
  final lightTheme = ThemeData(
    useMaterial3: true,
       colorScheme: ColorScheme.light(
        background: Colors.grey.shade300,
        primary: Colors.black,
        secondary: Colors.grey.shade300,
        surfaceTint: Colors.grey[200]),
  );

  final darkTheme = ThemeData(
    
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        primary: Colors.grey.shade300,
        secondary: Colors.black,
        surfaceTint: Colors.grey[200]),
  );

 
}
