import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';

abstract class OrderRemoteDataSource {
  Future<void> addOrderToFirestore({required OrderModel order});
  Stream<List<OrderModel>> getOrdersFromFirestore();
  Future<void> deleteOrderFromFirestore({required String orderId});
  Future<void> updateOrderQuantity(
      {required String orderId, required int newQuantity});
  Future<void> deleteCartItems({required String uId});
  Future<void> addBundleToFirestore({required OfferModel offer});
}
