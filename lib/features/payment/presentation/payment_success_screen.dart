import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/features/payment/presentation/widgets/order_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:lottie/lottie.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String paymentMethod;
  final double amount;
  final String? selectedTable;
  final String? cardNumber;
  final double? remainingPoints;
  final double? pointExchangeRate;

  const PaymentSuccessScreen({
    super.key,
    required this.paymentMethod,
    required this.amount,
    this.selectedTable,
    this.cardNumber,
    this.remainingPoints,
    this.pointExchangeRate,
  });

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      backgroundColor: ColorsManager.warmBeige,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 60.h),
          child: Column(
            children: [
              Lottie.asset(LottieAssets.success, height: 300.h),
              Text(
                "Order Placed!",
                style: GoogleFonts.roboto(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.darkChocolate),
              ),
              SizedBox(height: 30.h),
              if (paymentMethod == "Fawry") _buildFawryDetails(),
              if (paymentMethod == "Vodafone") _buildVodafoneDetails(),
              if (paymentMethod == "Visa") _buildVisaDetails(),
              if (paymentMethod == "Points") _buildPointsDetails(),
              const OrderTimerWidget(
                durationInMinutes: 7,
              ),
              SizedBox(height: 50.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 71, 40, 1),
                  minimumSize: Size(double.infinity, 55.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35.r)),
                ),
                onPressed: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
                child: Text("Back to Home",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: ColorsManager.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFawryDetails() {
    return _buildContainer(
      child: Column(
        children: [
          const Text("Fawry Payment Code",
              style: TextStyle(color: Color.fromARGB(255, 130, 129, 129))),
          SizedBox(height: 8.h),
          Text("928374651",
              style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.darkOrange)),
          SizedBox(height: 8.h),
          const Text("Pay at any Fawry outlet",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 130, 129, 129))),

          if (selectedTable != null) ...[
            const Divider(),
            _buildRow("Table Number", selectedTable!,
                valueColor: ColorsManager.darkOrange, isBold: true),
          ],

          const Divider(),
          _buildRow("Total Amount", "${amount.toStringAsFixed(2)} EGP"),
        ],
      ),
    );
  }

  Widget _buildVodafoneDetails() {
    return _buildContainer(
      child: Column(
        children: [
          _buildRow("Reference ID", "#VFC-10293"),
          const Row(
            children: [
              Icon(Icons.access_time, color: Colors.orange, size: 18),
              SizedBox(width: 5),
              Text("Waiting for verification...",
                  style: TextStyle(color: Colors.orange)),
            ],
          ),
          SizedBox(height: 15.h),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_file, color: ColorsManager.darkBrown),
            label: Text("Upload Receipt",
                style: GoogleFonts.roboto(color: ColorsManager.darkBrown)),
          ),

          if (selectedTable != null) ...[
            const Divider(),
            _buildRow("Table Number", selectedTable!,
                valueColor: ColorsManager.darkOrange, isBold: true),
          ],

          const Divider(),
          _buildRow("Total Amount", "${amount.toStringAsFixed(2)} EGP"),
        ],
      ),
    );
  }

  Widget _buildVisaDetails() {
    String lastFourDigits = _formatCardNumber(cardNumber ?? "");

    return _buildContainer(
      child: Column(
        children: [
          _buildRow("Payment Method", "Credit Card"),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Text(
              "Paid via Visa ending in $lastFourDigits",
              style: GoogleFonts.roboto(
                color: ColorsManager.darkChocolate,
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildRow("Status", "Confirmed", valueColor: Colors.green),

          if (selectedTable != null) ...[
            const Divider(),
            _buildRow("Table Number", selectedTable!,
                valueColor: ColorsManager.darkOrange, isBold: true),
          ],

          const Divider(),
          _buildRow("Total Paid", "${amount.toStringAsFixed(2)} EGP",
              isBold: true),
        ],
      ),
    );
  }

  Widget _buildPointsDetails() {
    double currentRate = pointExchangeRate ?? 1.0;
    return _buildContainer(
      child: Column(
        children: [
          _buildRow("Payment Method", "Loyalty Points"),
          const Divider(),
          _buildRow("Points Redeemed",
              "-${(amount / currentRate).toStringAsFixed(0)} pts"),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: ColorsManager.darkHoney.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Remaining Balance",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: ColorsManager.darkBrown)),
                Text("${(remainingPoints ?? 0.0).toStringAsFixed(0)} Points",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.darkHoney)),
              ],
            ),
          ),

          if (selectedTable != null) ...[
            SizedBox(height: 10.h),
            _buildRow("Table Number", selectedTable!,
                valueColor: ColorsManager.darkOrange, isBold: true),
          ],

          SizedBox(height: 10.h),
          _buildRow("Total Value", "${amount.toStringAsFixed(2)} EGP",
              isBold: true),
        ],
      ),
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.eggshell,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: child,
    );
  }

  Widget _buildRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: const Color.fromARGB(255, 130, 129, 129),
                  fontWeight: FontWeight.w300,
                  fontSize: 20.sp)),
          Text(value,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
                  color: valueColor)),
        ],
      ),
    );
  }

  String _formatCardNumber(String fullNumber) {
    String cleanNumber = fullNumber.replaceAll(' ', '');
    if (cleanNumber.length >= 4) {
      return cleanNumber.substring(cleanNumber.length - 4);
    }
    return "****";
  }
}