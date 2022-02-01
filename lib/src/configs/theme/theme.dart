import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// final theme1 = ThemeData(
//   buttonTheme: const ButtonThemeData(
//     buttonColor: Colors.purple,
//     textTheme: ButtonTextTheme.primary,
//   ),
//   elevatedButtonTheme: const ElevatedButtonThemeData(),
//   primarySwatch: Colors.purple,
//   textTheme: GoogleFonts.openSansTextTheme(),
//   // primaryColorDark: Colors.blueAccent,
//   // primaryColorLight: const Color(0xFFB2EBF2),
//   primaryColor: Colors.purple,
//   // colorScheme: const ColorScheme.light(secondary: Color(0xFF009688)),
//   scaffoldBackgroundColor: const Color(0xFFF5EDF1),
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//     ),
//   ),
// );

final theme = ThemeData(
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
  scaffoldBackgroundColor: const Color(0xFFF5EDF1),
);
