import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/app_exceptions.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:dash_cup/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class AuthRepositoriesImpl implements AuthRepository {
  AuthRemoteDataSsource remoteDataSsource;
  AuthRepositoriesImpl({required this.remoteDataSsource});

  @override
  Future<Either<Failure, UserCredential>> register({
    required RegisterRequest request,
  }) async {
    try {
      var credential = await remoteDataSsource.register(request: request);
      return Right(credential);
    } on RemoteException catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> addUserToFirestore({
    required UserModel user,
  }) async {
    try {
      await remoteDataSsource.addUserToFirestore(user: user);
      return Right(null);
    } on RemoteException catch (_) {
      return Left(Failure(message: "Failed to save user"));
    }
  }

  @override
  Future<Either<Failure, void>> login({required LoginRequest request}) async {
    try {
      await remoteDataSsource.login(request: request);
      return Right(null);
    } on RemoteException catch (exception) {
      return Left(Failure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserFromFirestore({
    required String userId,
  }) async {
    try {
      final user = await remoteDataSsource.getUserFromFirestore(userId: userId);
      return Right(user);
    } on RemoteException catch (_) {
      return Left(Failure(message: "Failed to get user"));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) async {
    try {
      await remoteDataSsource.resetPassword(email: email);
      return Right(null);
    } on RemoteException catch (_) {
      return Left(Failure(message: "Failed to send link"));
    }
  }
}
