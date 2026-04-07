import 'package:dash_cup/core/resources/assets_manager.dart';

class PaymentMethod {
  int index;
  String title;

  String imagePath;

  PaymentMethod(
      {required this.index, required this.title, required this.imagePath});

  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(
        index: 0, title: "Credit Card", imagePath: ImageAssets.visaLogo),
    PaymentMethod(
        index: 1, title: "Fawry Pay", imagePath: ImageAssets.fawryLogo),
    PaymentMethod(
        index: 2, title: "Vodafone Cash", imagePath: ImageAssets.vodafoneLogo),
    PaymentMethod(
        index: 3,
        title: "Dash Points (Available: 120)",
        imagePath: ImageAssets.coinsLogo)
  ];
}
