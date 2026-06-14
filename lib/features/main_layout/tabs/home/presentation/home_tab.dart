// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/product_item.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/category_item.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/mood_sheet.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: REdgeInsets.only(bottom: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 210.h,
              padding: REdgeInsets.only(top: 80.h, left: 16.w, right: 16.w),
              decoration: BoxDecoration(
                color: ColorsManager.darkHoney,
                gradient: LinearGradient(colors: [
                  const Color.fromARGB(255, 53, 29, 1),
                  const Color.fromARGB(255, 80, 45, 2),
                ]),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25.r),
                  bottomLeft: Radius.circular(25.r),
                ),
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 36, 19, 0),
                            borderRadius: BorderRadius.circular(80.r)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80.r),
                          child: UserModel.currentUser?.image != null &&
                                  UserModel.currentUser!.image!.isNotEmpty
                              ? Image.network(
                                  UserModel.currentUser!.image!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.network(
                                    "https://ui-avatars.com/api/?name=${UserModel.currentUser?.name ?? 'U'}&background=FF7043&color=fff",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Image.network(
                                  "https://ui-avatars.com/api/?name=${UserModel.currentUser?.name ?? 'U'}&background=FF7043&color=fff",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, ${UserModel.currentUser!.name.split(' ').first}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: ColorsManager.creamyWhite,
                                  ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Let's start your day\nwith a perfect cup.",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 251, 241, 205),
                                      fontSize: 14.sp),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: ColorsManager.darkHoney,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.cart);
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      CircleAvatar(
                        backgroundColor: ColorsManager.darkHoney,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.light_mode,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Positioned(
                    bottom: -28.h,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              height: 50.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorsManager.darkBrown
                                          .withValues(alpha: .5),
                                      blurRadius: 10,
                                      spreadRadius: -4,
                                      offset: Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      hintText: "What are you looking for?",
                                      hintStyle: GoogleFonts.roboto(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsManager.mediumBrown
                                            .withValues(alpha: .5),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.search,
                                        color: ColorsManager.darkOrange,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () => showMoodSheet(context),
                                        icon: Icon(
                                          Icons.auto_fix_high,
                                          color: const Color.fromARGB(
                                              255, 149, 92, 11),
                                          size: 25,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorsManager.warmBeige),
                                          borderRadius:
                                              BorderRadius.circular(16.r))),
                                  controller: _searchController,
                                  textInputAction: TextInputAction.search,
                                  onFieldSubmitted: (value) {
                                    if (value.trim().isEmpty) return;

                                    List<Products> searchResults = Data
                                        .allProducts
                                        .where((product) => product.name
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();

                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.productScreen,
                                      arguments: searchResults,
                                    );
                                  },
                                ),
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
            SizedBox(height: 60.h),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.h,
                      autoPlay: true,
                      enlargeFactor: 1,
                      viewportFraction: 1,
                    ),
                    items: OfferModel.dashBundles
                        .map((offer) => OfferWidget(
                              imagePath: offer.cardImage,
                              offer: offer,
                            ))
                        .toList(),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "Categories",
                    style: GoogleFonts.inter(
                        color:ColorsManager.darkHoney,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 35.h),
                  SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child:

                        // CarouselSlider(
                        //   items: Data.categosies
                        //       .map(
                        //         (category) => InkWell(
                        //           onTap: () {
                        //             List<Products> filteredList = Data.allProducts
                        //                 .where(
                        //                   (product) =>
                        //                       product.category.categoryid ==
                        //                       category.categoryid,
                        //                 )
                        //                 .toList();

                        //             Navigator.pushNamed(
                        //               context,
                        //               AppRoutes.productScreen,
                        //               arguments: filteredList,
                        //             );
                        //           },
                        //           child: CategoryItem(
                        //             imagePath: category.image,
                        //             categoryName: category.name,
                        //           ),
                        //         ),
                        //       )
                        //       .toList(),
                        //   options: CarouselOptions(
                        //     autoPlay: true,
                        //     autoPlayInterval: const Duration(seconds: 3),
                        //     autoPlayAnimationDuration: const Duration(
                        //       milliseconds: 800,
                        //     ),
                        //     autoPlayCurve: Curves.fastOutSlowIn,
                        //     enlargeCenterPage: true,
                        //     viewportFraction: 0.45,
                        //     scrollDirection: Axis.horizontal,
                        //   ),
                        // ),

                        ListView.separated(
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(seconds: 1),
                        delay: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                var category = Data.categories[index];
                                List<Products> filteredList = Data.allProducts
                                    .where(
                                      (product) =>
                                          product.category.categoryid ==
                                          category.categoryid,
                                    )
                                    .toList();

                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.productScreen,
                                  arguments: filteredList,
                                );
                              },
                              child: CategoryItem(
                                imagePath: Data.categories[index].image,
                                icon: Data.categories[index].icon,
                                categoryName: Data.categories[index].name,
                              ),
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 20.w),
                      itemCount: Data.categories.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Popular Items",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color:ColorsManager.darkHoney,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 7 / 10,
                      mainAxisSpacing: 40.h,
                      crossAxisSpacing: 30.w,
                    ),
                    itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  ColorsManager.darkBrown.withValues(alpha: .5),
                              blurRadius: 10,
                              spreadRadius: -4,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.productDetails,
                                  arguments: Data.popularProducts[index]);
                            },
                            child: ProductItem(
                                product: Data.popularProducts[index]))),
                    itemCount: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
