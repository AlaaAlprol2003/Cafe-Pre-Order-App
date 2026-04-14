class BookingEntity {
  final String id;

  final String name;
  final int guests;
  final String tableType;
  final String date;
  final String time;
  final String occasion;
  final double price;

  BookingEntity({
    required this.id,
    required this.name,
    required this.guests,
    required this.tableType,
    required this.date,
    required this.time,
    required this.occasion,
    required this.price,
  });
}