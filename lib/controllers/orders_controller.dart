import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';

class OrdersController extends GetxController {
  var orders = [];

  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['seller_id'] == FirebaseAuth.instance.currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeOrder({title, status, docId}) async {
    var store = fireStore.collection(ordersCollection).doc(docId);

    store.set({title: status}, SetOptions(merge: true));
  }
}
