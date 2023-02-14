import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/home_screen/main_home.dart';
import 'package:lottie/lottie.dart';

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
                      Lottie.network(
                          "https://assets1.lottiefiles.com/private_files/lf30_oz2evqgk.json"),
                      Dimensions.height10.heightBox,
                      "Huray.. your account is verified you can enter now."
                          .text
                          .size(Dimensions.fontSize20)
                          .bold
                          .color(niceDarkViolet)
                          .make()
                          .paddingOnly(left: Dimensions.width20),
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
                          .onTap(() {
                        Get.offAll(() => const MainHome());
                      })
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Lottie.network(
                          "https://assets5.lottiefiles.com/packages/lf20_przr7mrj.json"),
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
