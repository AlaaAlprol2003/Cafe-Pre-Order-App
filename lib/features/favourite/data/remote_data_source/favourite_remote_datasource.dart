import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouriteRemoteDataSource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addFavourite(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("favourites")
        .doc(productId)
        .set({"productId": productId});
  }

  Future<void> removeFavourite(String productId) async {
    final user = FirebaseAuth.instance.currentUser;

    await firestore
        .collection("users")
        .doc(user!.uid)
        .collection("favourites")
        .doc(productId)
        .delete();
  }

  Stream<List<String>> getFavourites() {
    final user = FirebaseAuth.instance.currentUser;

    return firestore
        .collection("users")
        .doc(user!.uid)
        .collection("favourites")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => e["productId"] as String).toList();
    });
  }
}