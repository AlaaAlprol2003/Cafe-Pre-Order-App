import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/occasion_icon.dart';
import '../cubit/booking_cubit.dart';
import '../../domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BookingCubit>();

    return Container(
      padding:
        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      margin:
        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
      decoration: BoxDecoration(
        color:  ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:  EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                      color: ColorsManager.warmBeige,
                      shape: BoxShape.circle,
                    ),
                    child:  Icon(Icons.person,
                        size: 22, color: Colors.brown),
                  ),
                   SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("Name",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16.sp,
                            color: ColorsManager.darkBrown
                          )),
                      Text(
                        booking.name,
                        style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14.sp,
                            color: ColorsManager.darkBrown
                        ),

                        ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon:  Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  cubit.deleteBooking((booking as dynamic).id);
                },
              ),
            ],
          ),

           SizedBox(height: 10.h),
           Divider(),

           SizedBox(height: 10.h),

          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: ColorsManager.warmBeige,
                      //   radius: 20.r,
                      //   child: const Icon(Icons.calendar_today, color: ColorsManager.darkBrown,),
                      // ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Date & Time",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorsManager.darkBrown
                              )),
                          Text(
                            "${booking.date}.${booking.time}",
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                color: ColorsManager.darkBrown
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                    SizedBox(height: 10.h),
                  Row(
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: ColorsManager.warmBeige,
                      //   radius: 20.r,
                      //   child: Icon(getOccasionIcon(booking.occasion), color: ColorsManager.darkBrown,),
                      // ),
                        SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Occasion",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorsManager.darkBrown
                              )),
                          Text(
                            booking.occasion,
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                color: ColorsManager.darkBrown
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                    SizedBox(height: 10.h),

                ],
              ),
                SizedBox(width: 80.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: ColorsManager.warmBeige,
                      //   radius: 20.r,
                      //   child: const Icon(Icons.groups_outlined, color: ColorsManager.darkBrown,),
                      // ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("N0. of Guests",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorsManager.darkBrown
                              )),
                          Text(
                            booking.guests.toString(),
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                color: ColorsManager.darkBrown
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text("Table Type",
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 16.sp,
                                  color: ColorsManager.darkBrown
                              )),
                          Text(
                            booking.tableType,
                            style:  Theme.of(context).textTheme.bodySmall!.copyWith(
                                fontSize: 14.sp,
                                color: ColorsManager.darkBrown
                            ),

                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),

                ],
              ),

            ],
          )



        ],
      ),
    );
  }
}