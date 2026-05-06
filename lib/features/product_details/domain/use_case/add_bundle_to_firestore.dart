import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/main_layout/tabs/home/data/models/offer_model.dart';
import 'package:dash_cup/features/product_details/domain/repository/order_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddBundleToFirestoreUseCase {
  OrderRepository orderRepository;
  AddBundleToFirestoreUseCase({required this.orderRepository});

  Future<Either<Failure, void>> call({required OfferModel offer}) {
    return orderRepository.addBundleToFirestore(offer: offer);
  }
}
