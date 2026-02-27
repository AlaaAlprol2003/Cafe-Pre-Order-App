import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/auth/domain/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';
@singleton
class ResetPasswordUseCase {
  AuthRepository authRepository;
  ResetPasswordUseCase({required this.authRepository});
  Future<Either<Failure, void>> call({required String email}) {
    return authRepository.resetPassword(email: email);
  }
}
