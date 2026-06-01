import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/mood_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void showMoodSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorsManager.deepBurntBrown,
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 67, 38, 3),
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40.w, height: 4.h, color: Colors.grey[300]),
            SizedBox(height: 20.h),
            Text(
              "How are you feeling today?",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.creamyWhite,
              ),
            ),
            SizedBox(height: 20.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildMoodItem(context, "😴", "Sleepy"),
                buildMoodItem(context, "😌", "Chill"),
                buildMoodItem(context, "⚡", "Active"),
                buildMoodItem(context, "😋", "Sweet"),
                buildMoodItem(context, "🎁", "Surprise"),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      );
    },
  );
}
