import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: ColorsManager.white,)),
      ),
      bottomNavigationBar: Padding(
        padding:  REdgeInsets.symmetric(horizontal: 16.0,vertical: 16),
        child: CustomElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.payment);
          },
          text: "Checkout",
          icon: Icon(
            Icons.shopping_cart_checkout_rounded,
            color: ColorsManager.white,
          ),
        ),
      ),
    );
  }
}
