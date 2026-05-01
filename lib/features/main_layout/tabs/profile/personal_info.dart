import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInfomationState();
}

class _PersonalInfomationState extends State<PersonalInformation> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: UserModel.currentUser?.name);
    phoneController = TextEditingController(text: UserModel.currentUser?.phone);
    emailController = TextEditingController(text: UserModel.currentUser?.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

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
          "Personal Information",
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
      body: BlocProvider(
        create: (context) =>
            ProfileCubit(), 
        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile Updated Successfully!")),
              );
              Navigator.pop(
                  context); 
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                children: [
                  _buildEditableTile(
                    controller: nameController,
                    icon: Icons.person_outline,
                    label: "Full Name",
                  ),
                  _buildEditableTile(
                    controller: emailController,
                    icon: Icons.email_outlined,
                    label: "Email Address",
                  ),
                  _buildEditableTile(
                    controller: phoneController,
                    icon: Icons.phone_android_outlined,
                    label: "Phone Number",
                  ),
                  _buildLockedTile(
                    icon: Icons.lock_outline,
                    label: "Password",
                    value: "••••••••••••",
                  ),
                  SizedBox(height: 40.h),

                  state is ProfileUpdateLoadingState
                      ? const CircularProgressIndicator(
                          color: ColorsManager.darkChocolate)
                      : ElevatedButton.icon(
                          onPressed: () {
                            ProfileCubit.get(context).updateProfile(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          },
                          icon: const Icon(Icons.check_circle_outline,
                              color: Colors.white),
                          label: Text("Save Changes",
                              style: GoogleFonts.roboto(fontSize: 16.sp,color:ColorsManager.white,fontWeight:FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.darkChocolate,
                            minimumSize: Size(double.infinity, 55.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                          ),
                        ),
                        SizedBox(height:30.h),
                        Image.asset(ImageAssets.logo),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEditableTile({
    required TextEditingController controller,
    required IconData icon,
    required String label,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorsManager.warmBeige,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: ColorsManager.darkChocolate, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          SizedBox(height: 8.h),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: ColorsManager.darkChocolate,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.grey[600],fontWeight:FontWeight.bold),
                border: InputBorder.none,
                isDense: true,
                contentPadding: REdgeInsets.symmetric(vertical:15,horizontal:14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockedTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.creamyWhite
            .withOpacity(0.6),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: const BoxDecoration(
                color: ColorsManager.warmBeige, shape: BoxShape.circle),
            child: Icon(icon, color: ColorsManager.darkChocolate, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
              SizedBox(height: 4.h),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const Spacer(),
          Icon(Icons.lock_clock_outlined, size: 16.sp, color: Colors.grey),
        ],
      ),
    );
  }
}
