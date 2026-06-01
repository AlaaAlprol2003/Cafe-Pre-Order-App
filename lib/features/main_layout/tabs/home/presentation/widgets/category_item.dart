import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.categoryName,
    required this.icon
  });
  final String imagePath;
  final String categoryName;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: 
            
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45.r,
              child: Container(
                width: 100.w,
                height: 100.h,
                alignment: Alignment.center,
                padding: REdgeInsets.symmetric(vertical: 16,horizontal: 16),
                decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    const Color.fromARGB(255, 254, 243, 203),
                      const Color.fromARGB(44, 183, 115, 19),

                  ]),
                  // border: Border.all(
                  //   color: Color.fromARGB(79, 241, 187, 111),
                  //   width: 3,
                  // ),
                  borderRadius: BorderRadius.circular(50.r)
                ),
                 child: icon
                // Image.asset(
                //   imagePath,
                //   fit: BoxFit.fill,
                //   width: double.infinity,
                //   height: 150.h,
                // ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Text(
              categoryName,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 14.sp,fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
