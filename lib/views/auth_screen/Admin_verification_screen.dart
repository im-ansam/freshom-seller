import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/home_screen/main_home.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/reusable_big_text.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue1,
      body: StreamBuilder(
        stream:
            FireStoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: nicePurple,
              ),
            );
          } else {
            var data = snapshot.data!.docs[0];

            bool verified = data['verified'];
            return verified == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Lottie.asset(verifiedGif),
                      ),
                      Dimensions.height10.heightBox,
                      BigText(
                        text:
                            "Huray.. your account is verified you can enter now.",
                        fontWeight: FontWeight.bold,
                        size: Dimensions.fontSize20,
                        color: niceDarkViolet,
                      ).paddingOnly(left: Dimensions.width20),
                      Dimensions.height30.heightBox,
                      headingText(
                              text: "Proceed",
                              color: Colors.white,
                              fontSize: Dimensions.fontSize20)
                          .box
                          .roundedSM
                          .alignCenter
                          .width(Dimensions.height80 * 2)
                          .height(Dimensions.height50)
                          .color(mainGreen)
                          .shadowSm
                          .make()
                          .onTap(() async {
                        var sharedPref = await SharedPreferences.getInstance();
                        sharedPref.setBool('isVerified', true);
                        Get.offAll(() => const MainHome());
                      })
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.asset(verifyPendingGif),
                      Dimensions.height20.heightBox,
                      "Your phiysical verification is in progress.."
                          .text
                          .size(Dimensions.fontSize20)
                          .bold
                          .color(priceColor)
                          .make(),
                      Dimensions.height20.heightBox,
                      "You will be able to enter this app only when\nadmin "
                              "visits your place and verify!"
                          .text
                          .size(Dimensions.fontSize18)
                          .bold
                          .color(nicePurple)
                          .make(),
                      Dimensions.height10.heightBox,
                      "(Check your email and verify it also)"
                          .text
                          .size(Dimensions.fontSize15)
                          .bold
                          .color(niceViolet)
                          .make(),
                    ],
                  ).paddingOnly(left: Dimensions.width10);
          }
        },
      ),
    );
  }
}
