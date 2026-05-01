import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/features/cart/presentation/widgets/cart_item.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Scaffold(
      backgroundColor: ColorsManager.warmBeige, // 👈 نفس الستايل
      body: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is GetOrdersFailure) {
            UiUtils.showMessage(context: context, message: state.message);
          }
          if (state is DeleteOrderToFirestoreLoading) {}
          if (state is DeleteOrderToFirestoreFailure) {
            UiUtils.showMessage(context: context, message: state.message);
          }
          if (state is DeleteOrderToFirestoreSuccess) {
            UiUtils.showMessage(context: context, message: "Order Removed");
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              /// 🔹 Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: _circleIcon(Icons.arrow_back)),
                    Column(
                      children: [
                        Text("Your Cart",
                            style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.darkChocolate)),
                      ],
                    ),
                    _circleIcon(Icons.delete_outline),
                  ],
                ),
              ),

              /// 🔹 Free delivery bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.creamyWhite,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("You're EGP 80 away from free delivery!",
                          style: TextStyle(fontSize: 12.sp)),
                      SizedBox(height: 8.h),
                      LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.grey.shade300,
                        color: ColorsManager.darkChocolate,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              /// 🔹 Items
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                builder: (context, state) {
                  if (state is GetOrdersLoading) {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.darkChocolate,
                        ),
                      ),
                    );
                  }

                  if (state is GetOrdersFailure) {
                    UiUtils.showLoading(context: context);
                  }

                  if (state is GetOrdersSuccess) {
                    final orders = cubit.orders;

                    if (state is GetOrdersLoading && cubit.orders.isEmpty) {
                      return const Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                                color: ColorsManager.darkChocolate)),
                      );
                    }

                    if (cubit.orders.isNotEmpty) {
                      return Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: cubit.orders.length,
                          separatorBuilder: (_, __) => SizedBox(height: 15.h),
                          itemBuilder: (context, index) =>
                              CartItem(order: cubit.orders[index]),
                        ),
                      );
                    }
                  }

                  return Expanded(
                      child: Center(child: Text("Your Cart is Empty")));
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 110.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: ColorsManager.darkChocolate,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Price
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Total", style: TextStyle(color: Colors.white70)),
                Text("EGP 170",
                    style: TextStyle(
                        color: ColorsManager.darkHoney,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold)),
              ],
            ),

            /// Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.darkOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
              ),
              onPressed: () {},
              child: Text("Place Order",
                  style: TextStyle(fontSize: 16.sp, color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        shape: BoxShape.circle,
      ),
      child: Icon(icon),
    );
  }

  Widget _priceRow(String title, String price, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: isTotal ? 16.sp : 14.sp,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(price,
              style: TextStyle(
                  color: isTotal ? ColorsManager.darkOrange : Colors.black)),
        ],
      ),
    );
  }
}
