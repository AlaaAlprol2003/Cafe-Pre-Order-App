import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/occasion_icon.dart';
import '../cubit/booking_cubit.dart';
import '../cubit/booking_state.dart';
import 'third_screen.dart';

class SecondScreen extends StatelessWidget {
  final nameController = TextEditingController();

  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.watch<BookingCubit>();
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //image
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
                                  color: ColorsManager.creamyWhite))),
                      Positioned(
                        left: 100.w,
                        top: 100.h,
                        child: Text(
                          "Reserve Your Table",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: ColorsManager.warmBeige),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 12.h),
                  //guests counter
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "No. of Guests",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 16.sp,
                              color: ColorsManager.darkBrown,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        height: 65.h,
                        width: 400.w,
                        decoration: BoxDecoration(
                          color: ColorsManager.creamyWhite,
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.darkOrange
                                  .withValues(alpha: .15),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            )
                          ],
                          border: Border.all(
                            color: ColorsManager.creamyWhite,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                color: ColorsManager.darkBrown,
                                size: 45.sp,
                              ),
                              SizedBox(
                                width: 60.w,
                              ),
                              Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.r)),
                                    border: Border.all(
                                      color: ColorsManager.darkBrown
                                          .withValues(alpha: .2),
                                      style: BorderStyle.solid,
                                    )),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                            color: ColorsManager.darkBrown
                                                .withValues(alpha: .2),
                                            style: BorderStyle.solid,
                                          )),
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.decrement();
                                          },
                                          icon: Icon(Icons.remove,
                                              color: ColorsManager.darkBrown)),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      "${cubit.guests} Guests",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 18.sp,
                                            color: ColorsManager.darkBrown,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24.r),
                                          border: Border.all(
                                            color: ColorsManager.darkBrown
                                                .withValues(alpha: .2),
                                            style: BorderStyle.solid,
                                          )),
                                      child: IconButton(
                                          onPressed: () {
                                            cubit.increment();
                                          },
                                          icon: Icon(Icons.add,
                                              color: ColorsManager.darkBrown)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  //name field
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.darkOrange
                                  .withValues(alpha: .15),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            )
                          ],
                        ),
                        width: 400.w,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Your Name",
                            hintStyle: TextStyle(
                                color: ColorsManager.darkBrown
                                    .withValues(alpha: .5)),
                            prefixIcon: Icon(
                              Icons.person,
                              color: ColorsManager.darkBrown,
                              size: 35.sp,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 18.h,
                              horizontal: 16.w,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                  color: ColorsManager.darkBrown.withValues(
                                alpha: .2,
                              )),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 18.h),
                  //table type toggle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Table Type",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.darkBrown),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManager.darkOrange
                                    .withValues(alpha: .15),
                                blurRadius: 10,
                                spreadRadius: 0,
                                offset: Offset(0, 4),
                              )
                            ],
                          ),
                          child: AnimatedToggleSwitch<String>.rolling(
                            style: ToggleStyle(
                                backgroundColor: ColorsManager.creamyWhite,
                                indicatorColor: ColorsManager.darkChocolate,
                                borderColor: ColorsManager.darkChocolate
                                    .withValues(alpha: .2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18.r))),
                            animationCurve: Curves.easeInOut,
                            animationDuration: Duration(milliseconds: 300),
                            textDirection: TextDirection.ltr,
                            indicatorSize: Size(200.w, 50.h),
                            current: cubit.tableType,
                            values: ['Indoor', 'Outdoor'],
                            onChanged: (value) => cubit.setTable(value),
                            iconBuilder: (value, isSelected) => Text(
                              value,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: isSelected
                                    ? ColorsManager.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  //occasion field
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Occasion",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.darkBrown),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          width: 400.w,
                          child: DropdownButtonFormField<String>(
                              value: cubit.occasion,
                              onChanged: (val) {
                                cubit.setOccasion(val!);
                              },
                              items: [
                                "Birthday",
                                "Engagement",
                                "Graduation",
                                "Meeting",
                                "Football match"
                              ]
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Row(
                                          children: [
                                            Icon(
                                              getOccasionIcon(e),
                                              size: 18,
                                              color: ColorsManager.darkBrown,
                                            ),
                                            SizedBox(width: 8),
                                            Text(e),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: ColorsManager.darkBrown,
                                fontWeight: FontWeight.bold,
                              ),
                              dropdownColor: ColorsManager.creamyWhite,
                              borderRadius: BorderRadius.circular(16.r),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                      color: ColorsManager.creamyWhite),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                      color: ColorsManager.darkBrown.withValues(
                                    alpha: .2,
                                  )),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                  borderSide: BorderSide(
                                      color: ColorsManager.darkBrown.withValues(
                                    alpha: .2,
                                  )),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  //date&time picker
                  Container(
                    width: 400.w,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Date",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorsManager.darkBrown,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 60.h,
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsManager.darkOrange
                                          .withValues(alpha: .15),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                  color: ColorsManager.creamyWhite,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: ColorsManager.creamyWhite
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        color: ColorsManager.darkBrown),
                                    SizedBox(width: 10.w),
                                    Text(
                                      cubit.date.isEmpty
                                          ? "Pick a Date"
                                          : cubit.date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 14.sp,
                                            color: ColorsManager.darkChocolate,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final date = await showDatePicker(
                                            context: context,
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2100),
                                            initialDate: DateTime.now(),
                                          );

                                          if (date != null) {
                                            cubit.setDate(
                                                date.toString().split(" ")[0]);
                                          }
                                        },
                                        icon: Icon(Icons.edit_calendar,
                                            color: ColorsManager.darkBrown))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        //Time picker
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Time",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: ColorsManager.darkBrown,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 60.h,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsManager.darkOrange
                                          .withValues(alpha: .15),
                                      blurRadius: 10,
                                      spreadRadius: 0,
                                      offset: Offset(0, 4),
                                    )
                                  ],
                                  color: ColorsManager.creamyWhite,
                                  borderRadius: BorderRadius.circular(16.r),
                                  border: Border.all(
                                    color: ColorsManager.creamyWhite
                                        .withOpacity(0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        color: ColorsManager.darkBrown),
                                    SizedBox(width: 10.w),
                                    Text(
                                      cubit.date.isEmpty
                                          ? "Pick a Time"
                                          : cubit.time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontSize: 14.sp,
                                            color: ColorsManager.darkChocolate,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    IconButton(
                                        onPressed: () async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );

                                          if (time != null) {
                                            cubit.setTime(time.format(context));
                                          }
                                        },
                                        icon: Icon(Icons.add_alarm_outlined,
                                            color: ColorsManager.darkBrown))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  //price
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            "Price",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.darkBrown),
                          ),
                        ),
                      ),
                      Container(
                        width: 400.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.darkOrange
                                  .withValues(alpha: .15),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(0, 4),
                            )
                          ],
                          color: ColorsManager.creamyWhite,
                          // border: Border.all(
                          //   color: ColorsManager.darkBrown,
                          //   style: BorderStyle.solid,
                          // ),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Transform.rotate(
                              angle: 1.285,
                              child: CircleAvatar(
                                backgroundColor: ColorsManager.warmBeige,
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
                              " ${cubit.price} EGP",
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsManager.darkBrown),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  //next button
                  Padding(
                      padding: EdgeInsets.all(8.h),
                      child: Container(
                        width: 400.w,
                        height: 60.h,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ThirdScreen(name: nameController.text),
                                ),
                              );
                            },
                            child: Text("Next",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.creamyWhite))),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
