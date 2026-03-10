import '../../../../core/firebase/firebase_service.dart';
import '../../domain/entities/booking.dart';

class ReservationRepository {

  final FirebaseService firebaseService = FirebaseService();

  Future<void> saveReservation(Reservation reservation) async {

    await firebaseService.saveReservation(reservation);

  }
}