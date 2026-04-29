// ignore_for_file: deprecated_member_use

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimatedToggle extends StatelessWidget {
  const CustomAnimatedToggle({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PaymentCubit>(context);
    return AnimatedToggleSwitch<int>.size(
      height: 50.h,
      textDirection: TextDirection.rtl,
      current: cubit.currentIndex,
      values: const [0, 1],
      iconOpacity: 0.5,
      indicatorSize: Size.fromWidth(200.w),
      borderWidth: 4.0,
      iconAnimationType: AnimationType.onHover,
      style: ToggleStyle(
        borderColor: Colors.transparent,
        indicatorColor: ColorsManager.eggshell,
        backgroundColor: ColorsManager.warmBeige,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1.5),
          ),
        ],
      ),
      onChanged: (index) {
        cubit.toggle(selectedIndex: index);
      },
      cursors: ToggleCursors(defaultCursor: MouseCursor.defer),
      iconList: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.moped_rounded,
              color: cubit.currentIndex == 0
                  ? ColorsManager.darkChocolate
                  : ColorsManager.umber,
              size: 20.sp,
            ),
            SizedBox(width: 5.w,),

            Text(
              "Delivery",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: cubit.currentIndex == 0
                      ? ColorsManager.darkChocolate
                      : ColorsManager.umber,
                  fontSize: 14.sp,
                  fontWeight: cubit.currentIndex == 0
                      ? FontWeight.bold
                      : FontWeight.w500),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.storefront_rounded,
              color: cubit.currentIndex == 1
                  ? ColorsManager.darkChocolate
                  : ColorsManager.umber,
              size: 18,
            ),
            SizedBox(width: 5.w,),
            Text(
              "Pick Up",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: cubit.currentIndex == 1
                      ? ColorsManager.darkChocolate
                      : ColorsManager.umber,
                  fontSize: 14.sp,
                  fontWeight: cubit.currentIndex == 1
                      ? FontWeight.bold
                      : FontWeight.w500),
            )
          ],
        ),
      ],
      selectedIconOpacity: 1.0,
    );
  }
}
