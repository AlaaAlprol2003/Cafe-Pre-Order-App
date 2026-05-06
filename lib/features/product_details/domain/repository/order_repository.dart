import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, void>> addOrderToFirestore(
      {required OrderModel order});
  Stream<List<OrderModel>> getOrdersFromFirestore();
  Future<Either<Failure, void>> deleteOrderFromFirestore(
      {required String orderId});
  Future<Either<Failure, void>> updateOrderQuantity(
      {required String orderId, required int newQuantity});
  Future<Either<Failure, void>> deleteCartItems({required String uId});
  Future<Either<Failure, void>> addBundleToFirestore(
      {required OfferModel offer});
}
