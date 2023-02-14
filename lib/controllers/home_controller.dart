import 'package:fresh_om_seller/const/const.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserName();
    getUserImage();
  }

  var navIndex = 0.obs;

  var username = '';
  var userImage = '';

  getUserName() async {
    var n = await fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }

  getUserImage() async {
    var img = await fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['imageUrl'];
      }
    });
    userImage = img;
  }
}
