import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  BookingModel({
    required String id,
    required String name,
    required int guests,
    required String tableType,
    required String date,
    required String time,
    required String occasion,
    required double price,
  }) : super(
    id: id, // 🔥 مهم
    name: name,
    guests: guests,
    tableType: tableType,
    date: date,
    time: time,
    occasion: occasion,
    price: price,
  );

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

  factory BookingModel.fromMap(Map<String, dynamic> map, String id) {
    return BookingModel(
      id: id,
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