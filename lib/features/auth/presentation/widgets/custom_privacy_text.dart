import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrivacyText extends StatelessWidget {
  const CustomPrivacyText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style:  GoogleFonts.roboto(
          color: Colors.grey,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500
        ),
        children: [
          const TextSpan(text: 'By clicking Register, you agree to our '),
          TextSpan(
            text: 'Privacy & Terms',
            style:  TextStyle(
              fontSize: 20.sp,
              color: ColorsManager.burntOrange,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, AppRoutes.privacy);
              },
          ),
        ],
      ),
    );
  }
}