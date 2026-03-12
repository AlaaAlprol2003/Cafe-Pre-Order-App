import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 63.h,
      child: ElevatedButton(
        onPressed:onPressed,

        child: Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
