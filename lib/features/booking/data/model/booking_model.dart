import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required super.name,
    required super.guests,
    required super.tableType,
    required super.date,
    required super.time,
    required super.occasion,
    required super.price,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "guests": guests,
      "tableType": tableType,
      "date": date,
      "time": time,
      "occasion": occasion,
      "price": price,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      name: map["name"],
      guests: map["guests"],
      tableType: map["tableType"],
      date: map["date"],
      time: map["time"],
      occasion: map["occasion"],
      price: map["price"],
    );
  }
}