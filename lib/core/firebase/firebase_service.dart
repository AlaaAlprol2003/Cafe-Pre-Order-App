import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/booking/domain/entities/booking.dart';
class FirebaseService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveReservation(Reservation reservation) async {

    await firestore
        .collection("reservations")
        .add(reservation.toMap());

  }

}