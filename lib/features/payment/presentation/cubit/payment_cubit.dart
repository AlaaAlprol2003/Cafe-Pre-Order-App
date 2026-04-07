import 'package:dash_cup/core/models/Graduation_Project_Data.dart';
import 'package:dash_cup/core/models/graduation_project_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial()) {
    calculateSubtotalPrice(cartProducts: Data.hotCoffee);
  }

  int currentIndex = 1;
  List<String> items = ["1", "2", "3", "4", "5"];
  String currentItem = "2";
  int currentPaymentMethod = 0;
  double subtotalValue = 0.0;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  double userPointsBalance = 6000.0;
  double pointExchangeRate = 0.10;
  double remainingPoints = 0.0;
  double? distanceInKm;
  final double cafeLat = 30.7876;
  final double cafeLng = 30.9935;

  void toggle({required int selectedIndex}) {
    currentIndex = selectedIndex;
    emit(ChangeIndexState());
  }

  void changeCurrentItem({required String selectedItem}) {
    currentItem = selectedItem;
    emit(ChangeItemState());
  }

  void changePaymentMethod({required int selectedMethod}) {
    currentPaymentMethod = selectedMethod;
    emit(ChangePaymentMethod());
  }

  void calculateSubtotalPrice({required List<Products> cartProducts}) {
    subtotalValue = 0.0;
    for (int i = 0; i < cartProducts.length; i++) {
      subtotalValue += cartProducts[i].price;
    }
    emit(SubtotalAmountState(subtotal: subtotalValue));
  }

  void updateCreditCardModel(CreditCardModel model) {
    cardNumber = model.cardNumber;
    expiryDate = model.expiryDate;
    cardHolderName = model.cardHolderName;
    cvvCode = model.cvvCode;
    isCvvFocused = model.isCvvFocused;
    emit(CreditCardDataChangedState());
  }

  bool hasEnoughPoints(double totalAmount) {
    double pointsInCurrency = userPointsBalance * pointExchangeRate;
    return pointsInCurrency >= totalAmount;
  }

  void deductPoints(double totalAmount) {
    double pointsConsumed = totalAmount / pointExchangeRate;

    remainingPoints = userPointsBalance - pointsConsumed;

    userPointsBalance = remainingPoints;

    emit(PointsDeductedState());
  }

  Future<void> calculateDistance() async {
    emit(LocationLoadingState());
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationErrorState(message: "Location permissions are denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationErrorState(
            message: "Location permissions are permanently denied"));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double meters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        cafeLat,
        cafeLng,
      );

      distanceInKm = meters / 1000;

      emit(LocationSuccessState(distanceInKm!));
    } catch (e) {
      emit(
          LocationErrorState(message: "Something went wrong: ${e.toString()}"));
    }
  }

  Future<void> openExternalMap() async {
    final Uri googleMapsUrl =
        Uri.parse("google.navigation:q=$cafeLat,$cafeLng");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      await launchUrl(Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$cafeLat,$cafeLng"));
    }
  }
}

class PaymentState {}

class PaymentInitial extends PaymentState {}

class ChangeIndexState extends PaymentState {}

class ChangeItemState extends PaymentState {}

class ChangePaymentMethod extends PaymentState {}

class SubtotalAmountState extends PaymentState {
  double subtotal;
  SubtotalAmountState({required this.subtotal});
}

class CreditCardDataChangedState extends PaymentState {}

class PointsDeductedState extends PaymentState {}

class LocationLoadingState extends PaymentState {}

class LocationSuccessState extends PaymentState {
  final double distance;
  LocationSuccessState(this.distance);
}

class LocationErrorState extends PaymentState {
  final String? message;
  LocationErrorState({this.message});
}
