import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/graduation_project_model.dart';

class FavouriteCard extends StatelessWidget {
  final Products product;
  final VoidCallback? onFavTap;
  final VoidCallback? onDeleteTap;
  final bool isFav;

  const FavouriteCard({
    super.key,
    required this.product,
    this.onFavTap,
    this.onDeleteTap,
    this.isFav = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: ColorsManager.darkOrange
                .withValues(alpha: .15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, 4),
          )
        ],
        color:ColorsManager.creamyWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // image
          CircleAvatar(
            child: Image.asset(product.image),
            backgroundColor: ColorsManager.eggshell,
            radius: 45.r,
          ),

          const SizedBox(width: 12),

          // details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 18.sp
                  )
                ),

                const SizedBox(height: 4),

                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style:Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp,
                    color: Colors.grey
                  )
                ),

                const SizedBox(height: 6),

                Text(
                  "${product.price.toInt()} EGP",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16.sp,
                    color: ColorsManager.darkHoney
                  )
                ),
              ],
            ),
          ),

          // actions
          Column(
            children: [
              GestureDetector(
                onTap: onFavTap,
                child: Icon(
                  isFav?Icons.favorite_border_outlined:Icons.favorite,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 40),

              GestureDetector(
                onTap: onDeleteTap,
                child: Container(
                  padding:  EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: ColorsManager.warmBeige,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.delete,
                    size: 20,
                    color: ColorsManager.mediumBrown2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}