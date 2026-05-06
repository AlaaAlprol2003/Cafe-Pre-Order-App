import 'dart:async';

import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/product_details/domain/use_case/add_bundle_to_firestore.dart';
import 'package:dash_cup/features/product_details/domain/use_case/add_order_to_firestore_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/delete_cart_items_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/delete_order_from_firestore_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/get_orders_use_case.dart';
import 'package:dash_cup/features/product_details/domain/use_case/update_order_quantity_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  AddOrderToFirestoreUseCase addOrderToFirestoreUseCase;
  GetOrdersFromFirestoreUseCase getOrdersFromFirestoreUseCase;
  DeleteOrderFromFirestoreUseCase deleteOrderFromFirestoreUseCase;
  UpdateOrderQuantityUseCase updateOrderQuantityUseCase;
  DeleteCartItemsUseCase deleteCartItemsUseCase;
  AddBundleToFirestoreUseCase addBundleToFirestoreUseCase;
  ProductDetailsCubit({
    required this.addOrderToFirestoreUseCase,
    required this.getOrdersFromFirestoreUseCase,
    required this.deleteOrderFromFirestoreUseCase,
    required this.updateOrderQuantityUseCase,
    required this.deleteCartItemsUseCase,
    required this.addBundleToFirestoreUseCase,
  }) : super(ProductDetailsInitialState());

  int quantity = 1;
  String size = "M";
  String sugar = "Normal";
  String milk = "No Milk";
  List<String> availableSizes = ["S", "M", "L"];
  List<String> sugarLevels = ["No Sugar", "Low", "Normal", "Extra"];
  List<String> milkTypes = [
    "No Milk",
    "Regular (+10)",
    "Almond (+20)",
    "Soy (+30)"
  ];
  List<OrderModel> orders = [];
  StreamSubscription<List<OrderModel>>? ordersSubscription;
  String? loadingProductId;
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
    loadingProductId = order.product.productid;
    emit(AddOrderToFirestoreLoading());
    final result = await addOrderToFirestoreUseCase(order: order);
    await Future.delayed(const Duration(milliseconds: 500));
    result.fold(ifLeft: (failure) {
      loadingProductId = null;
      emit(AddOrderToFirestoreFailure(message: failure.message));
    }, ifRight: (_) {
      loadingProductId = null;
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

  void updateOrderQuantity(
      {required String orderId, required int newQuantity}) async {
    final index = orders.indexWhere((e) => e.orderId == orderId);
    if (index != -1) {
      orders[index].quantity = newQuantity;
      emit(GetOrdersSuccess(orders: List.from(orders)));

      final result = await updateOrderQuantityUseCase(
        orderId: orderId,
        newQuantity: newQuantity,
      );

      result.fold(
        ifLeft: (failure) {
          emit(GetOrdersFailure(message: failure.message));
        },
        ifRight: (_) {},
      );
    }
  }

  Future<void> clearCart({required String uId}) async {
    emit(DeleteCartLoading());

    final result = await deleteCartItemsUseCase.call(uId: uId);

    result.fold(
      ifLeft: (failure) {
        emit(DeleteCartFailure(message: failure.message));
      },
      ifRight: (_) {
        emit(DeleteCartSuccess());
      },
    );
  }

  void addBundleToFirestore({required OfferModel offer})async{
emit(AddBundleToFirestoreLoading());
  
  final result = await addBundleToFirestoreUseCase(offer: offer); 
  
  result.fold(
    ifLeft: (failure) {
      emit(AddBundleToFirestoreFailure(message: failure.message));
    }, 
    ifRight: (_) {
      emit(AddBundleToFirestoreSuccess());
    }
  );
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

class DeleteCartLoading extends ProductDetailsState {}

class DeleteCartSuccess extends ProductDetailsState {}

class DeleteCartFailure extends ProductDetailsState {
  String message;
  DeleteCartFailure({required this.message});
}

class AddBundleToFirestoreLoading extends ProductDetailsState {}

class AddBundleToFirestoreFailure extends ProductDetailsState {
  String message;
  AddBundleToFirestoreFailure({required this.message});
}

class AddBundleToFirestoreSuccess extends ProductDetailsState {}
