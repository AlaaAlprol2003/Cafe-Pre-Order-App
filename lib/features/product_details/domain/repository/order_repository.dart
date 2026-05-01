import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/core/models/order_model.dart';

abstract class OrderRepository {
  Future<Either<Failure, void>> addOrderToFirestore(
      {required OrderModel order});
  Stream<List<OrderModel>> getOrdersFromFirestore();
  Future<Either<Failure, void>> deleteOrderFromFirestore(
      {required String orderId});
  Future<Either<Failure, void>> updateOrderQuantity(
      {required String orderId, required int newQuantity});
}
