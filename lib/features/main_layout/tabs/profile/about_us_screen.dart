import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.warmBeige,
      appBar: AppBar(
        backgroundColor: ColorsManager.darkChocolate,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "About Us",
          style: GoogleFonts.playfairDisplay(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          children: [
            // 1. App Logo
            _buildAppLogo(),
            SizedBox(height: 30.h),

            // 2. Our Story
            _buildInfoCard(
              "Our Story",
              "Dash Cup started with a simple idea: to make your coffee experience more seamless and rewarding. We believe that every cup tells a story, and we're here to help you write yours.",
            ),

            // 3. Vision & Goal
            Row(
              children: [
                Expanded(
                  child: _buildSmallCard("Our Vision", "Being your favorite destination for premium drinks and delightful snacks."),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildSmallCard("Our Goal", "To offer a diverse menu that satisfies every taste, anytime and anywhere."),
                ),
              ],
            ),
            
            SizedBox(height: 20.h),

            // 4. Team Section (أسماء الفريق)
            _buildTeamSection(),
            
            SizedBox(height: 30.h),

            // 5. Social Media Icons
            Text(
              "Follow us on",
              style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook),
                SizedBox(width: 20.w),
                _buildSocialIcon(Icons.camera_alt_outlined),
                SizedBox(width: 20.w),
                _buildSocialIcon(Icons.language_outlined),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAppLogo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
        ],
      ),
      child: Icon(
        Icons.coffee_maker_rounded,
        size: 80.sp,
        color: ColorsManager.darkChocolate,
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.darkChocolate,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            content,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meet Our Team",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.darkChocolate,
            ),
          ),
          SizedBox(height: 15.h),
          // عرض أسماء الفريق
          _teamMember("Alaa Ahmed Fathi"),
          SizedBox(height: 5.h,),
          _teamMember("Omar Tamer Abdelkader"),
          SizedBox(height: 5.h,),
          _teamMember("Zeinab Youssef Abdelnaeem"),
          SizedBox(height: 5.h,),
          _teamMember("Shaimaa Mohamed El-Gammal"),
          SizedBox(height: 5.h,),
          _teamMember("Rahma Abdelhamid El-Ghannam"),
          SizedBox(height: 15.h),
          Divider(color: Colors.grey.shade200),
          SizedBox(height: 5.h),
          Text(
            "BIS Students - Tanta University",
            style: GoogleFonts.roboto(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: ColorsManager.darkChocolate.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _teamMember(String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Icon(Icons.coffee_rounded, size: 16.sp, color: ColorsManager.darkChocolate),
          SizedBox(width: 12.w),
          Text(
            name,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[800],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallCard(String title, String content) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: ColorsManager.darkChocolate),
          ),
          SizedBox(height: 8.h),
          Text(
            content,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[600], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: ColorsManager.darkChocolate,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20.sp),
    );
  }
}