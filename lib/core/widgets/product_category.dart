import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/favourite/presentation/cubit/favourite_cubit.dart';
import '../../features/favourite/presentation/cubit/favourite_state.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({super.key, required this.product});

  final Products product;

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<ProductDetailsCubit>(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150.h,
          width: double.infinity,
          margin: REdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 57, 35, 7),
            borderRadius: BorderRadius.only(topRight: Radius.circular(16.r)),
          ),
        ),

        Positioned(
          bottom: -16.h,
          left: -10.w,
          child: Container(
            height: 185.h,
            width: 160.w,
            margin: REdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: const Color.fromARGB(255, 132, 97, 55),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.product.image, fit: BoxFit.contain),
            ),
          ),
        ),

        
        Positioned(
          left: 190.w,
          top: 20.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.product.name,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorsManager.creamyWhite),
              ),
              SizedBox(height: 10.h),
              Text(
                "Pre Time: ${widget.product.pretime}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorsManager.creamyWhite,
                    ),
              ),
              SizedBox(height: 10.h),
              Text(
                "EGP ${widget.product.price}",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: ColorsManager.creamyWhite),
              ),
            ],
          ),
        ),

        
        Positioned(
          bottom: 5.h,
          right: 40.w,
          child: Row(
            children: [
              Text(
                "${widget.product.rate}",
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: ColorsManager.creamyWhite, fontSize: 15.sp),
              ),
              SizedBox(width: 5.w),
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 15.h,
              ),
            ],
          ),
        ),

        
        Positioned(
          bottom: -10.h,
          right: -5.w,
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              bool isLoading = state is AddOrderToFirestoreLoading &&
                  cubit.loadingProductId == widget.product.productid;

              return Container(
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 132, 97, 55),
                    borderRadius: BorderRadius.circular(8.r)),
                child: isLoading
                    ? SizedBox(
                        width: 10.w,
                        height: 10.w,
                        child: CircularProgressIndicator(
                          color: ColorsManager.creamyWhite,
                          strokeWidth: 2,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          cubit.addOrderToFirestore(
                            order: OrderModel(
                              milkType: "No Milk",
                              orderId: "",
                              product: widget.product,
                              quantity: 1,
                              size: "S",
                              sugarLevel: "Normal",
                              totalPrice: widget.product.price,
                              uId: "",
                               orderDate: DateTime.now()
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: ColorsManager.creamyWhite,
                          size: 25.h,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          ),
        ),

       
        Positioned(
          top: -10.h,
          left: 5.w,
          child: BlocBuilder<FavouriteCubit, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteLoaded) {
                final isFav = state.ids.contains(widget.product.productid);

                return GestureDetector(
                  onTap: () {
                    context
                        .read<FavouriteCubit>()
                        .toggle(widget.product.productid);
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorsManager.warmBeige,
                    radius: 16.r,
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: ColorsManager.darkBrown,
                      size: 18.sp,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
