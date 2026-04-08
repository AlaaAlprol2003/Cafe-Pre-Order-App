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
import 'package:animated_toggle_switch/animated_toggle_switch.dart';

class SecondScreen extends StatelessWidget {
  final nameController = TextEditingController();

  SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        final cubit = context.watch<BookingCubit>();
        return Scaffold(
          appBar: AppBar(title: Text("Create Booking")),
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
                            fit: BoxFit.cover,
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
                      ),
                    ),
                    Container(
                      height: 50.h,
                      width: 400.w,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorsManager.darkBrown,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.people, color: ColorsManager.darkBrown),
                          CircleAvatar(
                            backgroundColor: ColorsManager.white,
                            radius: 20.r,
                            child: IconButton(
                              onPressed: cubit.decrement,
                              icon: Icon(Icons.remove),
                            ),
                          ),

                          BlocBuilder<BookingCubit, dynamic>(
                            builder: (context, state) {
                              return Text(
                                "${cubit.guests}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),

                          CircleAvatar(
                            backgroundColor: ColorsManager.white,
                            radius: 20.r,
                            child: IconButton(
                              onPressed: cubit.increment,
                              icon: Icon(Icons.add),
                            ),
                          ),
                        ],
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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          "Table Type",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    AnimatedToggleSwitch<String>.rolling(
                      animationCurve: Curves.easeInOut,
                      textDirection: TextDirection.ltr,
                      indicatorSize: Size(100.w, 50.h),
                      current: cubit.tableType,
                      values: ['Indoor', 'Outdoor'],
                      onChanged: (value) => cubit.setTable(value),
                      iconBuilder: (value, isSelected) => Text(
                        value,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isSelected
                              ? ColorsManager.white
                              : ColorsManager.darkBrown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                //occasion field
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            "Occasion",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DropdownButton<String>(
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
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          "Date",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsManager.darkBrown,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.calendar_month, color: ColorsManager.darkBrown),
                            Text(
                              cubit.date.isEmpty ? "Pick a Date" : cubit.date,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: () async {
                              final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                                initialDate: DateTime.now(),
                              );

                              if (date != null) {
                                cubit.setDate(date.toString().split(" ")[0]);
                              }
                            }, icon: Icon(Icons.edit_calendar, color: ColorsManager.darkBrown))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12.h),
                //time picker
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          "Time",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorsManager.darkBrown,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.watch_later_outlined, color: ColorsManager.darkBrown),
                            Text(
                              cubit.date.isEmpty ? "Pick a Time" : cubit.time,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(onPressed: () async {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );

                              if (time != null) {
                                cubit.setTime(time.format(context));
                              }
                            }, icon: Icon(Icons.add_alarm_outlined, color: ColorsManager.darkBrown))
                          ],
                        ),
                      ),
                    )
                  ],
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
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 200.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(" ${cubit.price} EGP", style:
                          TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),)],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
               //next button
               Padding(
                 padding:  EdgeInsets.all(8.h),
                 child: CustomElevatedButton(onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (_) => ThirdScreen(name: nameController.text),
                     ),
                   );
                 }, text:"Next"),
               )
              ],
            ),
          ),
        );
      },
    );
  }
}
