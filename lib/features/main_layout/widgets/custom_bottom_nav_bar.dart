import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/bottom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<MainLayoutCubit>(context);
    return Container(
      width: double.infinity,
      height: 80.h,
      margin: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: ColorsManager.darkBrown,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...List.generate(
            4,
            (index) => InkWell(
              onTap: () {
                cubit.changeTab(index: index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(BottomNavBarItem.items[index].icon,
                      color: cubit.selectedTab == index
                          ? const Color.fromARGB(255, 198, 180, 16)
                          : const Color.fromARGB(255, 219, 193, 127),
                      size: 35),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    BottomNavBarItem.items[index].title,
                    style: GoogleFonts.roboto(
                        color: ColorsManager.creamyWhite, fontSize: 12.sp),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
