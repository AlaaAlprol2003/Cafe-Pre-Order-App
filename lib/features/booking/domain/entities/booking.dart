class Reservation {
  final String name;
  final int guests;
  final String tableType;
  final DateTime dateTime;
  final String occasion;
  final double price;

  Reservation({
    required this.name,
    required this.guests,
    required this.tableType,
    required this.dateTime,
    required this.occasion,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'guests': guests,
      'tableType': tableType,
      'dateTime': dateTime.toString(),
      'occasion': occasion,
      'price': price,
    };
  }
}