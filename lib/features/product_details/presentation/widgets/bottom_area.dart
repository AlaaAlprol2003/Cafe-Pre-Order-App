import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/diamond_button.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomArea extends StatefulWidget {
  const BottomArea({super.key, required this.product, required this.messageController});
  final Products product;
  final TextEditingController messageController;
  @override
  State<BottomArea> createState() => _BottomAreaState();
}

class _BottomAreaState extends State<BottomArea> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Positioned(
      bottom: 20.h,
      left: 95.w,
      right: 15.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          cubit.decreaseQuantity();
                        }),
                    SizedBox(width: 12.w),
                    Text("${cubit.quantity}",
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.darkHoney)),
                    SizedBox(width: 12.w),
                    QuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          cubit.increaseQuantity();
                        }),
                  ],
                ),
                SizedBox(
                  width: 35.w,
                ),
                Expanded(
                    child: Text(
                  "Add to cart",
                  style: GoogleFonts.roboto(
                      fontSize: 20.sp,
                      color: ColorsManager.darkChocolate,
                      fontWeight: FontWeight.bold),
                )),
                GestureDetector(
                    onTap: () {
                      double unitPrice = widget.product.price;
                      String? message = widget.messageController.text.trim();
                      if (cubit.milk == "Regular (+10)") {
                        unitPrice += 10;
                      } else if (cubit.milk == "Almond (+20)") {
                        unitPrice += 20;
                      } else if (cubit.milk == "Soy (+30)") {
                        unitPrice += 30;
                      }

                      double totalPrice = unitPrice * cubit.quantity;

                      cubit.addOrderToFirestore(
                          order: OrderModel(
                              orderId: "",
                              product: widget.product,
                              size: cubit.size,
                              sugarLevel: cubit.sugar,
                              milkType: cubit.milk,
                              quantity: cubit.quantity,
                              uId: "",
                              totalPrice: totalPrice,
                              orderDate: DateTime.now(),
                              cupMessage: message.isEmpty ? null : message,
                              ));
                    },
                    child: DiamondButton()),
              ],
            );
          },
        ),
      ),
    );
  }
}
