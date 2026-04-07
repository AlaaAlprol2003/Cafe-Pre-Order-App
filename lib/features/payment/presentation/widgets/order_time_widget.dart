import 'dart:async';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderTimerWidget extends StatelessWidget {
  final int durationInMinutes;

  const OrderTimerWidget({super.key, this.durationInMinutes = 10});

  @override
  Widget build(BuildContext context) {
    int totalSeconds = durationInMinutes * 60;

    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 1), (i) => totalSeconds - i - 1)
          .take(totalSeconds),
      builder: (context, snapshot) {
        int remainingSeconds = snapshot.data ?? totalSeconds;

        if (remainingSeconds <= 0) {
          return Text(
            "Your Coffee is Ready! ☕",
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18.sp),
          );
        }

        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;

        return Column(
          children: [
            SizedBox(height: 12.h,),
            Text(
              "Preparing your cup...",
              style: TextStyle(fontSize: 16.sp, color: ColorsManager.darkChocolate),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer_outlined, color: Colors.orange, size: 24.sp),
                SizedBox(width: 8.w),
                Text(
                  "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}