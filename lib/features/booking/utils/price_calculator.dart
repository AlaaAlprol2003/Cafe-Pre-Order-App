class PriceCalculator {
  static double calculate(int guests, String occasion) {

    double basePrice = 0;

    switch (occasion) {
      case "Birthday":
        basePrice = 10;
        break;

      case "Engagement":
        basePrice = 20;
        break;

      case "Wedding":
        basePrice = 50;
        break;

      default:
        basePrice = 5;
    }

    return guests * basePrice;
  }
}