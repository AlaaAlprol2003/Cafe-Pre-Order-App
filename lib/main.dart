import 'package:dash_cup/config/theme/theme_manager.dart';
import 'package:dash_cup/core/di/service_locator.dart';
import 'package:dash_cup/core/routes_manager/app_router.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:dash_cup/features/main_layout/cubit/main_layout_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator.get<AuthCubit>()),
        BlocProvider(create: (context) => MainLayoutCubit()),
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
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.payment,
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
