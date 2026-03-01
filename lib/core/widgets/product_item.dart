import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.w,
      decoration: BoxDecoration(
        color: ColorsManager.burntOrange,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                child: Image.asset(ImageAssets.coffee),
              ),
              Positioned(
                right: 2,
                top: 5,
                child: CircleAvatar(
                  backgroundColor: ColorsManager.burntOrange,
                  radius: 15,
                  child: Icon(
                    Icons.favorite_outline,
                    color: ColorsManager.white,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hot Coffee",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Text(
                      "4.8",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(width: 12.w),
                    Icon(Icons.star, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5.h,),
    
                Text(
                  "EGP 50",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                        backgroundColor: ColorsManager.darkNavyBlue,
                        
                        radius: 20,
                        child: Icon(
                          Icons.add,
                          color: ColorsManager.burntOrange,
                          size: 25,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
