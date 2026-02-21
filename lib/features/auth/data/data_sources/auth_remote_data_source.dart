import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSsource {
  Future<UserCredential> register({required RegisterRequest request});
  Future<void> addUserToFirestore({required UserModel user});
  Future<void> login({required LoginRequest request});
  Future<UserModel> getUserFromFirestore({required String userId});
}
