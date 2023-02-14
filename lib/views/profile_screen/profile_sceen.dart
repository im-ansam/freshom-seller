import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/auth_controller.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/views/auth_screen/login_screen.dart';
import 'package:fresh_om_seller/views/profile_screen/edit_profile.dart';
import 'package:fresh_om_seller/views/Notifications/notifications.dart';
import 'package:fresh_om_seller/views/message_screens/messages_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.put(ProfileController());
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: nicePurple,
        elevation: 0,
        title: profile.text
            .size(Dimensions.fontSize18)
            .color(white)
            .semiBold
            .make(),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfile(
                      username: profileController.snapshotData['name'],
                    ));
              },
              icon: Icon(
                Icons.edit,
                color: white,
              )),
          TextButton(
              onPressed: () async {
                await auth.signOut();
                controller.dispose();

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
            future: FireStoreServices.getProfile(FirebaseAuth.instance.currentUser!.uid),
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
                        "${profileController.snapshotData['name']}"
                            .text
                            .size(Dimensions.fontSize18)
                            .color(white)
                            .semiBold
                            .make(),
                        Dimensions.width5.heightBox,
                        "${profileController.snapshotData['email']}"
                            .text
                            .size(Dimensions.fontSize14)
                            .color(white)
                            .make()
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
              child: Column(
                children: List.generate(profileItemTitles.length, (index) {
                  return ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => NotificationsScreen());
                            break;
                          case 1:
                            Get.to(() => MessagesList());
                        }
                      },
                      leading: Icon(
                        profileItemIcons[index],
                        color: white,
                      ),
                      title: profileItemTitles[index].text.color(white).make());
                }),
              ))
        ],
      ),
    );
  }
}
