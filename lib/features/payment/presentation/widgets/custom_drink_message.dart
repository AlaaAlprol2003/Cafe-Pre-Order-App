import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrinkMessage extends StatelessWidget {
  const CustomDrinkMessage({super.key,this.messageController});
  final TextEditingController? messageController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Add a Message on Your Drink",style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 20.sp,color: ColorsManager.darkOrange),),
        SizedBox(height: 10.h,),
        Stack(
          clipBehavior: Clip.none,
          children: [
            TextField(
              controller: messageController,
              style: Theme.of(context).textTheme.titleSmall,
              cursorColor: ColorsManager.darkChocolate,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Any message or movie quote? (optional)",
                hintStyle: GoogleFonts.roboto(fontSize: 12.sp,fontWeight: FontWeight.w600,color: ColorsManager.darkChocolate.withValues(alpha: .5)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: ColorsManager.darkChocolate.withValues(alpha: .4))
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: ColorsManager.darkChocolate)
                )
              ),
            ),
            Positioned(
              right: -50.w,
              top: -4.h,
              child: Image.asset(ImageAssets.gotThis,height: 200.h,))
          ],
        ),
      ],
    );
  }
}