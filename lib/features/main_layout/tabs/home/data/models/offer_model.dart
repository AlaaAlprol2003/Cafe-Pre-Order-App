import 'package:dash_cup/core/resources/assets_manager.dart';

class OfferModel {
  final String title;
  final String description;
  final String image;

  OfferModel({
    required this.title,
    required this.description,
    required this.image,
  });

  static List<OfferModel> dashBundles = [
    OfferModel(
      title: "The Classic Duo ☕🥐",
      description:
          "Start your morning right with our signature Latte and a freshly baked Butter Croissant.",
      image: ImageAssets.classicDuo,
    ),
    OfferModel(
      title: "Sweet Escape 🍩🥤",
      description:
          "Pair any of our colorful glazed donuts with a refreshing Iced Coffee of your choice.",
      image: ImageAssets.sweetEscape,
    ),
    OfferModel(
      title: "Energy Pack ⚡🍪",
      description:
          "Need a boost? Get a Double Espresso shot served with two of our homemade Choco-chip cookies.",
      image: ImageAssets.energyPack,
    ),
    OfferModel(
      title: "Afternoon Chill 🍦☕",
      description:
          "The perfect mix of hot and cold! Enjoy an Affogato paired with a mini chocolate muffin.",
      image: ImageAssets.afternoonChili,
    ),
    OfferModel(
      title: "Double Delight 🥯☕",
      description:
          "Share the love (or don't!) with two Bagels and two Americano coffees at a special price.",
      image: ImageAssets.doubleDelight,
    ),
    OfferModel(
      title: "Late Night Study 📚🌙",
      description:
          "Stay focused with a Large Cappuccino and a protein bar to keep you going all night.",
      image: ImageAssets.lateNight,
    ),
  ];
}
