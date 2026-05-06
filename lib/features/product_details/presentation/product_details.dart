// ignore_for_file: avoid_print

import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/payment/presentation/widgets/custom_drink_message.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/bottom_area.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/custom_options.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/my_cliper.dart';
import 'package:dash_cup/features/product_details/presentation/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsPage extends StatefulWidget {
  ProductDetailsPage({super.key, required this.product});
  final Products product;
  final TextEditingController messageController = TextEditingController();
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          Row(
            children: [
              SideBar(
                product: widget.product,
              ),
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
                          physics: BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.product.name,
                                    style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.white)),
                                SizedBox(height: 10.h),
                                Text(
                                  widget.product.description,
                                  style: TextStyle(
                                      color: ColorsManager.eggshell,
                                      height: 1.4,
                                      fontSize: 14.sp),
                                ),
                                SizedBox(height: 30.h),
                                BlocBuilder<ProductDetailsCubit,
                                    ProductDetailsState>(
                                  builder: (context, state) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomOptions(
                                          title: "Select Size",
                                          selectedValue: cubit.size,
                                          options: cubit.availableSizes,
                                          onChanged: (size) {
                                            cubit.chooseSizeLevel(
                                                selectedSize: size);
                                          },
                                        ),
                                        SizedBox(height: 25.h),
                                        CustomOptions(
                                            title: "Sugar Level",
                                            options: cubit.sugarLevels,
                                            selectedValue: cubit.sugar,
                                            onChanged: (sugar) {
                                              cubit.chooseSugerLevel(
                                                  selectedSugarLevel: sugar);
                                            }),
                                        if (widget
                                            .product.category.hasMilkOption) ...[
                                          SizedBox(height: 25.h),
                                          CustomOptions(
                                            title: "Milk Options",
                                            options: cubit.milkTypes,
                                            selectedValue: cubit.milk,
                                            onChanged: (milkType) {
                                              cubit.chooseMilkType(
                                                  selectedMilkType: milkType);
                                            },
                                          ),
                                        ],
                                      ],
                                    );
                                  },
                                ),
                                Padding(
                                  padding: REdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 30),
                                  child: CustomDrinkMessage(
                                    messageController: widget.messageController,
                                  ),
                                ),
                                SizedBox(height: 120.h),
                              ],
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
          BlocListener<ProductDetailsCubit, ProductDetailsState>(
            listener: (context, state) {
              print(state.runtimeType);
              if (state is AddOrderToFirestoreLoading) {
                UiUtils.showLoading(context: context);
              } else if (state is AddOrderToFirestoreFailure) {
                Navigator.pop(context);
                UiUtils.showMessage(context: context, message: state.message);
              } else if (state is AddOrderToFirestoreSuccess) {
                Navigator.pop(context);
                UiUtils.showMessage(
                    context: context,
                    message: "Order added to cart successfully");
              }
            },
            child: BottomArea(
              product: widget.product,
              messageController: widget.messageController,
            ),
          ),
        ],
      ),
    );
  }
}
