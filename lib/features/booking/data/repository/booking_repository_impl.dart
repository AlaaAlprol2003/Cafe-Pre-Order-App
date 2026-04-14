import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/booking_entity.dart';
import '../../domain/repository/booking_repo.dart';
import '../datasource/booking_remote_datasource.dart';
import '../model/booking_model.dart';

@LazySingleton(as: BookingRepo)
class BookingRepositoryImpl implements BookingRepo {
  final BookingRemoteDataSource remote;

  BookingRepositoryImpl(this.remote);

  @override
  Future<void> addBooking(BookingEntity booking) {
    return remote.addBooking(BookingModel(
      name: booking.name,
      guests: booking.guests,
      tableType: booking.tableType,
      date: booking.date,
      time: booking.time,
      occasion: booking.occasion,
      price: booking.price, id: FirebaseAuth.instance.currentUser!.uid,
    ));
  }

  @override
  Stream<List<BookingEntity>> getBookings() {
    return remote.getBookings();
  }
  @override
  Future<void> deleteBooking(String id) {
    return remote.deleteBooking(id);
  }
}