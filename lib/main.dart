import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_cup/config/theme/theme_manager.dart';
import 'package:dash_cup/core/di/service_locator.dart';
import 'package:dash_cup/core/routes_manager/app_router.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/booking/presentation/cubit/booking_cubit.dart';
import 'package:dash_cup/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:dash_cup/features/main_layout/tabs/profile/profile_cubit.dart';
import 'package:dash_cup/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/booking/data/datasource/booking_remote_datasource.dart';
import 'features/booking/data/repository/booking_repository_impl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  Firebase.initializeApp();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator.get<AuthCubit>()),
        BlocProvider(
            create: (context) => serviceLocator.get<ProductDetailsCubit>()),
        BlocProvider(create: (context) => MainLayoutCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => FavouriteCubit()),
        BlocProvider(
          create: (context) => BookingCubit(
            BookingRepositoryImpl(
              BookingRemoteDataSource(FirebaseFirestore.instance),
            ),
          ),
        ),
      ],
      child: DashCupApp(),
    ),
  );
}

class DashCupApp extends StatelessWidget {
  const DashCupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          //Size(1920, 1080),
          Size(430, 932),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splashScreen,
        onGenerateRoute: AppRouter.router,
        theme: ThemeManager.lightTheme,
        darkTheme: ThemeManager.darkTheme,
        themeMode: ThemeMode.dark,
        locale: Locale("en"),
        supportedLocales: [Locale("en"), Locale("ar")],
      ),
    );
  }
}
