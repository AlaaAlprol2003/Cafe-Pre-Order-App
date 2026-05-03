import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/occasion_icon.dart';
import '../cubit/booking_cubit.dart';

class ThirdScreen extends StatelessWidget {
  final String name;

  const ThirdScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipperTwo(),
                  child: Stack(
                    children: [
                      Container(
                        height: 250.h,
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
                Positioned(
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios,
                            color: ColorsManager.creamyWhite)))
              ],
            ),
            SizedBox(height: 30.h,),
            Container(
                width: 400.w,
                height: 450.h,
                decoration: BoxDecoration(
                  color: ColorsManager.creamyWhite,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.darkOrange.withValues(alpha: .15),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: Column(children: [
                  //name and date
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //name
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorsManager.warmBeige,
                                child: Icon(Icons.person,
                                    size: 30.sp, color: ColorsManager.darkBrown),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                  Text(
                                    name,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ],
                          ),


                          //Date
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorsManager.warmBeige,
                                child: Icon(Icons.calendar_today,
                                    size: 30.sp, color: ColorsManager.darkBrown),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                  Text(
                                    cubit.date,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),


                  //guests and time
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(

                      children: [
                        //guests
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorsManager.warmBeige,
                              child: Icon(Icons.groups_outlined,
                                  size: 30.sp, color: ColorsManager.darkBrown),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "No. of guests",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16.sp),
                                ),
                                Text(
                                  cubit.guests.toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 80.w,
                        ),
                        //time
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorsManager.warmBeige,
                              child: Icon(Icons.access_time_rounded,
                                  size: 30.sp, color: ColorsManager.darkBrown),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Time",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16.sp),
                                ),
                                Text(
                                  cubit.time,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //table type and occasion
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 16.w , vertical: 16.h),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //table type
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: ColorsManager.warmBeige,
                                child: Icon(Icons.table_bar_outlined,
                                    size: 30.sp,
                                    color: ColorsManager.darkBrown),
                              ),
                              SizedBox(width: 10.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Table type",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 16.sp),
                                  ),
                                  Text(
                                    cubit.tableType,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(width: 94.w,),
                          //occasion
                          Row(children: [
                            CircleAvatar(
                              backgroundColor: ColorsManager.warmBeige,
                              child: Icon(getOccasionIcon(cubit.occasion),
                                  size: 30.sp, color: ColorsManager.darkBrown),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Occasion",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 16.sp),
                                ),
                                Text(
                                  cubit.occasion,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            )
                          ])
                        ]),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //price
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 350.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.creamyWhite,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color:
                                ColorsManager.darkOrange.withValues(alpha: .15),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 12.h),
                        child: Row(
                          children: [
                            Transform.rotate(
                              angle: 1.285,
                              child: CircleAvatar(
                                backgroundColor: ColorsManager.warmBeige,
                                radius: 30.sp,
                                child: Icon(
                                  Icons.local_offer_outlined,
                                  color: ColorsManager.darkBrown,
                                  size: 30.sp,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              "Price: ${cubit.price} EGP",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.darkBrown),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ])),
            Spacer(),
            Padding(
                padding: EdgeInsets.all(8.h),
                child: Container(
                  width: 400.w,
                  height: 60.h,
                  child: ElevatedButton(
                      onPressed: () async {
                        await cubit.confirmBooking(name);
                        Navigator.popUntil(context, (r) => r.isFirst);
                      },
                      child: Text("Confirm Booking",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.creamyWhite))),
                ))
          ],
        ),
      ),
    );
  }
}
