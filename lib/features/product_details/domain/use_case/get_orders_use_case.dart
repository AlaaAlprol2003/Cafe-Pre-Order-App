import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetOrdersFromFirestoreUseCase {
  final OrderRepository orderRepository;

  GetOrdersFromFirestoreUseCase({required this.orderRepository});

  Stream<List<OrderModel>> call() {
    return orderRepository.getOrdersFromFirestore();
  }
}
