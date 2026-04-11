abstract class RegexConstants {
  static RegExp email = RegExp(
   r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  static RegExp phone = RegExp(r'^01[015][0-9]{8}$');
  static RegExp password = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=(?:.*[0-9]){5,})(?=.*[!@#$%^&*(),.?":{}|<>])',
  );
}

// String generateMenuSummary() {
//     return """
//   --- DASH CUP OFFICIAL MENU DATA ---
  
//   1. Botanicals (Tea & Herbal):
//      - Red Tea (15.0 EGP), Green Tea (20.0 EGP), Karak Tea (25.0 EGP), Mint Green Tea (22.0 EGP), Chamomile Tea (20.0 EGP).
//      - Karkade (18.0 EGP), Anise (18.0 EGP), Cinnamon & Milk (22.0 EGP), Mint Red Tea (18.0 EGP), Helba (18.0 EGP).

//   2. Hot Coffee:
//      - Espresso: Single (35.0 EGP), Double (45.0 EGP).
//      - Americano (40.0 EGP), Turkish Coffee (30.0 EGP), French Coffee (42.0 EGP).
//      - Cappuccino (50.0 EGP), Latte (55.0 EGP), Mocha (60.0 EGP), Spanish Latte (65.0 EGP), White Mocha (65.0 EGP).

//   3. Iced Coffee:
//      - Classic Ice Coffee (40.0 EGP), Iced Americano (45.0 EGP), Iced Latte (55.0 EGP), Iced Cappuccino (55.0 EGP).
//      - Iced Mocha (60.0 EGP), Iced Spanish Latte (65.0 EGP), Iced Caramel Latte (65.0 EGP), Iced Vanilla Latte (65.0 EGP), Iced White Mocha (70.0 EGP), Iced Hazelnut Latte (65.0 EGP).

//   4. Dessert & Snacks:
//      - Waffles: Classic (45.0), Chocolate (55.0), Nutella (60.0), Lotus (60.0), Oreo (65.0).
//      - Pancakes: Classic (45.0), Chocolate (55.0), Nutella (60.0), Lotus (60.0).
//      - Cakes: Chocolate Molten Cake (70.0), Lotus Molten Cake (75.0), Cheese Cake (70.0), Lotus Cheesecake (75.0).
//      - Ice Cream (Scoop): Chocolate, Vanilla (35.0), Mango, Strawberry, Blueberry (40.0).
//      - Others: Donut (25.0), Cinnamon Roll (30.0), Nacho Cheese (45.0), Chips (20.0), French Fries (35.0).

//   5. Light Bites (Food):
//      - Chicken Panini (75.0 EGP), Tuna Melt Sandwich (70.0 EGP), Turkey and Cheese Croissant (80.0 EGP).
//      - Chicken Caesar Wrap (75.0 EGP), Club Sandwich (85.0 EGP), Mini Chicken Quesadilla (70.0 EGP).
//      - Snacks: Fries Basket (40.0), Mozzarella Sticks (55.0), Chicken Nuggets (50.0), Garlic Bread with Cheese (45.0).

//   6. Soft Drinks:
//      - Coca-Cola, Diet Coke, Pepsi, 7UP, Mirinda Orange, Fanta, Sprite (All 25.0 EGP).
//      - Schweppes (30.0 EGP), Red Bull (45.0 EGP), Mineral Water (15.0 EGP).

//   7. Fresh Juices:
//      - Orange, Guava, Watermelon (35.0 EGP).
//      - Mango, Strawberry, Pineapple, Pomegranate (40.0 - 45.0 EGP).
//      - Lemon Mint (30.0 EGP), Mixed Fruit (50.0 EGP).

//   8. Shakes & Co (Smoothies & Milkshakes):
//      - Smoothies: Strawberry, Mango (55.0), Banana (50.0), Mixed Berry, Avocado (60.0).
//      - Milkshakes: Vanilla (55.0), Chocolate, Strawberry (60.0), Oreo (65.0), Lotus (70.0).

//   --- Important Notes ---
//   - Use these EXACT prices from the data.
//   - If a user mentions "Sleepy", recommend Espresso or Double Espresso.
//   - If a user mentions "Chill", recommend Chamomile or Anise.
//   - If a user mentions "Sweet", recommend Nutella Waffle or Molten Cake.
//   """;
//   }

//  Future<String> getWelcomeGreeting() async {
//     try {
//       final response = await _textModel.generateContent([
//         Content.text(
//             "You are 'Dashy', a cool and professional barista at 'Dash Cup' cafe. Give a very short, welcoming, and catchy English greeting (maximum 8 words) for a customer who just opened the app. Make it sound inviting and stylish.")
//       ]);
//       return response.text ?? "Welcome to Dash Cup! Ready for some coffee?";
//     } catch (e) {
//       return "Welcome to Dash Cup! What can I brew for you today?";
//     }
//   }