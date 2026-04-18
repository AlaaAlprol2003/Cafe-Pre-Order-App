import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.product});
  final Products product;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorsManager.deepBrown,
      width: 85.w,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Container(
            height: 45.h,
            alignment: Alignment.center,
            margin: REdgeInsets.only(top: 30.h),
            decoration: BoxDecoration(
                color: ColorsManager.creamyWhite, shape: BoxShape.circle),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new,
                  color: ColorsManager.darkChocolate, size: 25.sp),
            ),
          ),
          SizedBox(height: 60.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorsManager.creamyWhite,
              shape: BoxShape.circle,
            ),
            child: product.category.icon,
          ),
          SizedBox(height: 25.h),
          _sideIcon(
            product.isOrganic == true
                ? Icons.eco_rounded
                : Icons.local_fire_department_outlined,
            color: product.isOrganic == true
                ? Colors.green
                : ColorsManager.darkOrange,
          ),
          SizedBox(height: 25.h),
          _sideIcon(Icons.favorite_outline_rounded, color: Colors.redAccent),
          SizedBox(height: 80.h),
          Text(product.rate.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold)),
          Icon(Icons.star, color: Colors.amber, size: 20.sp),
          SizedBox(
            height: 90.h,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text("${product.price} EGP",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          RotatedBox(
            quarterTurns: 3,
            child: Container(
              height: 160.h,
              width: 130.w,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              child: Image.asset(
                ImageAssets.logo,
                // width: 70.w,
                // height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _sideIcon(IconData icon, {Color color = Colors.white}) {
  return Container(
    padding: EdgeInsets.all(10.w),
    decoration:
        BoxDecoration(color: ColorsManager.creamyWhite, shape: BoxShape.circle),
    child: Icon(icon, color: color, size: 30.sp),
  );
}
