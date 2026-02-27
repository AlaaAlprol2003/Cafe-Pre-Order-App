import 'package:dart_either/dart_either.dart';
import 'package:dash_cup/core/errors/failure.dart';
import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> register({
    required RegisterRequest request,
  });
  Future<Either<Failure, void>> addUserToFirestore({required UserModel user});
  Future<Either<Failure, void>> login({required LoginRequest request});
  Future<Either<Failure, UserModel>> getUserFromFirestore({
    required String userId,
  });
  Future<Either<Failure,void>> resetPassword({required String email});
}
