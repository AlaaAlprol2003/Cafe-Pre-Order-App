import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key,required this.price });
  final double price;
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
          height: 90.h,
          decoration: BoxDecoration(
            color: ColorsManager.darkOrange,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: ColorsManager.creamyWhite),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    "EGP $price",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: ColorsManager.creamyWhite),
                  ),
                ],
              ),
              Spacer(),
              SizedBox(
                  width: 250.w,
                  child: CustomElevatedButton(
                    onPressed: () {},
                    text: "Add Bundle To Cart",
                    icon: Icon(
                      Icons.shopping_cart_rounded,
                      size: 25,
                      color: ColorsManager.creamyWhite,
                    ),
                  ))
            ],
          ),
        );
  }
}