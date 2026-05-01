import 'package:dash_cup/core/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> addOrderToFirestore({required OrderModel order});
  Stream<List<OrderModel>> getOrdersFromFirestore();
  Future<void> deleteOrderFromFirestore({required String orderId});
  Future<void> updateOrderQuantity(
      {required String orderId, required int newQuantity});
      Future<void> deleteCartItems({required String uId});
}
