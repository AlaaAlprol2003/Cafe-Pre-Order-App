import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@singleton
class LoginUseCase {
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Failure, void>> call({required LoginRequest request}) {
    return authRepository.login(request: request);
  }
}
