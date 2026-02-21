import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_cup/core/errors/app_exceptions.dart';
import 'package:dash_cup/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:dash_cup/features/auth/data/models/login_request.dart';
import 'package:dash_cup/features/auth/data/models/register_request.dart';
import 'package:dash_cup/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRemoteDataSsource)
class AuthFirebaseRemoteDataSource implements AuthRemoteDataSsource {
  @override
  Future<UserCredential> register({required RegisterRequest request}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: request.email,
            password: request.password,
          );

      return credential;
    } catch (exception) {
      if (exception is FirebaseAuthException) {
        throw RemoteException(message: exception.toString());
      }
      throw RemoteException(message: "Failed to register");
    }
  }

  @override
  Future<void> addUserToFirestore({required UserModel user}) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> usersCollection = db.collection(
        "Users",
      );
      DocumentReference<Map<String, dynamic>> userDocument = usersCollection
          .doc(user.id);

      await userDocument.set(user.toJson());
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }

  @override
  Future<void> login({required LoginRequest request}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }

  @override
  Future<UserModel> getUserFromFirestore({required String userId}) async {
    try {
      FirebaseFirestore dataBase = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> userscollection = dataBase
          .collection("Users");
      DocumentReference<Map<String, dynamic>> userDocument = userscollection
          .doc(userId);
      DocumentSnapshot<Map<String, dynamic>> snapshot = await userDocument
          .get();
      var json = snapshot.data();
      return UserModel.fromJson(json!);
    } catch (exception) {
      print(exception);
      throw RemoteException(message: exception.toString());
    }
  }
}
