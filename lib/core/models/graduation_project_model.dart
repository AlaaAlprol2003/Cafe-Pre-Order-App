import 'package:flutter/material.dart';

class Category {
  final String categoryid;
  final String name;
  final String image;
  final Widget icon;
  
  final bool hasMilkOption;
  final bool hasSugarOption;

  Category({
    required this.categoryid,
    required this.name,
    required this.image,
    required this.icon,
    this.hasMilkOption = false, 
    this.hasSugarOption = false,
  });

}

class Products {
  final String productid;
  final String name;
   double price;
  final double rate;
  final String pretime;
  final String image;
  final Category category;
  final String description;
  
  bool isFavorite; 
  final bool isOrganic;

  Products({
    required this.productid,
    required this.name,
    required this.price,
    required this.rate,
    required this.pretime,
    required this.image,
    required this.category,
    required this.description,
    this.isFavorite = false,
    this.isOrganic = false,
  });

}