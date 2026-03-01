import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 254, 251, 210),
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: ColorsManager.charcoalBlue,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.blueGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.blueGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.burntOrange),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.lightRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.lightRed),
      ),
      prefixIconColor: ColorsManager.burntOrange,
      suffixIconColor: ColorsManager.lightBlueGrey,
      labelStyle: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.lightBlueGrey.withValues(alpha: .9),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.burntOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 5,
        padding: REdgeInsets.symmetric(vertical: 18),
      ),
    ),
    appBarTheme: AppBarThemeData(
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.burntOrange,
      ),
      centerTitle: true,
      backgroundColor: ColorsManager.darkNavyBlue,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.burntOrange,
        fontStyle: FontStyle.italic,

        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.burntOrange,
        decorationThickness: 1,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.charcoalBlue,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkBrown,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData();
}
