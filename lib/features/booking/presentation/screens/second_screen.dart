import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        return Scaffold(
          appBar: AppBar(
              title: Text(
            "Create Booking",
            style: TextStyle(
                color: ColorsManager.creamyWhite,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
          )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //image
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
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                //guests counter
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. of Guests",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.darkBrown
                      ),
                    ),
                    Container(
                      height: 80.h,
                      width: 400.w,

                      decoration: BoxDecoration(
                        color: ColorsManager.creamyWhite,
                        border: Border.all(
                          color: ColorsManager.darkBrown,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Row(

                          children: [
                            Icon(Icons.people, color: ColorsManager.darkBrown, size: 45.sp,),
                            SizedBox(width: 80.w,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(24.r)),

                                border: Border.all(
                                  color: ColorsManager.darkBrown,
                                  style: BorderStyle.solid,
                                )
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        cubit.decrement();
                                      },
                                      icon: Icon(Icons.remove,
                                          color: ColorsManager.darkBrown)),
                                  Text(
                                    "${cubit.guests} Guests",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        cubit.increment();
                                      },
                                      icon: Icon(Icons.add,
                                          color: ColorsManager.darkBrown)),
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
                  child: CustomTextFormField(
                    labelText: "Name",
                    controller: nameController,
                  ),
                ),
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
                              color: ColorsManager.darkBrown
                          ),
                        ),
                      ),
                      AnimatedToggleSwitch<String>.rolling(
                        style: ToggleStyle(
                          backgroundColor: ColorsManager.creamyWhite,
                          indicatorColor: ColorsManager.darkBrown,
                          borderColor: ColorsManager.darkBrown,
                          borderRadius: BorderRadius.all(Radius.circular(18.r))
                        ), animationCurve: Curves.easeInOut,
                        animationDuration: Duration(milliseconds: 300),
                        textDirection: TextDirection.ltr,
                        indicatorSize: Size(150.w, 50.h),
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
                              color: ColorsManager.darkBrown
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: ColorsManager.darkBrown,
                          fontWeight: FontWeight.bold,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(16.r)),
                        dropdownColor: ColorsManager.creamyWhite,
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
                                  child: Text(e),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                //date picker
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                              color: ColorsManager.darkBrown
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.creamyWhite,

                            border: Border.all(
                              color: ColorsManager.darkBrown,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.calendar_month,
                                  color: ColorsManager.darkBrown),
                              Text(
                                cubit.date.isEmpty ? "Pick a Date" : cubit.date,
                                style: TextStyle(
                                  fontSize: 18.sp,
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
                                      cubit
                                          .setDate(date.toString().split(" ")[0]);
                                    }
                                  },
                                  icon: Icon(Icons.edit_calendar,
                                      color: ColorsManager.darkBrown))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                //time picker
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Time",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                              color: ColorsManager.darkBrown
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.creamyWhite,

                            border: Border.all(
                              color: ColorsManager.darkBrown,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.watch_later_outlined,
                                  color: ColorsManager.darkBrown),
                              Text(
                                cubit.date.isEmpty ? "Pick a Time" : cubit.time,
                                style: TextStyle(
                                  fontSize: 18.sp,
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
                      )
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
                              color: ColorsManager.darkBrown
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 200.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.creamyWhite,
                        border: Border.all(
                          color: ColorsManager.darkBrown,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " ${cubit.price} EGP",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
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
                  child: CustomElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ThirdScreen(name: nameController.text),
                          ),
                        );
                      },
                      text: "Next"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
