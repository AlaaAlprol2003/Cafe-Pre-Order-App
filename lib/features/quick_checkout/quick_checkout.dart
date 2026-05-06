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
        title: Text("Quick Checkout",
            style: TextStyle(color: ColorsManager.darkChocolate)),
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
            Text("Order Summary",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
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
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              offer.cardImage,
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15.w),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      offer.title,
                      style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.darkChocolate,
                      ),
                    ),
                    
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: ColorsManager.darkOrange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        "Bundle",
                        style: TextStyle(
                          color: ColorsManager.darkOrange,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  offer.subTitle, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${offer.offerPrice} EGP",
                      style: GoogleFonts.roboto(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w900,
                        color: ColorsManager.darkChocolate,
                      ),
                    ),
                    
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 14.sp, color: Colors.grey),
                        SizedBox(width: 4.w),
                        Text(
                          "${offer.estimatedPrepTimeMinutes} min",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkChocolate)),
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Success"),
              content: const Text("Your bundle order has been placed!"),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            ),
          );
        },
        child: Text("Confirm Order",
            style: GoogleFonts.roboto(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
