import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/payment/presentation/models/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPaymentMethod extends StatelessWidget {
  const CustomPaymentMethod(
      {super.key, required this.paymentMethod, required this.isSelected});
  final PaymentMethod paymentMethod;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      margin: REdgeInsets.symmetric(vertical: 8),
      padding: REdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorsManager.eggshell
            : ColorsManager.creamyWhite.withValues(alpha: .5),
        border: BoxBorder.all(
            color: isSelected
                ? const Color.fromARGB(76, 94, 53, 2)
                : ColorsManager.darkChocolate.withValues(alpha: .5),
            width: isSelected ? 1.5 : .5),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: ColorsManager.darkChocolate.withValues(alpha: 0.17),
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: Offset(0, 6),
                )
              ]
            : [],
      ),
      child: Row(
        children: [
          Image.asset(
            paymentMethod.imagePath,
            height: 40.h,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            paymentMethod.title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 18.sp,),
          ),
          Spacer(),
          Checkbox(
            value: isSelected,
            onChanged: (value) {},
            shape: CircleBorder(),
            side: BorderSide(
              color: isSelected
                  ? ColorsManager.darkBrown
                  : ColorsManager.darkChocolate.withValues(alpha: .5),
              width: 2,
            ),
            checkColor: ColorsManager.creamyWhite,
            fillColor: WidgetStatePropertyAll(isSelected
                ? ColorsManager.darkChocolate
                : ColorsManager.creamyWhite.withValues(alpha: .5)),
          ),
        ],
      ),
    );
  }
}
