// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:dash_cup/features/payment/presentation/models/payment_method.dart';
import 'package:dash_cup/features/payment/presentation/payment_success_screen.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_address_widget.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_animated_toggle.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_cost_widget.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_drink_message.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_dropdown.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_payment_method.dart';
import 'package:dash_cup/features/payment/presentation/widgets/ordered_product_cart.dart';
import 'package:dash_cup/features/payment/presentation/widgets/payment_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.orders});
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PaymentCubit>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorsManager.warmBeige,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,

              ///pinned: true,
              expandedHeight: 70.h,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorsManager.darkChocolate,
                ),
              ),
              title: Text(
                "Checkout",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              actions: [
                BlocBuilder<PaymentCubit, PaymentState>(
                  builder: (context, state) {
                    return CustomDropdown();
                  },
                )
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                ///height: 800.h,
                width: double.infinity,
                margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: ColorsManager.creamyWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.darkChocolate.withValues(alpha: 0.1),
                      blurRadius: 40,
                      spreadRadius: 8,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                      child: CarouselSlider(
                          items: orders
                              .map((order) => OrderedProductCart(
                                    product: order.product,
                                    order: order,
                                  ))
                              .toList(),
                          options: CarouselOptions(
                              height: 100.h,
                              enlargeFactor: 1,
                              viewportFraction: 1,
                              autoPlay: true)),
                    ),
                    BlocBuilder<PaymentCubit, PaymentState>(
                        builder: (context, state) {
                      return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 12.0),
                            child: CustomAnimatedToggle(),
                          ));
                    }),
                    SizedBox(
                      height: 12.h,
                    ),
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        return CustomAddressWidget();
                      },
                    ),
                    Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                      child: Divider(
                        color:
                            ColorsManager.darkChocolate.withValues(alpha: .6),
                        thickness: .7,
                      ),
                    ),
                    Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment",
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Column(
                            children: [
                              ...List.generate(
                                PaymentMethod.paymentMethods.length,
                                (item) => GestureDetector(
                                  onTap: () {
                                    cubit.changePaymentMethod(
                                        selectedMethod: item);
                                  },
                                  child:
                                      BlocBuilder<PaymentCubit, PaymentState>(
                                    builder: (context, state) {
                                      return CustomPaymentMethod(
                                        paymentMethod:
                                            PaymentMethod.paymentMethods[item],
                                        isSelected:
                                            cubit.currentPaymentMethod == item,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
                      child: CustomDrinkMessage(),
                    ),
                    Padding(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                      child: Divider(
                        color:
                            ColorsManager.darkChocolate.withValues(alpha: .6),
                        thickness: .7,
                      ),
                    ),
                    Padding(
                        padding: REdgeInsets.symmetric(horizontal: 12.0),
                        child: BlocBuilder<PaymentCubit, PaymentState>(
                            builder: (context, state) {
                          double subtotal = orders.fold(
                              0, (sum, item) => sum + item.totalPrice);

                          double vat = subtotal * 0.14;
                          double deliveryFees =
                              cubit.currentIndex == 1 ? 0.0 : 15.0;

                          double total = subtotal + vat + deliveryFees;

                          return Column(
                            children: [
                              CustomCostWidget(
                                label: "Subtotal",
                                cost: "${subtotal.toStringAsFixed(2)} EGP",
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ColorsManager.darkHoney,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomCostWidget(
                                label: "VAT(14%)",
                                cost: "${vat.toStringAsFixed(2)} EGP",
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ColorsManager.darkHoney,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              CustomCostWidget(
                                label: "Delivery Fees",
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: ColorsManager.darkHoney,
                                colorNumber: ColorsManager.darkOrange,
                                cost:
                                    cubit.currentIndex == 1 ? "Free" : "15 EGP",
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Divider(
                                color: ColorsManager.darkChocolate
                                    .withValues(alpha: .6),
                                thickness: .7,
                              ),
                              CustomCostWidget(
                                label: "Total",
                                cost: "${total.toStringAsFixed(2)} EGP",
                                color: ColorsManager.darkBrown,
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                fontSizeNumber: 18.sp,
                              )
                            ],
                          );
                        })),
                    Padding(
                      padding: REdgeInsets.only(
                          left: 12.0, right: 12, bottom: 24, top: 70),
                      child: SizedBox(
                          height: 55.h,
                          child: PaymentElevatedButton(onPress: () async {
                            double currentSubtotal = orders.fold(
                                0, (sum, item) => sum + item.totalPrice);

                            // 2. حساب المصاريف الإضافية بناءً على نوع الاستلام
                            double deliveryFees =
                                cubit.currentIndex == 1 ? 0.0 : 15;
                            double vat = currentSubtotal * 0.14;
                            double total = currentSubtotal + vat + deliveryFees;

                            // 3. التحقق من طريقة الدفع
                            if (cubit.currentPaymentMethod == 0) {
                              // دفع بالبطاقة
                              Navigator.pushNamed(context, AppRoutes.creditCard,
                                  arguments: cubit);
                            } else if (cubit.currentPaymentMethod == 3) {
                              // دفع بالنقط - نستخدم الـ total الجديد للتحقق
                              if (cubit.hasEnoughPoints(total)) {
                                UiUtils.showLoading(context: context);

                                // تنفيذ عملية الخصم وتحديث النقط في Firestore
                                await cubit.deductPoints(total);

                                if (context.mounted) {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.paymentSuccess,
                                    arguments: {
                                      'cubit': cubit,
                                      'paymentMethod': 'Points',
                                      'amount': total,
                                    },
                                  );
                                }
                              } else {
                                UiUtils.showMessage(
                                    context: context,
                                    message: "Insufficient points balance!");
                              }
                            } else {
                              // طرق دفع أخرى (Fawry / Vodafone Cash)
                              String methodName =
                                  cubit.currentPaymentMethod == 1
                                      ? "Fawry"
                                      : "Vodafone";
                              UiUtils.showLoading(context: context);

                              // تحديث نقط المستخدم بعد الدفع بنجاح (كاش أو فوري)
                              await cubit.updateUserPoints(totalAmount: total);

                              await Future.delayed(const Duration(seconds: 2));
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentSuccessScreen(
                                      paymentMethod: methodName,
                                      amount:
                                          total, // نرسل الـ total الجديد المحسوب بدقة
                                    ),
                                  ),
                                );
                              }
                            }
                          })),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
