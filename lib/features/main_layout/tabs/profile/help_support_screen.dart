import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.warmBeige,
      appBar: AppBar(
        backgroundColor: ColorsManager.darkChocolate,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Help & Support",
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Frequently Asked Questions"),
            SizedBox(height: 10.h),
            _buildFAQTile(context, "How can I track my order?"),
            _buildFAQTile(context, "Can I cancel my booking?"),
            _buildFAQTile(context, "How do I use my points?"),
            _buildFAQTile(context, "Where can I find Dash Cup branches?"),
            
            SizedBox(height: 35.h),
            _buildSectionTitle("Contact Us"),
            SizedBox(height: 10.h),
            _buildContactCard(Icons.chat_outlined, "Chat with us", "Our team is here to help"),
            _buildContactCard(Icons.email_outlined, "Email Support", "support@dashcup.com"),
            _buildContactCard(Icons.phone_outlined, "Call Us", "+20 123 456 789"),
            
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(left: 5.w),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.darkChocolate,
        ),
      ),
    );
  }

  Widget _buildFAQTile(BuildContext context, String question) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset:  Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          shape:  RoundedRectangleBorder(side: BorderSide.none),
          collapsedShape:  RoundedRectangleBorder(side: BorderSide.none),
          title: Text(
            question,
            style: GoogleFonts.playfairDisplay(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.darkChocolate,
            ),
          ),
          iconColor: ColorsManager.darkChocolate,
          collapsedIconColor: Colors.grey,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 15.h),
              child: Text(
                "You can manage this through your profile settings or by contacting our support team directly. We strive to provide the best coffee experience for you.",
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 13.sp,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset:  Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: ColorsManager.warmBeige,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ColorsManager.darkChocolate, size: 24.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                    color: ColorsManager.darkChocolate,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey[400]),
        ],
      ),
    );
  }
}