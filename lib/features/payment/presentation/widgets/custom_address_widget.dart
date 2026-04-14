// ignore_for_file: sized_box_for_whitespace

import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAddressWidget extends StatelessWidget {
  const CustomAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PaymentCubit>(context);
    return Column(
      children: [
        InkWell(
          onTap: () {
            cubit.toggle(selectedIndex: 1);
            cubit.calculateDistance();
            cubit.openExternalMap();
          },
          child: Container(
            width: double.infinity,

            ///height: 90.h,
            margin: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
            padding: REdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: cubit.currentIndex == 1
                  ? ColorsManager.white
                  : ColorsManager.creamyWhite,
              border: cubit.currentIndex == 1
                  ? Border.all(color: ColorsManager.darkChocolate, width: 1.5)
                  : null,
              borderRadius:
                  BorderRadius.circular(cubit.currentIndex == 1 ? 16.r : 0.r),
              boxShadow: cubit.currentIndex == 1
                  ? [
                      BoxShadow(
                        color:
                            ColorsManager.darkChocolate.withValues(alpha: 0.17),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: Offset(0, 6),
                      )
                    ]
                  : [],
            ),
            child: Row(
              children: [
                Icon(
                  Icons.storefront_rounded,
                  color: cubit.currentIndex == 1
                      ? ColorsManager.darkHoney
                      : ColorsManager.darkHoney.withValues(alpha: 0.3),
                  size: 35.h,
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Pick Up at: ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 20.sp,
                                  color: cubit.currentIndex == 1
                                      ? ColorsManager.darkChocolate
                                      : ColorsManager.darkChocolate53),
                        ),
                        Text(
                          "Spectra Cafe",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        if (state is LocationLoadingState)
                          return Text("Calculating distance...");
                        return Text(
                          cubit.distanceInKm != null
                              ? "${cubit.distanceInKm!.toStringAsFixed(1)} KM away from you"
                              : "Tap to see distance",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: cubit.currentIndex == 1
                                  ? ColorsManager.umber
                                  : ColorsManager.darkChocolate
                                      .withValues(alpha: .35)),
                        );
                      },
                    ),
                    Text(
                      "Tanta, Gharbia",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 16.sp,
                          color: cubit.currentIndex == 1
                              ? ColorsManager.umber
                              : ColorsManager.darkChocolate
                                  .withValues(alpha: .35)),
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: cubit.currentIndex == 1
                      ? ColorsManager.umber
                      : ColorsManager.darkChocolate.withValues(alpha: .35),
                  size: 30.r,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: 50.h,
            child: TextFormField(
              enabled: cubit.currentIndex == 0,
              style: Theme.of(context).textTheme.titleSmall,
              cursorColor: ColorsManager.darkChocolate,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: cubit.currentIndex == 0
                      ? ColorsManager.white
                      : ColorsManager.creamyWhite,
                  hint: Text(
                    "Enter delivery address",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color:
                            ColorsManager.darkChocolate.withValues(alpha: .6)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(color: ColorsManager.darkChocolate),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(
                      color: ColorsManager.darkChocolate,
                      width: 1.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide: BorderSide(
                      color: ColorsManager.warmBeige.withValues(alpha: .5),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.location_on_rounded,
                    color: cubit.currentIndex == 0
                        ? ColorsManager.darkHoney
                        : ColorsManager.darkHoney.withValues(alpha: 0.3),
                    size: 35.h,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
