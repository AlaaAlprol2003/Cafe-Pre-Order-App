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
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Container(
        width: double.infinity,
        height: 80.h,
        margin: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: ColorsManager.darkBrown,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 15,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
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
                            ? const Color.fromARGB(255, 219, 193, 127)
                            : ColorsManager.warmBeige,
                        size: 35),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      BottomNavBarItem.items[index].title,
                      style: GoogleFonts.roboto(
                          color: cubit.selectedTab == index
                              ?  const Color.fromARGB(255, 219, 193, 127)                              : ColorsManager.warmBeige,
                          fontSize: 12.sp),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
