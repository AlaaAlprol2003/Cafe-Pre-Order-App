import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/ai/chat_ai_screen.dart';
import 'package:dash_cup/features/ai/cubit/ai_cubit.dart';
import 'package:dash_cup/features/auth/presentation/screens/login_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/privacy_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/register_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/reset_password.dart';
import 'package:dash_cup/features/cart/presentation/cart_screen.dart';
import 'package:dash_cup/features/main_layout/main_layout.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/offers/presentation/cubit/offer_details_cubit.dart';
import 'package:dash_cup/features/offers/presentation/offer_details.dart';
import 'package:dash_cup/features/payment/presentation/credit_card_screen.dart';
import 'package:dash_cup/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:dash_cup/features/payment/presentation/payment_screen.dart';
import 'package:dash_cup/features/payment/presentation/payment_success_screen.dart';
import 'package:dash_cup/features/product/presentation/product_screen.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:dash_cup/features/product_details/presentation/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
      case AppRoutes.login:
        {
          return CupertinoPageRoute(builder: (context) => LoginScreen());
        }
      case AppRoutes.mainLayout:
        {
          return CupertinoPageRoute(builder: (context) => MainLayout());
        }
      case AppRoutes.privacy:
        {
          return CupertinoPageRoute(builder: (context) => PrivacyScreen());
        }
      case AppRoutes.resetPassword:
        {
          return CupertinoPageRoute(builder: (context) => ResetPassword());
        }
      case AppRoutes.productScreen:
        List<Products> products = settings.arguments as List<Products>;
        {
          return CupertinoPageRoute(
            builder: (context) => ProductScreen(products: products),
          );
        }
      case AppRoutes.offerDetails:
        OfferModel offer = settings.arguments as OfferModel;
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
                create: (context) => OfferDetailsCubit(),
                child: OfferDetails(
                  currentOffer: offer,
                )),
          );
        }
      case AppRoutes.payment:
        {
          return CupertinoPageRoute(
              builder: (context) => BlocProvider<PaymentCubit>(
                  create: (context) => PaymentCubit(), child: PaymentScreen()));
        }
      case AppRoutes.creditCard:
        {
          final paymentCubit = settings.arguments as PaymentCubit;
          return CupertinoPageRoute(
              builder: (context) => BlocProvider.value(
                  value: paymentCubit, child: CardDetailsScreen()));
        }
      case AppRoutes.paymentSuccess:
        {
          final args = settings.arguments as Map<String, dynamic>;
          final PaymentCubit paymentCubit = args['cubit'];
          return CupertinoPageRoute(
              builder: (context) => BlocProvider.value(
                  value: paymentCubit,
                  child: PaymentSuccessScreen(
                    paymentMethod: args['paymentMethod'],
                    amount: args['amount'],
                  )));
        }

      case AppRoutes.chatWithAI:
        {
          return CupertinoPageRoute(
              builder: (context) => BlocProvider<AiCubit>(
                  create: (context) => AiCubit(), child: ChatAIScreen()));
        }
      case AppRoutes.cart:
        {
          return CupertinoPageRoute(builder: (context) => CartScreen());
        }

      case AppRoutes.productDetails:
        var product = settings.arguments as Products;
        {
          return CupertinoPageRoute(
              builder: (context) => ProductDetailsPage(
                product: product,
              ));
        }
    }
    return null;
  }
}
