import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/favourite/presentation/cubit/favourite_cubit.dart';
import '../../features/favourite/presentation/cubit/favourite_state.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});
  final Products product;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: ColorsManager.darkChocolate,
        borderRadius: BorderRadius.circular(16.r),
        
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorsManager.warmBeige,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.r))),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Image.asset(
                    product.image,
                    height: 170.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: REdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: ColorsManager.creamyWhite),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(height: 8.h),
                    Text(
                      "EGP ${product.price}",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(color: ColorsManager.creamyWhite),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: ColorsManager.warmBeige,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: ColorsManager.darkChocolate,
                  size: 24.sp,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8.h,
            right: 8.w,
            child: CircleAvatar(
              backgroundColor: ColorsManager.warmBeige,
              radius: 14.r,
              child: BlocBuilder<FavouriteCubit, FavouriteState>(
                builder: (context, state) {

                  if (state is FavouriteLoaded) {
                    final isFav = state.ids.contains(product.productid);

                    return GestureDetector(
                      onTap: () {
                        context.read<FavouriteCubit>().toggle(product.productid);
                      },
                      child: CircleAvatar(
                        backgroundColor: ColorsManager.warmBeige,
                        radius: 16.r,
                        child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: ColorsManager.darkBrown
                        ),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 5.h,
            right: 50.w,
            child: Row(
              children: [
                Text(
                  "${product.rate}",
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: ColorsManager.darkOrange, fontSize: 14.sp),
                ),
                Icon(Icons.star, color: Colors.amber, size: 16.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
