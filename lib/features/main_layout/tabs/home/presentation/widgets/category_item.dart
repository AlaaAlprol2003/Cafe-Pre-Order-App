import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100.r),
          child: CircleAvatar(
            radius: 50,
            child: Image.asset(
              ImageAssets.coffee,
              fit: BoxFit.cover,
              height: 200.h,
            ),
          ),
    
          //Image.asset(ImageAssets.coffee,height: 100.h,),
        ),
        SizedBox(height: 8.h,),
        Text("Coffee", style: Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
