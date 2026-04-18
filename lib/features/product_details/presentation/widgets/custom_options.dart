import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomOptions extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedValue;
  final Function(String) onChanged;

  const CustomOptions({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: ColorsManager.darkOrange)),
        SizedBox(height: 10.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: options.map((option) {
            bool isSelected = selectedValue == option;

            return ChoiceChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (_) => onChanged(option),
              backgroundColor: ColorsManager.creamyWhite,
              selectedColor: ColorsManager.darkHoney,
              labelStyle: GoogleFonts.roboto(
                  color: isSelected
                      ? ColorsManager.creamyWhite
                      : ColorsManager.darkChocolate,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              checkmarkColor: ColorsManager.creamyWhite,
            );
          }).toList(),
        ),
      ],
    );
  }
}
