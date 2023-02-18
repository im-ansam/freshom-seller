import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
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
        backgroundColor: nicePurple,
        elevation: 0,
        title: BigText(
          text: profile,
          fontWeight: FontWeight.w700,
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
                Icons.edit,
                color: white,
              )),
          TextButton(
              onPressed: () async {
                var sharedPref = await SharedPreferences.getInstance();
                sharedPref.setBool('isLogged', false);
                await auth.signOut();

                Get.offAll(() => const MainLoginPage());
              },
              child:
                  logout.text.size(Dimensions.fontSize18).color(white).make())
        ],
      ),
      backgroundColor: nicePurple,
      body: Column(
        children: [
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
                          color: white,
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize18,
                        ),
                        Dimensions.width5.heightBox,
                        BigText(
                          text: "${profileController.snapshotData['email']}",
                          color: white,
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
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () {
                      Get.to(() => const MessagesList());
                    },
                    leading: Icon(
                      Icons.message_rounded,
                      color: white,
                      size: Dimensions.icon30,
                    ),
                    title: BigText(
                      text: messages,
                      color: white,
                      fontWeight: FontWeight.w500,
                      size: Dimensions.fontSize18,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
