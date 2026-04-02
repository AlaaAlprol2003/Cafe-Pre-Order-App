import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../model/booking_model.dart';

@lazySingleton
class BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSource(this.firestore);

  Future<void> addBooking(BookingModel booking) async {
    await firestore.collection("bookings").add(booking.toMap());
  }

  Stream<List<BookingModel>> getBookings() {
    return firestore.collection("bookings").snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => BookingModel.fromMap(doc.data()))
          .toList();
    });
  }
}