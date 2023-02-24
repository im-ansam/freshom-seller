import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/const/firebase_const.dart';
import 'package:intl/intl.dart' as intl;

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
        .where('toId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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

  static getNewestVeg(uid) {
    return fireStore
        .collection(vegetableCollection)
        .where('seller_id', isEqualTo: uid)
        .where('v_uploaded_date',
            isEqualTo:
                intl.DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())
        .snapshots();
  }

  static getNewestFruit(uid) {
    return fireStore
        .collection(fruitsCollection)
        .where('seller_id', isEqualTo: uid)
        .where('f_uploaded_date',
            isEqualTo:
                intl.DateFormat('dd-MM-yyyy').format(DateTime.now()).toString())
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
          .where('toId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static getDeletedVeg(uid) {
    return fireStore
        .collection(deletedVeg)
        .where('seller_id', isEqualTo: uid)
        .snapshots();
  }

  static getDeletedFruits(uid) {
    return fireStore
        .collection(deletedFruits)
        .where('seller_id', isEqualTo: uid)
        .snapshots();
  }
}
