import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key, required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: REdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: ColorsManager.darkChocolate,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          icon,
          size: 22.sp,
          color:ColorsManager.white,
        ),
      ),
    );
  }
}
