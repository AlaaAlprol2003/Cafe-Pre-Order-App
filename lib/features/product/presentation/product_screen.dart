// ignore_for_file: deprecated_member_use

import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key, required this.products});
  final List<Products> products;
  final List<String> items = ["Caramel", "Vanilla", "Oat Milk", "Extra Shot"];
  String? selectedItem;
  final TextEditingController _specialInstructions = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: ColorsManager.charcoalBlue,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 400.w,
                        height: 300.h,
                        decoration: BoxDecoration(
                          color: ColorsManager.charcoalBlue,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.r),
                            bottomLeft: Radius.circular(50.r),
                            topLeft: Radius.circular(50.r),
                          ),
                        ),
                      ),

                      Positioned(
                        top: -40.h,
                        right: -10.w,
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundColor: Colors.amber,
                        ),
                      ),

                      Positioned(
                        top: 10.h,
                        right: 40.w,
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundColor: Colors.deepOrange,
                        ),
                      ),

                      Positioned(
                        top: -10.h,
                        right: 20.w,
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.green,
                        ),
                      ),
                      Positioned(
                        left: 20.w,
                        top: 20.h,
                        child: Text(
                          "Make It Yours ✨",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        left: 20.w,
                        right: 120.w,
                        child: Column(
                          children: [
                            SizedBox(
                              child: DropdownButtonFormField<String>(
                                value: selectedItem,
                                dropdownColor: ColorsManager.blueGrey,
                                borderRadius: BorderRadius.circular(16.r),
                                hint: Text(
                                  "Select an add-on",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayMedium,
                                ),
                                items: items.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium!
                                          .copyWith(
                                            color: ColorsManager.burntOrange,
                                          ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  selectedItem = newValue;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorsManager.blueGrey,

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  contentPadding: REdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            CircleAvatar(
                              backgroundColor: ColorsManager.burntOrange,

                              radius: 20,
                              child: Icon(
                                Icons.add,
                                color: ColorsManager.darkNavyBlue,
                                size: 25,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextFormField(
                              controller: _specialInstructions,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: ColorsManager.blueGrey,
                                hintText: "Any special instructions",
                                hintStyle: Theme.of(
                                  context,
                                ).textTheme.displayMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Padding(
                    padding: REdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 25,
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => ProductCategory(product: products[index],),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 130.h),
                      itemCount: 10,
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
}
