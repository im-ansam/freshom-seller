import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
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
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: lightBlue1,
      body: StreamBuilder(
        stream:
            FireStoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: mainAppColor,
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
                            "Huray.. your account is verified \nyou can enter now.",
                        fontWeight: FontWeight.bold,
                        size: Dimensions.fontSize20,
                        color: mainAppColor,
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
                          .color(mainAppColor)
                          .shadowSm
                          .make()
                          .onTap(() async {
                        var sharedPref = await SharedPreferences.getInstance();
                        await controller.profileDetails();
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
                      BigText(
                        text: "Your phiysical verification is \nin progress..",
                        fontWeight: FontWeight.w600,
                        color: nicePurple,
                        size: Dimensions.fontSize20,
                      ),
                      Dimensions.height20.heightBox,
                      BigText(
                        text:
                            "You will be able to enter this app only\n whenadmin "
                            "visits your place and verify!",
                        fontWeight: FontWeight.w600,
                        color: mainAppColor,
                        size: Dimensions.fontSize16,
                      ),
                      Dimensions.height10.heightBox,
                      BigText(
                        text: "(Check your email and verify it also)",
                        fontWeight: FontWeight.w600,
                        color: orangeRed,
                        size: Dimensions.fontSize14,
                      ),
                    ],
                  ).paddingOnly(left: Dimensions.width10);
          }
        },
      ),
    );
  }
}
