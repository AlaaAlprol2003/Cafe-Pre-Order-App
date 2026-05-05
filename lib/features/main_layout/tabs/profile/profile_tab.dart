



// ignore_for_file: use_build_context_synchronously

import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(),
                SizedBox(height: 20.h),
                _buildUserInfo(),
                SizedBox(height: 25.h),
                _buildStatsCard(),
                SizedBox(height: 25.h),
                _buildMenuCard(context),
                SizedBox(height: 20.h),
                _buildLogoutButton(context),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding:
          EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
      decoration: BoxDecoration(
        color: ColorsManager.darkChocolate,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 32),
          Text(
            "Profile",
            style: GoogleFonts.playfairDisplay(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.creamyWhite,
            ),
          ),
          Icon(Icons.settings_outlined,
              color: ColorsManager.creamyWhite, size: 26.sp),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 55.r,
              backgroundColor: ColorsManager.creamyWhite,
              child: CircleAvatar(
                radius: 50.r,
                
                backgroundImage: AssetImage(ImageAssets.person)
              ),
            ),
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: ColorsManager.darkChocolate,
                shape: BoxShape.circle,
                border: Border.all(color: ColorsManager.warmBeige, width: 2),
              ),
              child: Icon(Icons.edit, color: Colors.white, size: 14.sp),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          UserModel.currentUser!.name,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorsManager.darkChocolate,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: ColorsManager.creamyWhite,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.coffee,
                  size: 14.sp, color: ColorsManager.darkChocolate),
              SizedBox(width: 5.w),
              Text("Coffee Lover", style: TextStyle(fontSize: 11.sp)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statItem("12", "Bookings", Icons.calendar_today_outlined),
          _verticalDivider(),
          _statItem("8", "Favorites", Icons.favorite_border),
          _verticalDivider(),
          _statItem(
              "${UserModel.currentUser!.points}", "Points", Icons.star_outline),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: ColorsManager.darkChocolate, size: 22.sp),
        SizedBox(height: 6.h),
        Text(value,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        Text(label,
            style: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.grey)),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(height: 35.h, width: 1, color: Colors.grey.shade300);
  }

  Widget _buildMenuCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        children: [
          _menuItem(
            Icons.person_outline,
            "Personal Information",
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.personalInfo);
            },
          ),
          _menuItem(Icons.location_on_outlined, "Saved Addresses"),
          _menuItem(Icons.payment_outlined, "Payment Methods"),
          _menuItem(Icons.notifications_none, "Notifications", onTap: () {
            Navigator.pushNamed(context, AppRoutes.notificationsScreen);
          }),
          _menuItem(Icons.help_outline, "Help & Support", onTap: () {
            Navigator.pushNamed(context, AppRoutes.helpSupportScreen);
          }),
          _menuItem(Icons.info_outline, "About Us", isLast: true, onTap: () {
            Navigator.pushNamed(context, AppRoutes.aboutUsScreen);
          }),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title,
      {bool isLast = false, VoidCallback? onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
                color: ColorsManager.warmBeige, shape: BoxShape.circle),
            child: Icon(icon, color: ColorsManager.darkChocolate, size: 18.sp),
          ),
          title: Text(title,
              style: GoogleFonts.roboto(
                  fontSize: 16.sp, fontWeight: FontWeight.w500)),
          trailing:
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
          onTap: onTap,
        ),
        if (!isLast)
          Divider(
              height: 1,
              indent: 60.w,
              endIndent: 20.w,
              color: Colors.grey.shade100),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(left: 20,right: 20,bottom: 90),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.creamyWhite,
          foregroundColor: ColorsManager.darkChocolate,
          minimumSize: Size(double.infinity, 50.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
          elevation: 0,
        ),
        onPressed: () {
          FirebaseAuth.instance.signOut();
          UiUtils.showLoading(context: context);
          Future.delayed(Duration(seconds: 1), () {
            context.read<MainLayoutCubit>().changeTab(index: 0);
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, size: 18.sp),
            SizedBox(width: 8.w),
            Text("Log Out",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
