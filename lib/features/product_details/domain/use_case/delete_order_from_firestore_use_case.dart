import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteOrderFromFirestoreUseCase {
  OrderRepository orderRepository;
  DeleteOrderFromFirestoreUseCase({required this.orderRepository});

  Future<Either<Failure, void>> call({required String orderId}) {
    return orderRepository.deleteOrderFromFirestore(orderId: orderId);
  }
}
