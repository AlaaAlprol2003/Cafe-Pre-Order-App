import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:dash_cup/features/payment/presentation/models/payment_method.dart';
import 'package:dash_cup/features/payment/presentation/payment_success_screen.dart';
import 'package:dash_cup/features/payment/presentation/table_scanner_screen.dart';
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
import 'package:google_fonts/google_fonts.dart';

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
              actions: [CustomDropdown(count: orders.length)],
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                margin: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: ColorsManager.creamyWhite,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.darkBrown.withValues(alpha: 0.1),
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
                    SizedBox(
                      height: 16.h,
                    ),
                    BlocBuilder<PaymentCubit, PaymentState>(
                      builder: (context, state) {
                        if (cubit.currentIndex == 1) {
                          return Padding(
                            padding: REdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: ColorsManager.eggshell,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: ColorsManager.darkChocolate
                                      .withValues(alpha: 0.2),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.qr_code_scanner,
                                          color: ColorsManager.darkChocolate),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Dining at the cafe?",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.darkChocolate,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.h),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 42.h),
                                      side: const BorderSide(
                                          color: ColorsManager.darkOrange),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.r)),
                                    ),
                                    onPressed: () async {
                                      final scannedResult =
                                          await Navigator.push<String>(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TableScannerScreen()),
                                      );
                                      if (scannedResult != null) {
                                        cubit.setTableNumber(scannedResult);
                                        cubit.changePickUpType(isDineIn: true);
                                      }
                                    },
                                    child: Text(
                                      cubit.selectedTable != null
                                          ? "Table Linked: ${cubit.selectedTable}"
                                          : "Scan Table QR Code",
                                      style: TextStyle(
                                        color: ColorsManager.darkBrown,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
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

                            double deliveryFees =
                                cubit.currentIndex == 1 ? 0.0 : 15;
                            double vat = currentSubtotal * 0.14;
                            double total = currentSubtotal + vat + deliveryFees;

                            if (cubit.currentPaymentMethod == 0) {
                              Navigator.pushNamed(context, AppRoutes.creditCard,
                                  arguments: cubit);
                            } else if (cubit.currentPaymentMethod == 3) {
                              if (cubit.hasEnoughPoints(total)) {
                                UiUtils.showLoading(context: context);

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
                              String methodName =
                                  cubit.currentPaymentMethod == 1
                                      ? "Fawry"
                                      : "Vodafone";
                              UiUtils.showLoading(context: context);

                              await cubit.updateUserPoints(totalAmount: total);

                              await Future.delayed(const Duration(seconds: 2));
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentSuccessScreen(
                                      paymentMethod: methodName,
                                      amount: total,
                                      selectedTable: cubit.selectedTable,
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
