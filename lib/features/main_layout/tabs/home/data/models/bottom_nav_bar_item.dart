import 'package:flutter/material.dart';

class BottomNavBarItem {
  IconData icon;
  String title;

  BottomNavBarItem({required this.icon, required this.title});

 static List<BottomNavBarItem> items = [
    BottomNavBarItem(icon: Icons.home, title: "Home"),
    BottomNavBarItem(icon: Icons.table_bar, title: "Booking"),
    BottomNavBarItem(icon: Icons.favorite, title: "Favorite"),
    BottomNavBarItem(icon: Icons.person, title: "Profile"),
  ];
}
