import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../model/booking_model.dart';

@lazySingleton
class BookingRemoteDataSource {
  final FirebaseFirestore firestore;

  BookingRemoteDataSource(this.firestore);

  Future<void> addBooking(BookingModel booking) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) throw Exception("User not logged in");

    await firestore
        .collection("users")
        .doc(user.uid)
        .collection("bookings")
        .add(booking.toMap());
  }

  Stream<List<BookingModel>> getBookings() {
    final user = FirebaseAuth.instance.currentUser;

    return firestore
        .collection("users")
        .doc(user!.uid)
        .collection("bookings")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BookingModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<void> deleteBooking(String id) async {
    final user = FirebaseAuth.instance.currentUser;

    await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("bookings")
        .doc(id)
        .delete();
  }
}