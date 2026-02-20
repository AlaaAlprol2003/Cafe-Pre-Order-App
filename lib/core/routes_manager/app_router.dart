import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:dash_cup/features/auth/presentation/screens/register/register_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRouter {
 static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.register:
        {
          return CupertinoPageRoute(builder: (context) => RegisterScreen());
        }
    }
    return null;
  }
}
