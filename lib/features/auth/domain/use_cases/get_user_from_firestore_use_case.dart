import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@singleton
class GetUserFromfirestoreUseCase {
  AuthRepository authRepository;
  GetUserFromfirestoreUseCase({required this.authRepository});

  Future<Either<Failure, UserModel>> call({required String userId}) {
    return authRepository.getUserFromFirestore(userId: userId);
  }
}
