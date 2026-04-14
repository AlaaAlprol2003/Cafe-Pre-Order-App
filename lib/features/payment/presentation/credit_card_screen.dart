// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:dash_cup/features/payment/presentation/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<PaymentCubit>(context);

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: ColorsManager.warmBeige,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Card Details",
          style: GoogleFonts.roboto(
            color: ColorsManager.darkChocolate,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorsManager.darkChocolate),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          return Column(
            children: [
              CreditCardWidget(
                cardNumber: cubit.cardNumber,
                expiryDate: cubit.expiryDate,
                cardHolderName: cubit.cardHolderName,
                cvvCode: cubit.cvvCode,
                showBackView: cubit.isCvvFocused,
                onCreditCardWidgetChange: (brand) {},
                bankName: 'Dash Bank',
                cardBgColor: ColorsManager.darkChocolate,

                ///glassmorphismConfig: Glassmorphism.defaultConfig(),
                enableFloatingCard: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        cardNumber: cubit.cardNumber,
                        expiryDate: cubit.expiryDate,
                        cardHolderName: cubit.cardHolderName,
                        cvvCode: cubit.cvvCode,
                        onCreditCardModelChange: (model) {
                          cubit.updateCreditCardModel(model);
                        },
                        inputConfiguration: InputConfiguration(
                          cardNumberDecoration: buildInputDecoration(
                              "Card Number", Icons.credit_card),
                          expiryDateDecoration: buildInputDecoration(
                              "Expiry Date", Icons.calendar_month),
                          cvvCodeDecoration:
                              buildInputDecoration("CVV", Icons.lock_outline),
                          cardHolderDecoration: buildInputDecoration(
                              "Card Holder", Icons.person_outline),
                        ),
                      ),
                      SizedBox(height: 70.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.darkBrown,
                            minimumSize: Size(double.infinity, 55.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              double deliveryFees =
                                  cubit.currentIndex == 1 ? 0.0 : 15;
                              double total = cubit.subtotalValue +
                                  (cubit.subtotalValue * 0.14) +
                                  deliveryFees;

                              UiUtils.showLoading(context: context);

                              await Future.delayed(Duration(seconds: 2));

                              Navigator.pushNamed(
                                context,
                                AppRoutes.paymentSuccess,
                                arguments: {
                                  'cubit': cubit,
                                  'paymentMethod': 'Visa',
                                  'amount': total,
                                },
                              );
                            }
                          },
                          child: Text(
                            "Confirm Payment",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  InputDecoration buildInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: ColorsManager.darkHoney),
      labelStyle: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: ColorsManager.darkHoney,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.darkBrown.withOpacity(0.2)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: ColorsManager.darkOrange, width: 1.5),
      ),
    );
  }
}
