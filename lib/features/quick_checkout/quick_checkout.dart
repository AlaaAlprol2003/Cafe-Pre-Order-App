import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class QuickCheckout extends StatelessWidget {
  final OfferModel offer;
  const QuickCheckout({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.warmBeige,
      appBar: AppBar(
        title: Text("Quick Checkout", style: TextStyle(color: ColorsManager.darkChocolate)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsManager.darkChocolate),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Summary", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.h),
            _buildOfferCard(),
            const Spacer(),
            _buildTotalSection(),
            SizedBox(height: 20.h),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard() {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Image.asset(offer.cardImage, width: 80.w),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(offer.title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${offer.offerPrice} EGP", style: TextStyle(color: ColorsManager.darkOrange)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Total Amount", style: TextStyle(fontSize: 18.sp)),
        Text("${offer.offerPrice} EGP", 
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: ColorsManager.darkChocolate)),
      ],
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.darkChocolate,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        onPressed: () {
          
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Success"),
              content: const Text("Your bundle order has been placed!"),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
            ),
          );
        },
        child:  Text("Confirm Order", style: GoogleFonts.roboto(color: Colors.white,fontWeight:FontWeight.bold)),
      ),
    );
  }
}