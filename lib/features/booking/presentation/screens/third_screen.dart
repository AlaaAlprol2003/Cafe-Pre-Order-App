import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/booking_cubit.dart';

class ThirdScreen extends StatelessWidget {
  final String name;

  const ThirdScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return Scaffold(
      appBar: AppBar(title: Text("Confirm Booking")),
      body: Column(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Stack(
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/blur cafe background.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 100.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 36.w),
            margin:EdgeInsets.symmetric(horizontal: 12.w) ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              color: ColorsManager.white,
            ),
            height: 350.h,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            name,
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey , fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            "No. of Guests",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${cubit.guests}",
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 20.h),
                          Text(
                            "Table Type",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cubit.tableType,
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 55.w),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            cubit.date,

                            style: TextStyle(fontSize: 18.sp, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 20.h),

                          Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cubit.time,
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 20.h),
                          Text(
                            "Occasion",
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cubit.occasion,
                            style: TextStyle(fontSize: 18.sp, color: Colors.grey,fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Price: ${cubit.price} EGP",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.w,vertical: 6.h),
            child: CustomElevatedButton(onPressed: () async {
              await cubit.confirmBooking(name);
              Navigator.popUntil(context, (r) => r.isFirst);
            }, text: "Confirm Booking", ),
          ),
        ],
      ),
    );
  }
}
