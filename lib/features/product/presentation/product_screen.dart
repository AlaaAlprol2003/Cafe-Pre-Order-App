// ignore_for_file: deprecated_member_use, prefer_const_constructors_in_immutables

import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/product_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProductScreen extends StatefulWidget {
  ProductScreen({super.key, required this.products});
  final List<Products> products;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<String> items = ["Caramel", "Vanilla", "Oat Milk", "Extra Shot"];

  String? selectedItem;

  final TextEditingController _specialInstructions = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorsManager.creamyWhite,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: REdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 20,
                bottom: 50,
              ),
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
                        color: const Color.fromRGBO(227, 197, 156, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: 400.w,
                        height: 240.h,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 57, 35, 7),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      Positioned(
                        top: -40.h,
                        right: -10.w,
                        child: CircleAvatar(
                          radius: 70.r,
                          backgroundColor:
                              const Color.fromARGB(255, 255, 233, 185),
                        ),
                      ),
                      Positioned(
                        top: 10.h,
                        right: 40.w,
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundColor:
                              const Color.fromARGB(255, 132, 97, 55),
                        ),
                      ),
                      Positioned(
                        top: -10.h,
                        right: 20.w,
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundColor:
                              const Color.fromARGB(255, 62, 39, 11),
                        ),
                      ),
                      Positioned(
                        left: 20.w,
                        top: 20.h,
                        child: Text(
                          "Make It Yours",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                color: Color.fromARGB(255, 253, 235, 190),
                              ),
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        left: 20.w,
                        right: 120.w,
                        child: Column(
                          children: [
                            SizedBox(height: 12.h),
                            SizedBox(
                              child: DropdownButtonFormField<String>(
                                value: selectedItem,
                                dropdownColor:
                                    const Color.fromARGB(255, 132, 97, 55),
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
                                            color: const Color.fromARGB(
                                                255, 255, 234, 184),
                                          ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  selectedItem = newValue;
                                },
                                iconEnabledColor: ColorsManager.warmBeige,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 57, 35, 7),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                  contentPadding: REdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 50.h,
                              child: TextFormField(
                                controller: _specialInstructions,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(255, 57, 35, 7),
                                  hintText: "Any special instructions",
                                  hintStyle: Theme.of(
                                    context,
                                  ).textTheme.displayMedium!.copyWith(
                                      color: const Color.fromARGB(
                                          170, 225, 208, 165)),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 252, 232, 191),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      12.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -5.h,
                        right: -5.w,
                        child: Container(
                          height: 45.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 132, 97, 55),
                              borderRadius: BorderRadius.circular(12.r)),
                          child: Icon(
                            Icons.add_outlined,
                            color: ColorsManager.creamyWhite,
                            size: 30.h,
                            fontWeight: FontWeight.bold,
                          ),
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
                    child: AnimationLimiter(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 500),
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(seconds: 1),
                              delay: const Duration(milliseconds: 800),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: ProductCategory(
                                    product: widget.products[index],
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 130.h),
                            itemCount: widget.products.length,
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
}
