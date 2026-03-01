import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.imagePath});
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: REdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: ColorsManager.charcoalBlue,width: 1),
        borderRadius: BorderRadius.circular(22.r)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        
        child: Image.asset(
          imagePath,
          width: double.infinity,
          
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
