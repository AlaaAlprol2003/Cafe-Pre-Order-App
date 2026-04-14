import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.imagePath, required this.offer});
  final String imagePath;
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: ColorsManager.creamyWhite,
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.offerDetails, arguments: offer);
      },
      child: Container(
        width: double.infinity,
        margin: REdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
            border: BoxBorder.all(color: ColorsManager.charcoalBlue, width: 1),
            borderRadius: BorderRadius.circular(22.r)),
        child: Stack(
          children: [
            Hero(
              tag: offer.title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // Positioned(
            //   bottom: 10.h,
            //   right: 20.w,
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, AppRoutes.offerDetails,
            //           arguments: offer);
            //     },
            //     child: Container(
            //       alignment: Alignment.center,
            //       height: 40.h,
            //       width: 100.w,
            //       decoration: BoxDecoration(
            //           color: ColorsManager.darkOrange,
            //           borderRadius: BorderRadius.circular(10.r),
            //           boxShadow: [
            //             ///BoxShadow(color: ColorsManager.darkChocolate.withOpacity(0.4),blurRadius: 10,offset: Offset(0, 4),spreadRadius: 1)
            //           ]),
            //       child: Text("I'm In!",
            //           textAlign: TextAlign.center,
            //           style: Theme.of(context)
            //               .textTheme
            //               .titleSmall!
            //               .copyWith(color: ColorsManager.creamyWhite)),
            //     ),
            //   ),
            // ),
            Positioned(
              ///bottom: 40.h,
              right: 5.w,
              top: 5.h,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(
                      scale: value,
                      child: Container(
                        padding:
                            REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          "EGP ${offer.offerPrice.toInt()}",
                          style: GoogleFonts.roboto(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.eggshell),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
