import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/views/Notification/notification_screen.dart';
import 'package:fresh_om_seller/views/auth_screen/login_screen.dart';
import 'package:fresh_om_seller/views/profile_screen/edit_profile.dart';
import 'package:fresh_om_seller/views/message_screens/messages_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/reusable_big_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainAppColor,
        toolbarHeight: Dimensions.height60,
        elevation: 0,
        title: BigText(
          text: profile,
          fontWeight: FontWeight.w600,
          size: Dimensions.fontSize18,
          color: white,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfile(
                      username: profileController.snapshotData['name'],
                    ));
              },
              icon: const Icon(
                Icons.settings,
                color: white,
              )),
          TextButton(
              onPressed: () async {
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool('isLogged', false);
                await FirebaseAuth.instance.signOut();

                Get.offAll(() => const MainLoginPage());
              },
              child:
                  logout.text.size(Dimensions.fontSize18).color(white).make()),
          10.widthBox
        ],
      ),
      backgroundColor: mainBackGround,
      body: Column(
        children: [
          Dimensions.height20.heightBox,
          //top profile details row
          FutureBuilder(
            future: FireStoreServices.getProfile(
                FirebaseAuth.instance.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return progressIndicator(white);
              } else {
                profileController.snapshotData = snapshot.data!.docs[0];
                return Row(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      height: Dimensions.height75,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: profileController.snapshotData['imageUrl'] == ''
                          ? Image.asset(
                              "images/cameraLogo2.png",
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              profileController.snapshotData['imageUrl'],
                              fit: BoxFit.cover,
                            ),
                    ),
                    Dimensions.height20.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "${profileController.snapshotData['name']}",
                          color: fontGrey,
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize18,
                        ),
                        Dimensions.width5.heightBox,
                        BigText(
                          text: "${profileController.snapshotData['email']}",
                          color: nicePurple,
                          letterSpace: 1,
                          fontWeight: FontWeight.w500,
                          size: Dimensions.fontSize14,
                        ),
                      ],
                    )
                  ],
                ).paddingOnly(left: Dimensions.height25);
              }
            },
          ),
          Dimensions.height10.heightBox,
          const Divider(
            color: Colors.black26,
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20, top: Dimensions.height20),
              child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(profileIcons.length, (index) {
                    return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const MessagesList());
                            break;
                          case 1:
                            Get.to(() => const NotificationScreen());
                            break;
                        }
                      },
                      leading: Icon(
                        profileIcons[index],
                        color: mainAppColor,
                      ),
                      title: BigText(
                        text: profileString[index],
                        color: fontGrey,
                        fontWeight: FontWeight.w500,
                        size: Dimensions.fontSize16,
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}
