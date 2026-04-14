import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor:  ColorsManager.warmBeige,
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: ColorsManager.creamyWhite,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.goldenBrown,width: 2.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.goldenBrown,width: 2.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.darkOrange,width: 2.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.lightRed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: ColorsManager.lightRed),
      ),
      prefixIconColor: ColorsManager.darkChocolate,
      
      suffixIconColor:  ColorsManager.darkChocolate53,
      hintStyle: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color:  ColorsManager.mediumBrown.withValues(alpha: .5),
      ),
    ),
    
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor:  ColorsManager.darkChocolate,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 5,
        padding: REdgeInsets.symmetric(vertical: 14),
      ),
    ),
    appBarTheme: AppBarThemeData(
      titleTextStyle: GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.burntOrange,
      ),
      centerTitle: true,
      backgroundColor: ColorsManager.darkChocolate,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.roboto(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color:  ColorsManager.darkChocolate,
        fontStyle: FontStyle.italic,

        decoration: TextDecoration.underline,
        decorationColor:  ColorsManager.darkChocolate,
        decorationThickness: 1,
      ),
      displayMedium: GoogleFonts.roboto(
        fontSize:18.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.russet,
      ),
      headlineMedium: GoogleFonts.roboto(
        fontSize: 22.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.eggshell,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.charcoalBlue,
      ),
      titleSmall: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.darkBrown,
      ),
      headlineLarge: GoogleFonts.roboto(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ColorsManager.burntOrange,
      ),
      bodyMedium:  GoogleFonts.roboto(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.darkChocolate,
      ),
    ),
  );
  static ThemeData lightTheme = ThemeData();
}
