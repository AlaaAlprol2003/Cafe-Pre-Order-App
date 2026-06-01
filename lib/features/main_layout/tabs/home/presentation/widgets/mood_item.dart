import 'dart:math';

import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildMoodItem(BuildContext context, String emoji, String label) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);

      List<Products> moodList = [];

      if (label == "Surprise") {
        var randomProduct =
            Data.allProducts[Random().nextInt(Data.allProducts.length)];
        moodList = [randomProduct];
      } else {
        moodList = Data.allProducts.where((product) {
          String searchKey = label.toLowerCase();
          String productDesc = product.description.toLowerCase();
          String productName = product.name.toLowerCase();

          if (label == "Sleepy") {
            return productDesc.contains("coffee") ||
                productDesc.contains("caffeine") ||
                productDesc.contains("espresso");
          } else if (label == "Sweet") {
            return productDesc.contains("caramel") ||
                productDesc.contains("vanilla") ||
                productDesc.contains("sugar");
          } else if (label == "Chill") {
            return productDesc.contains("tea") || productDesc.contains("latte");
          }

          return productDesc.contains(searchKey) ||
              productName.contains(searchKey);
        }).toList();
      }

      Navigator.pushNamed(
        context,
        AppRoutes.productScreen,
        arguments: moodList,
      );
    },
    child: Column(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: const Color.fromRGBO(255, 241, 190, 1),
          child: Text(emoji, style: TextStyle(fontSize: 25.sp)),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 14.sp,
            color: ColorsManager.creamyWhite,
          ),
        ),
      ],
    ),
  );
}
