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
            color: ColorsManager.charcoalBlue,
            borderRadius: BorderRadius.only(topRight: Radius.circular(16.r)),
          ),
        ),
        Positioned(
          bottom: -50.h,
          left: -10.w,

          child: Container(
            height: 250.h,
            width: 150.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.product.image, fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 150.w,
          top: 20.h,
          child: Column(
            children: [
              Text(
                widget.product.name,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 10.h),
              Text(
                "Pre Time: ${widget.product.pretime}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: ColorsManager.burntOrange,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "EGP ${widget.product.price}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        Positioned(
          bottom: 5.h,
          right: 60.w,
          child: Row(
            children: [
              Text(
                "${widget.product.rate}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: ColorsManager.burntOrange,
                ),
              ),
              SizedBox(width: 5.w),
              Icon(Icons.star, color: Colors.amber),
            ],
          ),
        ),
        Positioned(
          bottom: -10.h,
          right: -10.w,
          child: CircleAvatar(
            backgroundColor: ColorsManager.burntOrange,

            radius: 20,
            child: Icon(Icons.add, color: ColorsManager.darkNavyBlue, size: 20),
          ),
        ),
      ],
    );
  }
}
