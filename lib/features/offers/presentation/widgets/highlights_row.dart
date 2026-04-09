import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HighlightsRow extends StatelessWidget {
  const HighlightsRow({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: ColorsManager.darkOrange,
          size: 27,
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: ColorsManager.goldenBrown,fontSize:14.sp,fontWeight: FontWeight.bold))
      ],
    );
  }
}
