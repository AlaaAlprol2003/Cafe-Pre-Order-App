import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextAnimations {
  static Widget colorizeAnimatedText({
    required String text,
    required BuildContext context,
  }) {
    return AnimatedTextKit(
      isRepeatingAnimation: true,
      repeatForever: true,

      animatedTexts: [
        ColorizeAnimatedText(
          text,
          speed: Duration(milliseconds:800),

          textStyle: Theme.of(
            context,
          ).textTheme.displayMedium!.copyWith(fontSize: 16.sp),
          colors: [
            ColorsManager.white,
            ColorsManager.burntOrange,
            Colors.yellow,
            ColorsManager.darkBrown,
          ],
        ),
      ],
    );
  }

  static Widget scaleAnimatedText({
    required String text,
    required BuildContext context,
  }) {
    return DefaultTextStyle(
      
      style: Theme.of(context).textTheme.displayMedium!,
      child: AnimatedTextKit(
        
        repeatForever: false,
        isRepeatingAnimation: false,
        totalRepeatCount: 1,
        displayFullTextOnTap: true,
        animatedTexts: [ScaleAnimatedText(text)],
        onTap: () {},
      ),
    );
  }
}
