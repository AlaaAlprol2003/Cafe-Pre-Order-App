

import 'dart:async';
import 'package:dash_cup/core/resources/assets_manager.dart'; 
import 'package:dash_cup/core/resources/colors_manager.dart';
import 'package:dash_cup/core/routes_manager/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, 
      statusBarIconBrightness:
          Brightness.light, 
    ));
    _controller = AnimationController(
      vsync: this,
      duration:  Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    Future.delayed( Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.8,
            colors: [
              Color(0xFF1B1B1B),
              Color(0xFF050505),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color:  Color(0xFFC6B410).withOpacity(0.15),
                        blurRadius: 50,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    ImageAssets.logo,
                    width: 260.w,
                  ),
                ),
                SizedBox(height: 40.h),
                SizedBox(
                  width: 30.w,
                  height: 30.w,
                  child:  CircularProgressIndicator(
                    color:ColorsManager.darkHoney,
                    strokeWidth: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
