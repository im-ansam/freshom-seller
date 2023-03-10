import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
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
    const ansamNumber = '9061383059';
    const alanNumber = '9961314409';
    const basilNumber = '9207142244';
    const archanaNumber = '8086393456';
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: lightBlue1,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BigText(
            text: contactUs,
            fontWeight: FontWeight.w600,
            size: Dimensions.fontSize12,
            color: Colors.grey[500],
          ),
          5.widthBox,
          const Icon(
            Icons.info_rounded,
            color: mainAppColor,
          ).onTap(() {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    title: const BigText(
                      fontWeight: FontWeight.w600,
                      text: "Call us on mobile",
                      color: nicePurple,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              fontWeight: FontWeight.w600,
                              text: "Ansam -",
                              size: Dimensions.fontSize15,
                              color: fontGrey,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        mainAppColor)),
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      ansamNumber);
                                },
                                child: BigText(
                                  text: "Call",
                                  fontWeight: FontWeight.w500,
                                  size: Dimensions.fontSize15,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              fontWeight: FontWeight.w600,
                              text: "Alan Sabu -",
                              size: Dimensions.fontSize15,
                              color: fontGrey,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        mainAppColor)),
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      alanNumber);
                                },
                                child: BigText(
                                  text: "Call",
                                  fontWeight: FontWeight.w500,
                                  size: Dimensions.fontSize15,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              fontWeight: FontWeight.w600,
                              text: "Basil CG -",
                              size: Dimensions.fontSize15,
                              color: fontGrey,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        mainAppColor)),
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      basilNumber);
                                },
                                child: BigText(
                                  text: "Call",
                                  fontWeight: FontWeight.w500,
                                  size: Dimensions.fontSize15,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BigText(
                              fontWeight: FontWeight.w600,
                              text: "Archana -",
                              size: Dimensions.fontSize15,
                              color: fontGrey,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        mainAppColor)),
                                onPressed: () async {
                                  await FlutterPhoneDirectCaller.callNumber(
                                      archanaNumber);
                                },
                                child: BigText(
                                  text: "Call",
                                  fontWeight: FontWeight.w500,
                                  size: Dimensions.fontSize15,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                });
          })
        ],
      ).paddingOnly(bottom: 5),
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
