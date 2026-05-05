import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_cup/core/errors/app_exceptions.dart';
import 'package:dash_cup/core/models/order_model.dart';
import 'package:dash_cup/features/product_details/data/data_source/order_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: OrderRemoteDataSource)
class OrderFirebaseRemoteDataSource implements OrderRemoteDataSource {
  @override
  Future<void> addOrderToFirestore({required OrderModel order}) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> ordersCollection =
          db.collection("Orders");

      DocumentReference<Map<String, dynamic>> orderDocument =
          ordersCollection.doc();
      order.orderId = orderDocument.id;
      order.uId = FirebaseAuth.instance.currentUser!.uid;

      await orderDocument.set(order.toJson());
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }

  @override
  Stream<List<OrderModel>> getOrdersFromFirestore() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return db
        .collection("Orders")
        .where("userId", isEqualTo: currentUserId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderModel.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Future<void> deleteOrderFromFirestore({required String orderId}) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> ordersCollection =
          db.collection("Orders");
      DocumentReference<Map<String, dynamic>> orderDocument =
          ordersCollection.doc(orderId);
      await orderDocument.delete();
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }

  @override
  Future<void> updateOrderQuantity(
      {required String orderId, required int newQuantity}) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;
      CollectionReference<Map<String, dynamic>> ordersCollection =
          db.collection("Orders");
      DocumentReference<Map<String, dynamic>> orderDocument =
          ordersCollection.doc(orderId);
      await orderDocument.update({"quantity": newQuantity});
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }

  @override
  Future<void> deleteCartItems({required String uId}) async {
    try {
      var db = FirebaseFirestore.instance;
      
      var userOrders =
          await db.collection("Orders").where("userId", isEqualTo: uId).get();

      var batch = db.batch(); 
      for (var doc in userOrders.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit(); 
    } catch (exception) {
      throw RemoteException(message: exception.toString());
    }
  }
}
