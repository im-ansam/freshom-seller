import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  var navIndex = 0.obs;

  var username = '';

  getUserName() async {
    var n = await fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
