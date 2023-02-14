import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';

class AuthController extends GetxController {
  var loading = false.obs;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  //login
  Future<UserCredential?> signInMethod() async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      loading.value = false;
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return userCredential;
  }

  //signup method

  Future<UserCredential?> signUpMethod({email, password}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await verifyEmail();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.toString());
    }
    return userCredential;
  }

  //reset password

  resetPassword({emailController, context}) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      VxToast.show(context,
          msg: "A password reset link have been sent to this email");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // storing user data
  storeUserData({name, password, email, address}) async {
    DocumentReference store =
        fireStore.collection(sellerCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'added_veg_count': '',
      'added_fruit_count': '',
      'verified': false,
      "address": address
    });
  }

//SignOut method
  signOutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  verifyEmail() async {
    await auth.currentUser!.sendEmailVerification();
    Get.snackbar('email', 'send');
  }
}
