import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/views/auth_screen/Admin_verification_screen.dart';
import 'package:fresh_om_seller/views/home_screen/main_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  @override
  var loading = false.obs;
  var emailController = TextEditingController();

  var passwordController = TextEditingController();
  var profileController = Get.put(ProfileController());

  //login
  Future<UserCredential?> signInMethod() async {
    UserCredential? userCredential;

    try {
      userCredential = await  FirebaseAuth.instance.signInWithEmailAndPassword(
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
      userCredential = await  FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      await  FirebaseAuth.instance.sendPasswordResetEmail(email: emailController);
      VxToast.show(context,
          msg: "A password reset link have been sent to this email");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  // storing user data
  storeUserData({name, password, email, address}) async {
    DocumentReference store = fireStore
        .collection(sellerCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid);
    store.set({
      'register_date': DateTime.now(),
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': FirebaseAuth.instance.currentUser!.uid,
      'added_veg_count': '',
      'added_fruit_count': '',
      'verified': false,
      "address": address
    });
  }

//SignOut method
  signOutMethod(context) async {
    try {
      await  FirebaseAuth.instance.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  verifyEmail() async {
    await  FirebaseAuth.instance.currentUser!.sendEmailVerification();
    Get.snackbar('email', 'send');
  }

  //check the user is in sellerCollection

  checkUserInCollection(context) async {
    int checkUser = 0;
    var collection = fireStore.collection(sellerCollection);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      if (data['email'] == FirebaseAuth.instance.currentUser!.email) {
        checkUser = 1;
      }
    }

    if (checkUser == 0) {
      FirebaseAuth.instance.signOut();
      Get.snackbar('Error', "your are not a user");
      emailController.clear();
      passwordController.clear();
      return;
    } else {
      checkIsVerified(context);
    }
  }

  //checking if user verification is done
  checkIsVerified(context) async {
    var collection = fireStore
        .collection(sellerCollection)
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();

      if (data['verified'] == true) {
        VxToast.show(context, msg: loggedIn);
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool('isLogged', true);
        sharedPref.setBool('isVerified', true);
        await profileController.profileDetails();
        Get.offAll(() => const MainHome());
        return;
      } else {
        var sharedPref = await SharedPreferences.getInstance();
        sharedPref.setBool('isLogged', true); //change to false if error occure
        sharedPref.setBool('isVerified', false);
        Get.offAll(() => const VerificationScreen());
      }
    }
  }
}
