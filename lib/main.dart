import 'package:dash_cup/config/theme/theme_manager.dart';
import 'package:dash_cup/core/routes_manager/app_router.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/presentation/screens/register/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: DashCupApp(),
    ),
  );
}

class DashCupApp extends StatelessWidget {
  const DashCupApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.register,
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
