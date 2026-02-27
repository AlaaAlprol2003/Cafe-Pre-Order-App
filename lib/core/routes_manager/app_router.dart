import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/presentation/screens/login_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/privacy_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/register_screen.dart';
import 'package:dash_cup/features/auth/presentation/screens/reset_password.dart';
import 'package:dash_cup/features/main_layout/main_layout.dart';
import 'package:flutter/cupertino.dart';

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
    }
    return null;
  }
}
