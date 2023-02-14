import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;

  var profileImgPath = "".obs;
  var profileImgLink = "";
  //text-field
  var nameController = TextEditingController();
  var newPassController = TextEditingController();
  var oldPassController = TextEditingController();

  changeImg(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImg() async {
    var fileName = basename(profileImgPath.value);
    var destination = 'sellerImages/${currentUser?.uid}/$fileName';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));

    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageUrl}) async {
    var store = fireStore.collection(sellerCollection).doc(currentUser!.uid);
    await store.set({'name': name, 'password': password, 'imageUrl': imageUrl},
        SetOptions(merge: true));

    // isLoading.value = false;
  }

  //update Authentication password
  changeAuthPassword({email, password, newPassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((error) {
      Get.snackbar("Error occurred", error.toString());
    });
  }
}
