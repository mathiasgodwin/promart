import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: Colors.purple),
  primaryColor: Colors.purple,
  inputDecorationTheme: const InputDecorationTheme(
    focusColor: Colors.purple,
    border: UnderlineInputBorder(),
    // enabledBorder:
    //     UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
    floatingLabelStyle: TextStyle(color: Colors.purple),
    // prefixIconColor: Colors.purple,
  ),
  textTheme: GoogleFonts.openSansTextTheme(),
  scaffoldBackgroundColor: Colors.white,
);
