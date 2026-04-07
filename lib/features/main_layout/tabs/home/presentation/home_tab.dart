// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/core/widgets/custom_text_form_field.dart';
import 'package:dash_cup/core/widgets/product_item.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/category_item.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/mood_sheet.dart';
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeTab extends StatelessWidget {
  HomeTab({super.key});
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 270.h,

            padding: REdgeInsets.symmetric(vertical: 50,horizontal: 16),
            decoration: BoxDecoration(
              color: ColorsManager.darkHoney,
              gradient: LinearGradient(
                
                colors: [
                const Color.fromARGB(255, 53, 29, 1),
                const Color.fromARGB(255, 80, 45, 2),
              ]),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 36, 19, 0),
                        borderRadius: BorderRadius.circular(80.r)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80.r),
                        child: Image.asset(
                          ImageAssets.person,
                          fit: BoxFit.cover,
                          height: 80.h,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Alaa",
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ColorsManager.creamyWhite,),
                          ),
                          SizedBox(height: 5.h),
                          
                             
                          Text(
                            "Let's start your day\nwith a perfect cup.",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(fontWeight: FontWeight.w400,color: const Color.fromARGB(255, 251, 241, 205),fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 168, 101, 8),
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
                SizedBox(height: 24.h,),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16,),
                        child: SizedBox(
                          height: 50.h,
                          child: CustomTextFormField(
                            labelText: "What are you looking for?",
                            controller: _searchController,
                            preIcon: Icon(Icons.search,color: ColorsManager.darkOrange,),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => showMoodSheet(context),
                      icon: Icon(
                        Icons.auto_fix_high,
                        color: const Color.fromARGB(255, 149, 92, 11),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
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
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: const Color.fromARGB(255, 64, 25, 1)),
                ),
                SizedBox(height: 35.h),
                SizedBox(
                  height: 200.h,
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
                    itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                      position: index,
                        duration: const Duration(seconds: 1),
                        delay: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: InkWell(

                            onTap: ()  {
                              var category = Data.categosies[index];
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
                              imagePath: Data.categosies[index].image,
                              icon: Data.categosies[index].icon,
                              categoryName: Data.categosies[index].name,
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 20.w),
                    itemCount: Data.categosies.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Text(
                  "Popular Items",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: ColorsManager.darkNavyBlue,
                      ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 7 / 11,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) =>
                      ProductItem(product: Data.popularProducts[index]),
                  itemCount: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
