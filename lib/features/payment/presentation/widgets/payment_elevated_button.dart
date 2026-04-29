import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentElevatedButton extends StatelessWidget {
  const PaymentElevatedButton({super.key, required this.onPress});
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 148, 94, 12),
            elevation: 5,
            shadowColor: ColorsManager.creamyWhite.withValues(alpha: .5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.r))),
        child: Padding(
          padding:  REdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.shopping_cart_checkout_rounded,
                color: const Color.fromARGB(255, 255, 226, 190),
                size: 25.h,
              ),
              Text(
                "Place Order",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(color: ColorsManager.white,fontSize: 20.sp),
              ),
              Icon(
                  Icons.arrow_forward_rounded,
                  color: const Color.fromARGB(255, 255, 226, 190),
          
                  size: 25.h,
                ),
            ],
          ),
        ));
  }
}
