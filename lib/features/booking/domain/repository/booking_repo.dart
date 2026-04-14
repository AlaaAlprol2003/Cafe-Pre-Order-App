import '../entities/booking_entity.dart';

abstract class BookingRepo {
  Future<void> addBooking(BookingEntity booking);
  Stream<List<BookingEntity>> getBookings();
  Future<void> deleteBooking(String id);
}