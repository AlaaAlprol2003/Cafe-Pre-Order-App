import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProductDetailsCubit>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          /// Image
          Container(
            width: 70.w,
            height: 70.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: DecorationImage(
                image: AssetImage(order.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 10.w),

          /// Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.product.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
                SizedBox(height: 5.h),
                Text(
                  order.product.description,
                  style: TextStyle(fontSize: 12.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20.h),
                Wrap(
                  spacing: 4.w,
                  runSpacing: 10.h,
                  
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.warmBeige,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        order.size,
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: ColorsManager.darkChocolate),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.warmBeige,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        "${order.sugarLevel} Sugar",
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: ColorsManager.darkChocolate),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if (order.milkType != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ColorsManager.warmBeige,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          order.milkType!,
                          style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              color: ColorsManager.darkChocolate),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 16.w),

          /// Quantity + Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  cubit.deleteOrderFromFirestore(orderId: order.orderId);
                },
                child: Container(
                  padding: REdgeInsets.all(10.w),
                  margin: REdgeInsets.only(bottom: 20.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.warmBeige,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ),
              Image.asset("assets/images/flower.png",height: 50.h,),
              SizedBox(height: 20.h),
              Text("${order.quantity} item/s",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorsManager.darkOrange,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20.h),
              Text("${order.product.price} EGP",
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: ColorsManager.darkOrange,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}

Widget _qtyButton(IconData icon, {VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40.h,
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: ColorsManager.darkChocolate,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 14),
    ),
  );
}
