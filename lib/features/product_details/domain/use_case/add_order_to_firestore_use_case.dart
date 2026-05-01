import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddOrderToFirestoreUseCase {
  OrderRepository orderRepository;
  AddOrderToFirestoreUseCase({required this.orderRepository});

  Future<Either<Failure, void>> call({required OrderModel order}) {
    return orderRepository.addOrderToFirestore(order: order);
  }
}
