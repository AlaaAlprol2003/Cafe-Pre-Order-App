import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:dash_cup/core/resources/assets_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      cardImage: "assets/images/croissant.jpg",
      subTitle: "Latte + Turkey Cheese Croissant",
      fullDescription:
          "Experience the ultimate Parisian morning. Our smooth, velvety Latte crafted with premium Arabica beans, paired perfectly with a golden, flaky croissant stuffed with melted turkey cheese. A balance of warmth and crunch in every bite.",
      offerPrice: 150.0,
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
      cardImage: "assets/images/cinnabon.jpg",
      subTitle: "Iced Coffee + Cinnamon Roll",
      fullDescription:
         "Cool down and treat your taste buds. Enjoy our signature cold-brewed classic iced coffee, served over crystal clear ice, alongside a soft, warm Cinnamon Roll dripping with rich cream cheese frosting. The perfect sugary spark to brighten up your afternoon.",
      offerPrice: 140.0,
      estimatedPrepTimeMinutes: 5,
      calories: 510,
      rating: 4.9,
      reviewCount: 210,
      isLimitedTime: true,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "IC1"),
        Data.allProducts.firstWhere((p) => p.productid == "DS22"),
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
      cardImage: "assets/images/cupcake.jpg",
      subTitle: "Double Espresso + Cupcake",
      fullDescription:
         "For those who need to conquer the day. A bold double shot of our strongest espresso to jumpstart your brain, complemented by a freshly baked, delicious cupcake topped with a rich, creamy swirl of buttercream frosting. Energy never tasted this good.",
      offerPrice: 95.0,
      estimatedPrepTimeMinutes: 6,
      calories: 390,
      rating: 4.7,
      reviewCount: 95,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC2"),
        Data.allProducts.firstWhere((p) => p.productid == "DS26"),
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
      cardImage: "assets/images/afternoon_chill2.png",
      subTitle: "Espresso + Molten Cake",
      fullDescription:
         "Indulge in a moment of pure bliss. A smooth, velvety Latte crafted with premium Arabica beans, designed to perfectly balance the intense richness of our signature molten lava cake. Break the crust to reveal a gooey, warm chocolate center that melts in your mouth.",
      offerPrice: 180.0,
      estimatedPrepTimeMinutes: 12,
      calories: 680,
      rating: 4.9,
      reviewCount: 340,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "HC7"),
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
      cardImage: "assets/images/double_delight2.jpg",
      subTitle: "2 Latte + 2 Dounts",
      fullDescription:
        "Double the taste, double the fun. Share the perfect sweet break with a friend. This shareable bundle features two of our smooth, velvety Lattes paired with two freshly baked, soft donuts glazed to perfection. Ideal for a cozy coffee date or a meeting.",
      offerPrice:220.0,
      estimatedPrepTimeMinutes: 15,
      calories: 850,
      rating: 4.6,
      reviewCount: 120,
      includedProducts: [
       Data.allProducts.firstWhere((p) => p.productid == "HC7"), 
        Data.allProducts.firstWhere((p) => p.productid == "HC7"), 
        Data.allProducts.firstWhere((p) => p.productid == "DS21"), 
        Data.allProducts.firstWhere((p) => p.productid == "DS21"), 
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
      cardImage:"assets/images/cookies.jpg",
      subTitle: "Hazelnut Coffee + Delicious Cookies",
      fullDescription:
         "Fuel for the midnight achievers. A warm, comforting Hazelnut Coffee to keep you focused during long study sessions, paired perfectly with our signature thick cookie stuffed with rich Nutella chocolate. The ultimate sweet companion to keep you going.",
      offerPrice: 110.0,
      estimatedPrepTimeMinutes: 10,
      calories: 440,
      rating: 4.8,
      reviewCount: 480,
      isLimitedTime: true,
      includedProducts: [
        Data.allProducts.firstWhere((p) => p.productid == "IC10"),
        Data.allProducts.firstWhere((p) => p.productid == "DS27"),
      ],
      customizations: [
        OfferCustomization(title: "Milk Type", options: milkOpts),
        OfferCustomization(
            title: "Extra Dipping",
            options: ["Extra Cheese", "Jalapeños", "Sour Cream"]),
      ],
    ),
  ];

  Map<String, dynamic> toJson() => {
      "id": id,
      "title": title,
      "subTitle": subTitle,
      "offerPrice": offerPrice,
      "estimatedPrepTimeMinutes": estimatedPrepTimeMinutes,
      "calories": calories,
      "rating": rating,
      "reviewCount": reviewCount,
      "isLimitedTime": isLimitedTime,
      "includedProductsIds": includedProducts.map((p) => p.productid).toList(),
      "userId": FirebaseAuth.instance.currentUser?.uid, 
    };
}
