import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DiamondButton extends StatelessWidget {
  const DiamondButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 0.785,
          child: Container(
            height: 45.w,
            width: 45.w,
            decoration: BoxDecoration(
              color:ColorsManager.deepBurntBrown,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.sp),
      ],
    );
  }
}
