import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/app_exceptions.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/product_details/data/data_source/order_remote_data_source.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';
@LazySingleton(as:OrderRepository )
class OrderRepositoryImpl implements OrderRepository {
  OrderRemoteDataSource orderRemoteDataSource;
  OrderRepositoryImpl({required this.orderRemoteDataSource});
  @override
  Future<Either<Failure, void>> addOrderToFirestore(
      {required OrderModel order}) async {
    try {
      await orderRemoteDataSource.addOrderToFirestore(order: order);
      return Right(null);
    } on RemoteException catch (_) {
      return Left(Failure(message: "Something went Wrong"));
    }
  }

  @override
  Stream<List<OrderModel>> getOrdersFromFirestore() {
    return orderRemoteDataSource.getOrdersFromFirestore();
  }

  @override
  Future<Either<Failure, void>> deleteOrderFromFirestore(
      {required String orderId}) async {
    try {
      await orderRemoteDataSource.deleteOrderFromFirestore(orderId: orderId);
      return Right(null);
    } on RemoteException catch (ex) {
      return Left(Failure(message: ex.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderQuantity(
      {required String orderId, required int newQuantity}) async {
    try {
      await orderRemoteDataSource.deleteOrderFromFirestore(orderId: orderId);
      return Right(null);
    } on RemoteException catch (ex) {
      return Left(Failure(message: ex.message));
    }
  }
}
