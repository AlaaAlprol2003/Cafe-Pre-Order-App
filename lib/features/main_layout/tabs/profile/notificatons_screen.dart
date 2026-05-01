import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
          "Notifications",
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
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildNotificationItem(
            title: index == 0 ? "Points Earned! 🎉" : "Order Ready ☕",
            body: index == 0 
                ? "You've earned 15 points from your last order. Keep going!" 
                : "Your drink and snack are ready for pickup. Enjoy!",
            time: "2 mins ago",
            isRead: index > 1,
            icon: index == 0 ? Icons.stars_rounded : Icons.fastfood_rounded,
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String body,
    required String time,
    required bool isRead,
    required IconData icon,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: isRead ? ColorsManager.creamyWhite.withOpacity(0.7) : ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
        border: isRead ? null : Border.all(color: ColorsManager.darkOrange.withOpacity(0.3), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: isRead ? Colors.grey[200] : ColorsManager.warmBeige,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isRead ? Colors.grey : ColorsManager.darkChocolate,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 15.w),
         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: isRead ? Colors.grey[700] : ColorsManager.darkChocolate,
                      ),
                    ),
                    if (!isRead)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: ColorsManager.darkOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  body,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}