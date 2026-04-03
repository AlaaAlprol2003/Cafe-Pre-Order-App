import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/utils/price_calculator.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repository/booking_repo.dart';
import 'booking_state.dart';

@injectable
class BookingCubit extends Cubit<BookingState> {
  final BookingRepo repo;

  BookingCubit(this.repo) : super(BookingInitial());

  int guests = 1;
  String tableType = "Indoor";
  String date = "";
  String time = "";
  String occasion = "Birthday";
  double price = 0;

  void increment() {
    guests++;
    _updatePrice();
  }

  void decrement() {
    if (guests > 1) guests--;
    _updatePrice();
  }

  void setTable(String value) {
    tableType = value;
    emit(BookingUpdated());
  }

  void setDate(String value) {
    date = value;
    emit(BookingUpdated());
  }

  void setTime(String value) {
    time = value;
    emit(BookingUpdated());
  }

  void setOccasion(String value) {
    occasion = value;
    _updatePrice();
  }

  void _updatePrice() {
    price = PriceCalculator.calculate(guests, occasion);
    emit(BookingUpdated());
  }

  Future<void> confirmBooking(String name) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final booking = BookingEntity(
      name: name,
      guests: guests,
      tableType: tableType,
      date: date,
      time: time,
      occasion: occasion,
      price: price, id: user.uid,
    );

    await repo.addBooking(booking);
    reset();


    emit(BookingLoaded());
  }

  Future<void> deleteBooking(String id) async {
    await repo.deleteBooking(id);
  }

  void reset() {
    guests = 1;
    tableType = "Indoor";
    date = "";
    time = "";
    occasion = "Birthday";
    price = 0;

    emit(BookingInitial());
  }
}