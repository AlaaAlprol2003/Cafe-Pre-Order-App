import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/widgets/custom_elevated_button.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/offers/presentation/cubit/offer_details_cubit.dart';
import 'package:dash_cup/features/offers/presentation/widgets/highlights_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferDetails extends StatefulWidget {
  const OfferDetails({super.key, required this.currentOffer});
  final OfferModel currentOffer;

  @override
  State<OfferDetails> createState() => _OfferDetailsState();
}

class _OfferDetailsState extends State<OfferDetails> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<OfferDetailsCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorsManager.creamyWhite,
        bottomNavigationBar: ZoomIn(
          duration: Duration(seconds: 3),
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 12),
            height: 90.h,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 148, 109, 55),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Total Price",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: ColorsManager.creamyWhite),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      "EGP ${widget.currentOffer.offerPrice}",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: ColorsManager.creamyWhite),
                    ),
                  ],
                ),
                Spacer(),
                SizedBox(
                    width: 250.w,
                    child: ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 84, 47, 1),
                        ),
                        iconAlignment: IconAlignment.end,
                        icon: Icon(
                          Icons.shopping_cart,
                          color: ColorsManager.creamyWhite,
                          size: 25,
                        ),
                        label: Text(
                          "Add Bundle To Cart",style: GoogleFonts.roboto(fontSize: 18.sp,color: ColorsManager.creamyWhite,fontWeight: FontWeight.bold),
                        ))

                    // CustomElevatedButton(
                    //   onPressed: () {},
                    //   text: "Add Bundle To Cart",
                    //   icon: Icon(
                    //     Icons.shopping_cart_rounded,
                    //     size: 25,
                    //     color: ColorsManager.creamyWhite,
                    //   ),
                    // )
                    )
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250.h,
              pinned: true,
              backgroundColor: ColorsManager.warmBeige,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    alignment: Alignment.center,
                    padding: REdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                        color: ColorsManager.creamyWhite,
                        borderRadius: BorderRadius.circular(80.r)),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: ColorsManager.darkOrange,
                    ),
                  )),
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Container(
                      alignment: Alignment.center,
                      padding: REdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          color: ColorsManager.creamyWhite,
                          borderRadius: BorderRadius.circular(80.r)),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: ColorsManager.darkOrange,
                      ),
                    )),
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Hero(
                  tag: widget.currentOffer.title,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                    ),
                    items: widget.currentOffer.includedProducts
                        .map((product) => Padding(
                              padding: REdgeInsets.only(left: 12.0, right: 12),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.r),
                                child: Container(
                                  decoration: BoxDecoration(
                                      //border: Border.all(color: ColorsManager.darkOrange.withValues(alpha: .9))
                                      ),
                                  child: ZoomIn(
                                    duration: Duration(seconds: 1),
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.fill,

                                      /// width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: ColorsManager.creamyWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: REdgeInsets.symmetric(
                        horizontal: 14.0,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeInLeft(
                                duration: Duration(seconds: 3),
                                child: Text(
                                  widget.currentOffer.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          color: ColorsManager.darkChocolate,
                                          fontSize: 23.sp),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              FadeInRight(
                                duration: Duration(seconds: 3),
                                child: Text(widget.currentOffer.subTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(
                                            color: const Color.fromARGB(
                                                255, 135, 120, 102),
                                            fontSize: 16.sp)),
                              ),
                            ],
                          ),
                          Spacer(),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                ImageAssets.saveLogo,
                                height: 110.h,
                              ),
                              Positioned(
                                  right: 30.w,
                                  bottom: 20.h,
                                  child: FadeInUp(
                                    duration: Duration(seconds: 3),
                                    child: Text(
                                        "Save\n${widget.currentOffer.savedAmount.toInt()}\nEGP",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color:
                                                    ColorsManager.creamyWhite,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w900)),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      margin: REdgeInsets.symmetric(horizontal: 12),
                      padding:
                          REdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: BoxBorder.all(
                            color: const Color.fromARGB(78, 115, 80, 21)),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              FadeInLeft(
                                duration: Duration(seconds: 2),
                                child: HighlightsRow(
                                  icon: Icons.timer_rounded,
                                  text:
                                      "${widget.currentOffer.estimatedPrepTimeMinutes.toString()} Min",
                                ),
                              ),
                              SizedBox(
                                  height: 60.h,
                                  child: VerticalDivider(
                                    color: Color.fromARGB(78, 115, 80, 21),
                                    thickness: 1.5,
                                  )),
                              FadeInLeft(
                                delay: Duration(milliseconds: 400),
                                duration: const Duration(seconds: 2),
                                child: HighlightsRow(
                                    icon: Icons.local_fire_department_rounded,
                                    text:
                                        " ${widget.currentOffer.calories.toString()} Kcal"),
                              ),
                              SizedBox(
                                  height: 60.h,
                                  child: VerticalDivider(
                                    color: Color.fromARGB(78, 115, 80, 21),
                                    thickness: 1.5,
                                  )),
                              FadeInLeft(
                                delay: Duration(milliseconds: 800),
                                duration: Duration(seconds: 2),
                                child: HighlightsRow(
                                  icon: Icons.star,
                                  text:
                                      "${widget.currentOffer.rating.toString()} (${widget.currentOffer.reviewCount})",
                                ),
                              ),
                            ],
                          ),
                          // SizedBox(
                          // height: 5.h,
                          // width: double.infinity,
                          // child: Divider(color: ColorsManager.darkBrown,thickness: .5,indent: 20.w,endIndent: 20.w,)),
                        ],
                      ),
                    ),
                    FadeInUp(
                      delay: Duration(seconds: 1),
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding:
                            REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,

                          /// ColorsManager.darkOrange.withValues(alpha: .8),
                          borderRadius: BorderRadius.circular(13.r),

                          ///border: Border.all(color: ColorsManager.darkBrown)
                        ),
                        child: FadeInUp(
                          delay: Duration(seconds: 2),
                          child: Padding(
                            padding: REdgeInsets.only(top: 16.0),
                            child: Text(
                              widget.currentOffer.fullDescription,

                              ///textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: ColorsManager.darkChocolate),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 8.0),
                      child: FadeInDown(
                        duration: Duration(seconds: 3),
                        child: Text(
                          "What's Inside",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: ColorsManager.darkBrown),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...List.generate(
                            widget.currentOffer.includedProducts.length,
                            (index) => Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 60.r,
                                      child: Image.asset(
                                        widget.currentOffer
                                            .includedProducts[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      padding: REdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(13.r),
                                          color: ColorsManager.darkChocolate,
                                          border: Border.all(
                                              color: ColorsManager.darkHoney)),
                                      child: Text(
                                        widget.currentOffer
                                            .includedProducts[index].name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                                color:
                                                    ColorsManager.creamyWhite),
                                      ),
                                    )
                                  ],
                                ))
                      ],
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    SizedBox(
                        height: 5.h,
                        width: double.infinity,
                        child: Divider(
                          color: const Color.fromARGB(65, 180, 168, 152),
                          thickness: 1.5,
                          indent: 20.w,
                          endIndent: 20.w,
                        )),
                    SizedBox(
                      height: 12.h,
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Customize Your Bundle",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: ColorsManager.darkBrown),
                      ),
                    ),
                    BlocBuilder<OfferDetailsCubit, OfferDetailsState>(
                      builder: (context, state) {
                        final selectedOptions = cubit.selectedOptions;
                        return ZoomIn(
                          delay: Duration(seconds: 3),
                          child: Container(
                            width: double.infinity,
                            padding: REdgeInsets.symmetric(horizontal: 12.w),
                            margin: REdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.r),
                                color: Colors.grey.withValues(alpha: .05)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.currentOffer.customizations
                                  .map((customGroup) {
                                return Padding(
                                  padding: REdgeInsets.only(bottom: 16.h),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(customGroup.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!.copyWith(fontWeight: FontWeight.bold)),
                                      SizedBox(height: 12.h),
                                      Wrap(
                                        spacing: 10.w,
                                        runSpacing: 10.h,
                                        children:
                                            customGroup.options.map((option) {
                                          return ChoiceChip(
                                            label: Text(option),
                                            selected: selectedOptions[
                                                    customGroup.title] ==
                                                option,
                                            onSelected: (bool selected) {
                                              cubit.changeOption(
                                                  customGroup.title, option);
                                            },
                                            backgroundColor:
                                                ColorsManager.creamyWhite,
                                            selectedColor:
                                                const Color.fromARGB(255, 179, 139, 89),
                                            labelStyle: GoogleFonts.roboto(
                                              color: selectedOptions[
                                                          customGroup.title] ==
                                                      option
                                                  ? ColorsManager.white
                                                  : ColorsManager.darkChocolate,
                                              fontSize: 16.sp,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              side: BorderSide(
                                                color: selectedOptions[
                                                            customGroup
                                                                .title] ==
                                                        option
                                                    ? Colors.transparent
                                                    : ColorsManager.mediumBrown
                                                        .withValues(alpha: 0.3),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
