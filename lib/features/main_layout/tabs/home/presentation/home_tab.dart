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
import 'package:dash_cup/features/main_layout/tabs/home/presentation/widgets/offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            decoration: BoxDecoration(
              color: ColorsManager.darkNavyBlue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 40,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(80.r),
                        child: Image.asset(
                          ImageAssets.person,
                          fit: BoxFit.cover,
                          height: 100.h,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, Alaa ✨",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            SizedBox(height: 12.h),
                            Text(
                              "Let's start your day\nwith a perfect cup.",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(fontSize: 16.sp),
                            ),
                          ],
                        ),
                      ),

                      
                      CircleAvatar(
                        backgroundColor: ColorsManager.burntOrange,
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
                ),
                Padding(
                  padding: REdgeInsets.only(left: 20.0, right: 20),
                  child: CustomTextFormField(
                    labelText: "What are you looking for today?",
                    controller: _searchController,
                    preIcon: Icon(Icons.search),
                  ),
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
                      .map((offer) => OfferWidget(imagePath: offer.image))
                      .toList(),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Categories",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 200.h,
                  child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        var category = Data.categosies[index];
                        List<Products> filteredList = Data.allProducts
                            .where(
                              (product) =>
                                  product.category.categoryid ==
                                  category.categoryid,
                            )
                            .toList();
                        Navigator.pushNamed(context, AppRoutes.productScreen,arguments:  filteredList,);
                      },
                      child: CategoryItem(
                        imagePath: Data.categosies[index].image,
                        categoryName: Data.categosies[index].name,
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(width: 12.w),
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
                    childAspectRatio: 7/11,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) => ProductItem(product: Data.popularProducts[index],),
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
