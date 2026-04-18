import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitialState());

  int quantity = 1;
  String size = "M";
  String sugar = "Normal";
  String milk = "No Milk";
  List<String> availableSizes = ["S", "M", "L"];
  List<String> sugarLevels = ["No Sugar", "Low", "Normal", "Extra"];
  List<String> milkTypes = ["No Milk", "Regular", "Almond", "Soy"];
  void increaseQuantity() {
    quantity++;
    emit(IncreaseQuantityState());
  }

  void decreaseQuantity() {
    if (quantity == 1) return;
    quantity--;
    emit(DecreaseQuantityState());
  }

  void chooseSizeLevel({required String selectedSize}) {
    size = selectedSize;
    emit(SelectSizeState());
  }

  void chooseSugerLevel({required String selectedSugarLevel}) {
    sugar = selectedSugarLevel;
    emit(SelectSugarState());
  }

  void chooseMilkType({required String selectedMilkType}) {
    milk = selectedMilkType;
    emit(SelectMilkState());
  }
}

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class IncreaseQuantityState extends ProductDetailsState {}

class DecreaseQuantityState extends ProductDetailsState {}

class SelectSizeState extends ProductDetailsState {}

class SelectSugarState extends ProductDetailsState {}

class SelectMilkState extends ProductDetailsState {}
