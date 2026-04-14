import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';

class OfferCustomization {
  final String title;
  final List<String> options;
  OfferCustomization({required this.title, required this.options});
}

class OfferModel {
  final String id;
  final String title;
  final String cardImage;
  final String subTitle;
  final String fullDescription;
  final double offerPrice;
  final int estimatedPrepTimeMinutes;
  final int calories;
  final double rating;
  final int reviewCount;
  final List<Products> includedProducts;
  final List<OfferCustomization> customizations;
  final bool isLimitedTime;

  OfferModel({
    required this.id,
    required this.title,
    required this.cardImage,
    required this.subTitle,
    required this.fullDescription,
    required this.offerPrice,
    required this.estimatedPrepTimeMinutes,
    required this.calories,
    required this.rating,
    required this.reviewCount,
    required this.includedProducts,
    required this.customizations,
    this.isLimitedTime = false,
  });

  double get savedAmount {
    double originalPrice =
        includedProducts.fold(0, (sum, product) => sum + product.price);

    double diff = originalPrice - offerPrice;

    return diff > 0 ? diff : 0;
  }

  static List<String> milkOpts = [
    "Whole Milk",
    "Skimmed Milk",
    "Almond Milk (+15)",
    "Oat Milk (+15)"
  ];
  static List<String> sugarOpts = [
    "No Sugar",
    "Half Sugar",
    "Regular",
    "Extra Sugar"
  ];
  static List<String> iceOpts = ["No Ice", "Less Ice", "Normal Ice"];

  static List<OfferModel> dashBundles = [
    OfferModel(
      id: "OFF_1",
      title: "THE CLASSIC DUO",
      cardImage: ImageAssets.classicDuo,
      subTitle: "Latte + Turkey Cheese Croissant",
      fullDescription:
          "Experience the ultimate Parisian morning. Our smooth, velvety Latte crafted with premium Arabica beans, paired perfectly with a golden, flaky croissant stuffed with melted turkey cheese. A balance of warmth and crunch in every bite.",
      offerPrice: 110.0,
      estimatedPrepTimeMinutes: 8,
      calories: 420,
      rating: 4.8,
      reviewCount: 150,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC7"),
        Data.allProducts.firstWhere((p) => p.productid == "LB3"),
      ],
      customizations: [
        OfferCustomization(title: "Milk Type", options: milkOpts),
        OfferCustomization(title: "Sugar Level", options: sugarOpts),
      ],
    ),
    OfferModel(
      id: "OFF_2",
      title: "SWEET ESCAPE",
      cardImage: ImageAssets.sweetEscape,
      subTitle: "Iced Coffee + Donut",
      fullDescription:
          "Cool down and treat yourself. Enjoy our signature cold-brewed iced coffee, served over crystal clear ice, alongside a soft, cloud-like donut dipped in rich sugar glaze. The perfect sugary spark to brighten up your afternoon.",
      offerPrice: 55.0,
      estimatedPrepTimeMinutes: 5,
      calories: 510,
      rating: 4.9,
      reviewCount: 210,
      isLimitedTime: true,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "IC1"),
        Data.allProducts.firstWhere((p) => p.productid == "DS21"),
      ],
      customizations: [
        OfferCustomization(title: "Ice Level", options: iceOpts),
        OfferCustomization(
            title: "Donut Flavor",
            options: ["Glazed", "Chocolate", "Strawberry", "Caramel"]),
      ],
    ),
    OfferModel(
      id: "OFF_3",
      title: "ENERGY PACK",
      cardImage: ImageAssets.energyPack,
      subTitle: "Double Espresso + Cinnamon Roll",
      fullDescription:
          "For those who need to conquer the day. A double shot of our strongest espresso to jumpstart your brain, complemented by a warm cinnamon roll dripping with cream cheese frosting and aromatic spices. Energy never tasted this good.",
      offerPrice: 65.0,
      estimatedPrepTimeMinutes: 6,
      calories: 390,
      rating: 4.7,
      reviewCount: 95,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC2"),
        Data.allProducts.firstWhere((p) => p.productid == "DS22"),
      ],
      customizations: [
        OfferCustomization(title: "Sugar Level", options: sugarOpts),
        OfferCustomization(
            title: "Extra Topping",
            options: ["None", "Walnuts", "Extra Caramel", "Pecan"]),
      ],
    ),
    OfferModel(
      id: "OFF_4",
      title: "AFTERNOON CHILL",
      cardImage: ImageAssets.afternoonChili,
      subTitle: "Espresso + Molten Cake",
      fullDescription:
          "Indulge in a moment of pure bliss. A bold, hot espresso shot designed to cut through the intense richness of our signature molten lava cake. Break the crust to reveal a gooey, warm chocolate center that melts in your mouth.",
      offerPrice: 90.0,
      estimatedPrepTimeMinutes: 12,
      calories: 680,
      rating: 4.9,
      reviewCount: 340,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC1"),
        Data.allProducts.firstWhere((p) => p.productid == "DS12"),
      ],
      customizations: [
        OfferCustomization(
            title: "Add Ice Cream",
            options: ["No Thanks", "Vanilla Scoop", "Chocolate Scoop"]),
        OfferCustomization(
            title: "Molten Center",
            options: ["Dark Chocolate", "White Chocolate", "Lotus"]),
      ],
    ),
    OfferModel(
      id: "OFF_5",
      title: "DOUBLE DELIGHT",
      cardImage: ImageAssets.doubleDelight,
      subTitle: "2 Americano + 2 Chicken Panini",
      fullDescription:
          "Double the taste, double the fun. This shareable bundle features two deep-flavored Americanos and two freshly pressed chicken paninis, loaded with premium cheese and grilled to perfection. Perfect for a lunch date or a meeting.",
      offerPrice:85.0,
      estimatedPrepTimeMinutes: 15,
      calories: 850,
      rating: 4.6,
      reviewCount: 120,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC3"),
        Data.allProducts.firstWhere((p) => p.productid == "LB1"),
      ],
      customizations: [
        OfferCustomization(
            title: "Extra Cheese", options: ["No", "Cheddar", "Mozzarella"]),
        OfferCustomization(
            title: "Spice Level", options: ["Normal", "Spicy", "Extra Hot"]),
      ],
    ),
    OfferModel(
      id: "OFF_6",
      title: "LATE NIGHT STUDY",
      cardImage: ImageAssets.lateNight,
      subTitle: "Cappuccino + Nachos Cheese",
      fullDescription:
          "Fuel for the midnight achievers. A frothy, comforting Cappuccino to keep you focused, paired with crunchy nachos served with a side of warm, gooey cheddar cheese dip. The ultimate savory-sweet combo for long study sessions.",
      offerPrice: 75.0,
      estimatedPrepTimeMinutes: 10,
      calories: 440,
      rating: 4.8,
      reviewCount: 480,
      isLimitedTime: true,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC6"),
        Data.allProducts.firstWhere((p) => p.productid == "DS23"),
      ],
      customizations: [
        OfferCustomization(title: "Milk Type", options: milkOpts),
        OfferCustomization(
            title: "Extra Dipping",
            options: ["Extra Cheese", "Jalapeños", "Sour Cream"]),
      ],
    ),
  ];
}
