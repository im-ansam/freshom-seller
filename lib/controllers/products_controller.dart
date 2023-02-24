import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/home_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart' as intl;

class ProductsController extends GetxController {
  var time = intl.DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  var productImage = "".obs;
  var productImgLink = "";
  var isLoading = false.obs;
  //text field controller for fruits
  var fNameController = TextEditingController();
  var fPriceController = TextEditingController();
  var fQtyController = TextEditingController();
  var fDescController = TextEditingController();

  //text field controller for veg
  var vNameController = TextEditingController();
  var vPriceController = TextEditingController();
  var vQtyController = TextEditingController();
  var vDescController = TextEditingController();

  pickImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) return;
      productImage.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProductImage() async {
    var fileName = basename(productImage.value);
    var destination =
        'productsImages/sellers/${FirebaseAuth.instance.currentUser?.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(productImage.value));

    productImgLink = await ref.getDownloadURL();
  }

  //upload fruits
  uploadFruits({imageUrl, context}) async {
    var store = fireStore.collection(fruitsCollection).doc();

    store.set({
      'f_id': store.id, //new added change
      'f_desc': fDescController.text,
      'f_image': imageUrl,
      'f_name': fNameController.text,
      'f_price': fPriceController.text,
      'f_qty': int.parse(fQtyController.text), //new added change
      'f_uploaded_date': time,
      'currentTimeStamp': DateTime.now(),
      'seller_name': Get.find<HomeController>().username,
      'seller_id': FirebaseAuth.instance.currentUser!.uid
    });
    isLoading(false);
    VxToast.show(context, msg: "Product Uploaded");
  }

  //upload vegetables
  uploadVegetables({imageUrl, context}) async {
    var store = fireStore.collection(vegetableCollection).doc();

    store.set({
      'v_id': store.id, //new added change
      'v_desc': vDescController.text,
      'v_image': imageUrl,
      'v_name': vNameController.text,
      'v_price': vPriceController.text,
      'v_qty': int.parse(vQtyController.text), //new added change
      'v_uploaded_date': time,
      'currentTimeStamp': DateTime.now(),
      'seller_name': Get.find<HomeController>().username,
      'seller_id': FirebaseAuth.instance.currentUser!.uid
    });
    isLoading(false);
    VxToast.show(context, msg: "Product Uploaded");
  }

  removeVegetables(docId) async {
    await fireStore.collection(vegetableCollection).doc(docId).delete();
  }

  removeFruits(docId) async {
    await fireStore.collection(fruitsCollection).doc(docId).delete();
  }

  removeFruitsNotification(docId) async {
    await fireStore.collection(deletedFruits).doc(docId).delete();
  }

  removeVegNotification(docId) async {
    await fireStore.collection(deletedVeg).doc(docId).delete();
  }
}
