import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';

import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/category/category_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/favorite/favorite_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/home_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_tab.dart';
import 'package:dash_cup/features/main_layout/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class MainLayout extends StatelessWidget {
  MainLayout({super.key});
  final List<Widget> tabs = [
    HomeTab(),
    CategoryTab(),
    FavoriteTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().getUserData();
    var cubit = BlocProvider.of<MainLayoutCubit>(context);
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: tabs[cubit.selectedTab],
            bottomNavigationBar: CustomBottomNavBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.chatWithAI);
              },
              elevation: 10,
             
              backgroundColor: ColorsManager.darkHoney,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    color: ColorsManager.creamyWhite,
                  ),
                  Text(
                    "Dash AI",
                    style: GoogleFonts.roboto(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorsManager.creamyWhite),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
