import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.imagePath,
    required this.categoryName,
  });
  final String imagePath;
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      
      child: Column(
        
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 50,
              child: Image.asset(imagePath, fit: BoxFit.fill,width: double.infinity,height: 200.h,),
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(child: Text(categoryName,textAlign: TextAlign.center,maxLines: 2, style: Theme.of(context).textTheme.titleSmall)),
        ],
      ),
    );
  }
}
