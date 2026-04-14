import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.icon
  });
  final VoidCallback onPressed;
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 63.h,
      child: ElevatedButton.icon(
        onPressed:onPressed,
        icon:icon ,
        iconAlignment: IconAlignment.end,
        label: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: fontSize,fontWeight: fontWeight),
        ),
      ),
    );
  }
}
