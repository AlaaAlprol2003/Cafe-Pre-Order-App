import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderedProductCart extends StatelessWidget {
  const OrderedProductCart({
    super.key, required this.product,
  });

  final Products product;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          
          decoration: BoxDecoration(
              color: ColorsManager.warmBeige,
              borderRadius: BorderRadius.circular(10.r)),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset(product.image))),
                  Container(
                    alignment: Alignment.center,
                    width: 30.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.darkOrange,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r))
                    ),
                    child: Text("2x",style: GoogleFonts.roboto(fontSize: 14.sp,fontWeight: FontWeight.w400,color: ColorsManager.white),),
                  )
            ],
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                product.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h,),
              Text(
                "Grande / Regular Milk",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 14.sp),
              )
            ],
          ),
        ),
        
        Text(
          "EGP ${product.price}",
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: ColorsManager.darkChocolate,fontSize: 16.sp),
        )
      ],
    );
  }
}
