import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateOrderQuantityUseCase {
  OrderRepository orderRepository;
  UpdateOrderQuantityUseCase({required this.orderRepository});

  Future<Either<Failure, void>> call(
      {required String orderId, required int newQuantity}) {
    return orderRepository.updateOrderQuantity(
        orderId: orderId, newQuantity: newQuantity);
  }
}
