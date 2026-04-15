import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key, required this.product});

  final Products product;

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150.h,
          width: double.infinity,
          decoration: BoxDecoration(
           
            color: const Color.fromARGB(255, 57, 35, 7),
            borderRadius: BorderRadius.only(topRight: Radius.circular(16.r)),
          ),
        ),
        Positioned(
          bottom: -16.h,
          left: -10.w,
          child: Container(
            height: 185.h,
            width: 160.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color.fromARGB(255, 132, 97, 55),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.product.image, fit: BoxFit.contain),
            ),
          ),
        ),
        Positioned(
          left: 160.w,
          top: 20.h,
          child: Column(
            children: [
              Text(
                widget.product.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorsManager.creamyWhite),
              ),
              SizedBox(height: 10.h),
              Text(
                "Pre Time: ${widget.product.pretime}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorsManager.creamyWhite,
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                "EGP ${widget.product.price}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorsManager.creamyWhite),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 40.w,
          child: Row(
            children: [
              Text(
                "${widget.product.rate}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: ColorsManager.creamyWhite, fontSize: 15.sp),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.h,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -10.h,
          right: -10.w,
          child: Container(
            height: 30.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 132, 97, 55),
                borderRadius: BorderRadius.circular(8.r)),
            child: Icon(
              Icons.add_outlined,
              color: ColorsManager.creamyWhite,
              size: 25.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
