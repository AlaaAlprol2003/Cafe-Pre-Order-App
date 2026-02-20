import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.preIcon,
    this.postIcon,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator, this.isSecured = false,
  });
  final String labelText;
  final Widget? preIcon;
  final Widget? postIcon;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isSecured;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.roboto(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      cursorColor: ColorsManager.burntOrange,
      keyboardType: keyboardType,
      obscureText: isSecured,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        errorStyle: GoogleFonts.roboto(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.red,
        ),
        prefixIcon: preIcon,
        suffixIcon: postIcon,
      ),
    );
  }
}
