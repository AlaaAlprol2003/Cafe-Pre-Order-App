import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomCostWidget extends StatelessWidget {
  const CustomCostWidget({super.key, required this.label, required this.cost,this.color = ColorsManager.darkOrange,this.fontWeight = FontWeight.w500,this.fontSize = 17,  this.fontSizeNumber = 16});
  final String label;
  final String cost;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
   final double fontSizeNumber;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label,style: Theme.of(context).textTheme.labelMedium!.copyWith(color: color,fontWeight: fontWeight,fontSize: fontSize),),
        Spacer(),
        Text(cost,style: Theme.of(context).textTheme.labelMedium!.copyWith(color: ColorsManager.darkBrown,fontSize: fontSizeNumber),),

      ],
    );
  }
}