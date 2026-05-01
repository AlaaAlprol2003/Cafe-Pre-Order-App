import 'dart:async';

import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/product_details/domain/use_case/add_order_to_firestore_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/delete_order_from_firestore_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/get_orders_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  AddOrderToFirestoreUseCase addOrderToFirestoreUseCase;
  GetOrdersFromFirestoreUseCase getOrdersFromFirestoreUseCase;
  DeleteOrderFromFirestoreUseCase deleteOrderFromFirestoreUseCase;
  ProductDetailsCubit(
      {required this.addOrderToFirestoreUseCase,
      required this.getOrdersFromFirestoreUseCase,
      required this.deleteOrderFromFirestoreUseCase})
      : super(ProductDetailsInitialState());

  int quantity = 1;
  String size = "M";
  String sugar = "Normal";
  String milk = "No Milk";
  List<String> availableSizes = ["S", "M", "L"];
  List<String> sugarLevels = ["No Sugar", "Low", "Normal", "Extra"];
  List<String> milkTypes = ["No Milk", "Regular", "Almond", "Soy"];
  List<OrderModel> orders = [];
  StreamSubscription<List<OrderModel>>? ordersSubscription;
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

  void addOrderToFirestore({required OrderModel order}) async {
    emit(AddOrderToFirestoreLoading());
    final result = await addOrderToFirestoreUseCase(order: order);
    result.fold(ifLeft: (failure) {
      emit(AddOrderToFirestoreFailure(message: failure.message));
    }, ifRight: (_) {
      emit(AddOrderToFirestoreSuccess());
    });
  }

  void getOrders() {
    emit(GetOrdersLoading());
    ordersSubscription?.cancel();

    ordersSubscription = getOrdersFromFirestoreUseCase().listen(
      (ordersList) {
        orders = ordersList;
        emit(GetOrdersSuccess(orders: ordersList));
      },
      onError: (error) {
        emit(GetOrdersFailure(message: error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    ordersSubscription?.cancel();
    return super.close();
  }

  void deleteOrderFromFirestore({required String orderId}) async {
    final result = await deleteOrderFromFirestoreUseCase(orderId: orderId);
    result.fold(ifLeft: (failure) {
      emit(DeleteOrderToFirestoreFailure(message: failure.message));
    }, ifRight: (_) {
      orders.removeWhere((element) => element.orderId == orderId);

      emit(GetOrdersSuccess(orders: List.from(orders)));
    });
  }
}

abstract class ProductDetailsState {}

class ProductDetailsInitialState extends ProductDetailsState {}

class IncreaseQuantityState extends ProductDetailsState {}

class DecreaseQuantityState extends ProductDetailsState {}

class SelectSizeState extends ProductDetailsState {}

class SelectSugarState extends ProductDetailsState {}

class SelectMilkState extends ProductDetailsState {}

class AddOrderToFirestoreLoading extends ProductDetailsState {}

class AddOrderToFirestoreFailure extends ProductDetailsState {
  String message;
  AddOrderToFirestoreFailure({required this.message});
}

class AddOrderToFirestoreSuccess extends ProductDetailsState {}

class GetOrdersLoading extends ProductDetailsState {}

class GetOrdersSuccess extends ProductDetailsState {
  final List<OrderModel> orders;
  GetOrdersSuccess({required this.orders});
}

class GetOrdersFailure extends ProductDetailsState {
  final String message;
  GetOrdersFailure({required this.message});
}

class DeleteOrderToFirestoreLoading extends ProductDetailsState {}

class DeleteOrderToFirestoreFailure extends ProductDetailsState {
  String message;
  DeleteOrderToFirestoreFailure({required this.message});
}

class DeleteOrderToFirestoreSuccess extends ProductDetailsState {}
