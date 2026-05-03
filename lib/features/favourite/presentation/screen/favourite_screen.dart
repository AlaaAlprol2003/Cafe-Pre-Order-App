import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/models/Graduation_Project_Data.dart';
import '../../../../core/models/graduation_project_model.dart';
import '../../../../core/resources/colors_manager.dart';
import '../cubit/favourite_cubit.dart';
import '../cubit/favourite_state.dart';
import '../widget/favourite_card.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
          body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
            child: Row(
              children: [
                SizedBox(width: 110.w),
                Row(
                  children: [
                    Text(
                      "Your Favourites",
                      style:
                          Theme.of(context).textTheme.displayMedium!.copyWith(
                                color: ColorsManager.darkBrown,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                    )
                  ],
                ),
              ],
            ),
          ),
          Text("your most loved drinks, all in one place",
              style: Theme.of(context).textTheme.bodySmall),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                if (state is FavouriteLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FavouriteLoaded) {
                  final products = state.ids
                      .map((id) {
                        try {
                          return Data.allProducts.firstWhere(
                            (p) => p.productid == id,
                          );
                        } catch (_) {
                          return null;
                        }
                      })
                      .whereType<Products>()
                      .toList();

                  if (products.isEmpty) {
                    return const Center(child: Text("No favourites yet"));
                  }

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return FavouriteCard(
                        product: product,
                        isFav: false,
                        onFavTap: () {
                          context
                              .read<FavouriteCubit>()
                              .toggle(product.productid);
                        },
                        onDeleteTap: () {
                          context
                              .read<FavouriteCubit>()
                              .toggle(product.productid);
                        },
                      );
                    },
                  );
                }

                if (state is FavouriteError) {
                  return Center(child: Text(state.message));
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      )),
    );
  }
}
