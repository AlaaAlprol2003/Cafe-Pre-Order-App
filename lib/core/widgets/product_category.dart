import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/resources/ui_utils.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          decoration: BoxDecoration(
            color: ColorsManager.darkChocolate,
            borderRadius: BorderRadius.only(topRight: Radius.circular(16.r)),
          ),
        ),
        Positioned(
          bottom: -16.h,
          left: -10.w,
          child: Container(
            height: 185.h,
            width: 160.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: ColorsManager.darkBrown),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.asset(widget.product.image, fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned(
          left: 160.w,
          top: 20.h,
          child: Column(
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
              SizedBox(height: 10.h),
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
          right: -10.w,
          child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
            builder: (context, state) {
              // إحنا محتاجين نعرف هل اللودينج ده يخص المنتج الحالي ولا لأ
              // بس كحل سريع وبسيط، هنظهر اللودينج لو الحالة Loading
              bool isLoading = state is AddOrderToFirestoreLoading &&
                  cubit.loadingProductId == widget.product.productid;

              return CircleAvatar(
                backgroundColor: ColorsManager.burntOrange,
                radius: 20.r,
                child: isLoading
                    ? SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: CircularProgressIndicator(
                          color: ColorsManager.darkNavyBlue,
                          strokeWidth: 2, // عشان يبقى رفيع ولطيف
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
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add,
                          color: ColorsManager.darkNavyBlue,
                          size: 20.sp,
                        ),
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
