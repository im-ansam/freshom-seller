import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_om_seller/const/firebase_const.dart';

class FireStoreServices {
  static getUser(uid) {
    return fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  static getProfile(uid) {
    return fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(docId) {
    return fireStore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  static getAllMessages() {
    return fireStore
        .collection(chatsCollection)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getOrders(uid) {
    return fireStore
        .collection(ordersCollection)
        .where('sellers', arrayContains: uid)
        .snapshots();
  }

  static getVegetables(uid) {
    return fireStore
        .collection(vegetableCollection)
        .where('seller_id', isEqualTo: uid)
        .snapshots();
  }

  static getFruits(uid) {
    return fireStore
        .collection(fruitsCollection)
        .where('seller_id', isEqualTo: uid)
        .snapshots();
  }

  static getPopularVeg(uid) {
    return fireStore
        .collection(vegetableCollection)
        .where('seller_id', isEqualTo: uid)
        .where('v_isPopular', isEqualTo: true)
        .snapshots();
  }

  static getPopularFruit(uid) {
    return fireStore
        .collection(fruitsCollection)
        .where('seller_id', isEqualTo: uid)
        .where('f_isPopular', isEqualTo: true)
        .snapshots();
  }

  static getCount(uid) async {
    var res = await Future.wait([
      fireStore
          .collection(vegetableCollection)
          .where('seller_id', isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(fruitsCollection)
          .where('seller_id', isEqualTo: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(ordersCollection)
          .where('sellers', arrayContains: uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      fireStore
          .collection(chatsCollection)
          .where('toId', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }
}
