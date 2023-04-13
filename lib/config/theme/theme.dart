import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'app_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
      textTheme: GoogleFonts.firaSansTextTheme(),
      scaffoldBackgroundColor: AppColors.lightBlue,
      primaryColor: AppColors.lightBlue,
      appBarTheme: const AppBarTheme(color: AppColors.lightBlue));
}
