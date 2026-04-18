import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/my_cliper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Products product;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 1;
  String selectedSize = "M";
  String selectedSugar = "مضبوط";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              color: ColorsManager.deepBurntBrown,
              height: 1.sh,
              width: 1.sw,
            ),
          ),

          SafeArea(
            child: Row(
              children: [
                _buildSideBar(),

                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Center(
                          child: Image.asset(
                            widget.product.image,
                            height: 250.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(15.w, 60.h, 25.w, 20.h),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.product.name,
                                    style: TextStyle(
                                        fontSize: 26.sp,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 10.h),
                                Text(
                                  widget.product.description,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      height: 1.4,
                                      fontSize: 13.sp),
                                ),
                                SizedBox(height: 30.h),
                                _buildSectionTitle("Select Size"),
                                _buildSizeOptions(),
                                SizedBox(height: 25.h),
                                _buildSectionTitle("Sugar Level"),
                                _buildSugarOptions(),
                                SizedBox(height: 120.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          _buildBottomActionArea(),
        ],
      ),
    );
  }

  Widget _buildSideBar() {
    return Container(
      color: ColorsManager.deepBrown,
      width: 85.w,
      child: Column(
        children: [
          SizedBox(height: 20.h),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.white, size: 26.sp),
          ),
          SizedBox(height: 50.h),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: widget.product.category.icon,
          ),
          SizedBox(height: 25.h),
          _sideIcon(
            widget.product.isOrganic == true
                ? Icons.eco_rounded
                : Icons.local_fire_department_outlined, 
            color:
                widget.product.isOrganic == true ? Colors.green : Colors.grey,
          ),
          SizedBox(height: 25.h),
          _sideIcon(Icons.favorite_outline_rounded, color: Colors.redAccent),
          SizedBox(height: 80.h),
          Text(widget.product.rate.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold)),
          Icon(Icons.star, color: Colors.amber, size: 20.sp),

          SizedBox(
            height: 90.h,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(widget.product.price.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold)),
          ),
          Spacer(),

          RotatedBox(
            quarterTurns: 3,
            child: Container(
              height: 160.h,
              width: 130.w,
              margin: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              child: Image.asset(
                ImageAssets.logo, 
                // width: 70.w, 
                // height: 100.h,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sideIcon(IconData icon, {Color color = Colors.white}) {
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 30.sp),
    );
  }

  Widget _buildBottomActionArea() {
    return Positioned(
      bottom: 20.h, 
      left: 95.w,
      right: 15.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 2)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _qtyBtn(Icons.remove,
                    () => setState(() => quantity > 1 ? quantity-- : null)),
                SizedBox(width: 12.w),
                Text("$quantity",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                SizedBox(width: 12.w),
                _qtyBtn(Icons.add, () => setState(() => quantity++)),
              ],
            ),
            SizedBox(
              width: 35.w,
            ),
            Expanded(
                child: Text(
              "Add to cart",
              style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  color: ColorsManager.darkChocolate,
                  fontWeight: FontWeight.bold),
            )),
            _buildDiamondButton(),
          ],
        ),
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: Colors.white, 
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Icon(
          icon,
          size: 16.sp, 
          color: const Color(0xFF2D140D), 
        ),
      ),
    );
  }

  Widget _buildDiamondButton() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: 0.785, 
          child: Container(
            height: 45.w,
            width: 45.w,
            decoration: BoxDecoration(
              color: const Color(0xFF2D140D),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.sp),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Text(title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp));

  Widget _buildSizeOptions() {
    return Row(
      children: ["S", "M", "L"].map((s) {
        bool isSelected = selectedSize == s;
        return Padding(
          padding: EdgeInsets.only(right: 15.w, top: 10.h),
          child: ChoiceChip(
            label: Container(
              width: 30.w, 
              alignment: Alignment.center,
              child: Text(s),
            ),

            selected: isSelected,
            onSelected: (v) => setState(() => selectedSize = s),

            selectedColor: const Color(0xFF2D140D), 
            backgroundColor:
                Colors.grey.shade100,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14.sp,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
              side: BorderSide(
                color:
                    isSelected ? const Color(0xFF2D140D) : Colors.transparent,
              ),
            ),

            showCheckmark: false,

            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
            elevation: isSelected ? 4 : 0,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSugarOptions() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, 
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: ["مفيش", "خفيف", "مضبوط", "زيادة"]
            .map((sugar) => Padding(
                  padding: EdgeInsets.only(right: 10.w, top: 10.h),
                  child: ChoiceChip(
                    label: Text(sugar, style: TextStyle(fontSize: 12.sp)),
                    selected: selectedSugar == sugar,
                    selectedColor: const Color(0xFFD4A373),
                    labelStyle: TextStyle(
                        color: selectedSugar == sugar
                            ? Colors.white
                            : Colors.black),
                    onSelected: (v) => setState(() => selectedSugar = sugar),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

