// ignore_for_file: deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key, required this.products});
  final List<Products> products;
  String? confirmedProduct;
  String? confirmedNotes;
  bool showPreview = false;
  final TextEditingController _specialInstructions = TextEditingController();
  String? selectedItem;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: ColorsManager.creamyWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  REdgeInsets.only(left: 12, right: 12, top: 20, bottom: 50),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        alignment: Alignment.center,
                        padding:REdgeInsets.only(left: 12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.darkChocolate
                        ),
                        child: Icon(Icons.arrow_back_ios,
                            color: ColorsManager.creamyWhite),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 240.h,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 57, 35, 7),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      _buildDecorativeCircle(-40, -10, 70,
                          const Color.fromARGB(255, 255, 233, 185)),
                      _buildDecorativeCircle(
                          10, 40, 50, const Color.fromARGB(255, 132, 97, 55)),
                      _buildDecorativeCircle(
                          -10, 20, 40, const Color.fromARGB(255, 62, 39, 11)),
                      Positioned(
                          right: 30.w,
                          top: -15.h,
                          left: 320.w,
                          child: Image.asset(
                            "assets/images/flower.png",
                            height: 90.h,
                          )),
                      Positioned(
                        left: 20.w,
                        top: 20.h,
                        child: Text(
                          "Make It Yours",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: const Color.fromARGB(255, 253, 235, 190),
                              ),
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        left: 20.w,
                        right: 140.w,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                              child: DropdownButtonFormField<String>(
                                value: widget.selectedItem,
                                dropdownColor:
                                    const Color.fromARGB(255, 132, 97, 55),
                                borderRadius: BorderRadius.circular(16.r),
                                hint: Text("Select an add-on",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: ColorsManager.creamyWhite)),
                                items: widget.products
                                    .map((product) => DropdownMenuItem(
                                          value: product.name,
                                          child: Text(product.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayMedium!
                                                  .copyWith(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              234,
                                                              184))),
                                        ))
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => widget.selectedItem = val),
                                decoration: _inputDecoration(),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 60.h,
                              child: TextFormField(
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: ColorsManager.creamyWhite),
                                maxLines: 2,
                                controller: widget._specialInstructions,
                                decoration: _inputDecoration(
                                    hint: "Any special instructions"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -5.h,
                        right: -5.w,
                        child: Container(
                          height: 50.h,
                          width: 65.w,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 132, 97, 55),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: InkWell(
                            onTap: () {
                              if (widget.selectedItem == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Please select a product first!")),
                                );
                                return;
                              }

                              String productDescription =
                                  widget._specialInstructions.text.isEmpty
                                      ? "No extra additions"
                                      : widget._specialInstructions.text;

                              showModalBottomSheet(
                                context: context,
                                backgroundColor:
                                    const Color.fromARGB(255, 57, 35, 7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.r)),
                                ),
                                builder: (context) => Container(
                                  padding: EdgeInsets.all(24.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          width: 50.w,
                                          height: 5.h,
                                          decoration: BoxDecoration(
                                            color: ColorsManager.creamyWhite
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        "Order Summary ✨",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              color: ColorsManager.creamyWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Container(
                                        padding: EdgeInsets.all(16.w),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 132, 97, 55)
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(15.r),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.coffee_rounded,
                                                color: ColorsManager.darkHoney,
                                                size: 30.sp),
                                            SizedBox(width: 15.w),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Product: ${widget.selectedItem}",
                                                    style: TextStyle(
                                                      color: ColorsManager
                                                          .creamyWhite,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Text(
                                                    "Add-ons: $productDescription",
                                                    style: TextStyle(
                                                      color: ColorsManager
                                                          .creamyWhite
                                                          .withOpacity(0.7),
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30.h),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 55.h,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.confirmedProduct =
                                                  widget.selectedItem;
                                              widget.confirmedNotes = widget
                                                      ._specialInstructions
                                                      .text
                                                      .isEmpty
                                                  ? "No extra additions"
                                                  : widget._specialInstructions
                                                      .text;
                                              widget.showPreview = true;
                                            });
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 132, 97, 55),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                            ),
                                          ),
                                          child: Text(
                                            "Confirm & Close",
                                            style: TextStyle(
                                              color: ColorsManager.creamyWhite,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Icon(Icons.add_outlined,
                                color: ColorsManager.creamyWhite, size: 30.h),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (widget.showPreview)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 132, 97, 55)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15.r),
                          border: Border.all(
                              color: const Color.fromARGB(255, 132, 97, 55),
                              width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Your Current Choice ☕",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 57, 35, 7))),
                                InkWell(
                                  onTap: () => setState(
                                      () => widget.showPreview = false),
                                  child: Icon(Icons.close,
                                      size: 20.sp, color: Colors.red),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            Text("Product: ${widget.confirmedProduct}",
                                style: TextStyle(fontSize: 14.sp)),
                            Text("Notes: ${widget.confirmedNotes}",
                                style: TextStyle(
                                    fontSize: 13.sp, color: Colors.grey[700])),
                          ],
                        ),
                      ),
                    ),

                  SizedBox(height: 50.h),

                  AnimationLimiter(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.products.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 130.h),
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(seconds: 1),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () => Navigator.pushNamed(
                                  context, AppRoutes.productDetails,
                                  arguments: widget.products[index]),
                              child: ProductCategory(
                                  product: widget.products[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeCircle(
      double top, double right, double radius, Color color) {
    return Positioned(
      top: top.h,
      right: right.w,
      child: CircleAvatar(radius: radius.r, backgroundColor: color),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 57, 35, 7),
      hintText: hint,
      hintStyle: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(color: const Color.fromARGB(170, 225, 208, 165)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 252, 232, 191)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 252, 232, 191)),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
