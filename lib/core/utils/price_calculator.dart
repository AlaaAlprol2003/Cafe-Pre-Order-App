class PriceCalculator {
  static double calculate(int guests, String occasion) {
    double base = guests * 50;

    switch (occasion) {
      case "Birthday":
        return base + 200;
      case "Engagement":
        return base + 500;
      case "Graduation":
        return base + 300;
      case "Football match":
        return base + 150;
      case "Meeting":
         return base + 800;
      default:
        return base + 100;
    }
  }
}