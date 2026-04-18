import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double sideBarWidth = 85.w;   
    path.lineTo(sideBarWidth, 0);

    path.quadraticBezierTo(sideBarWidth, size.height * 0.42, size.width * 0.45,
        size.height * 0.42);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.42,
        size.width * 0.78, size.height * 0.35);
    path.quadraticBezierTo(
        size.width * 0.92, size.height * 0.42, size.width, size.height * 0.48);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
