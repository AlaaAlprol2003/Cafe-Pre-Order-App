import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatelessWidget {
 const CustomDropdown({
    super.key,
    required this.count,
  });
final int count;
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PaymentCubit>(context);
    return Container(
      width: 60.w,
      height: 50.h,
      alignment: Alignment.center,
      margin: REdgeInsets.only(right: 12),
      padding: REdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: ColorsManager.creamyWhite,
          borderRadius: BorderRadius.circular(12.r)),
       child: Text("$count",style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: ColorsManager.darkChocolate),)
       ///DropdownButtonHideUnderline(
      //   child: DropdownButton<String>(

      //       ///isExpanded: true,
      //       padding: REdgeInsets.symmetric(horizontal: 0),
      //       value: cubit.currentItem,
      //       borderRadius: BorderRadius.circular(16.r),
      //       dropdownColor: ColorsManager.eggshell,
      //       focusColor: ColorsManager.darkChocolate,
      //       elevation: 5,
      //       iconEnabledColor: ColorsManager.darkChocolate,
      //       items: cubit.items
      //           .map((item) => DropdownMenuItem(
      //                 value: item,
      //                 child: Center(
      //                   child: Text(
      //                     textAlign: TextAlign.center,
      //                     item,
      //                     style: Theme.of(context)
      //                         .textTheme
      //                         .titleSmall!
      //                         .copyWith(color: ColorsManager.darkChocolate),
      //                   ),
      //                 ),
      //               ))
      //           .toList(),
      //       onChanged: (i) {
      //         cubit.changeCurrentItem(selectedItem: i!);
      //       }),
      // ),
    );
  }
}
