
import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/category/category_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/favorite/favorite_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/home_tab.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_tab.dart';
import 'package:dash_cup/features/main_layout/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
    var cubit = BlocProvider.of<MainLayoutCubit>(context);
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: tabs[cubit.selectedTab],
            bottomNavigationBar: CustomBottomNavBar(),
           
          ),
        );
      },
    );
  }
}
