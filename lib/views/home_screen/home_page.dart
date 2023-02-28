import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/home_controller.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/views/Notification/notification_screen.dart';
import 'package:fresh_om_seller/views/message_screens/messages_list.dart';
import 'package:fresh_om_seller/views/products_screen/details/fruit_detail_page.dart';
import 'package:fresh_om_seller/views/products_screen/details/veg_detail_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/reusable_big_text.dart';
import 'package:intl/intl.dart' as intl;

import '../auth_screen/login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var profileController = Get.put(ProfileController());
    profileController.profileDetails();
    homeController.update();
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        automaticallyImplyLeading: false,
        backgroundColor: mainBackGround,
        elevation: 0,
        foregroundColor: mainAppColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text:
                  "Hi, ${profileController.profileData['name'] ?? "User"} ", //${homeController.username}
              fontWeight: FontWeight.w600,
              color: nicePurple,
              size: Dimensions.fontSize20,
            ),
            Text(intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
                style: GoogleFonts.poppins(
                    fontSize: Dimensions.fontSize16,
                    color: Vx.gray500,
                    fontWeight: FontWeight.bold))
          ],
        ),
        actions: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: Dimensions.height50,
            width: Dimensions.height50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: profileController.profileData['imageUrl'] != null
                ? Image.network(
                    profileController.profileData['imageUrl'],
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    cameraLogo,
                  ),
          ).paddingOnly(right: Dimensions.width15)
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Dimensions.height20.heightBox,
            //top four container
            FutureBuilder(
              future: FireStoreServices.getCount(
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(mainAppColor);
                } else {
                  var countData = snapshot.data;
                  return Column(
                    children: [
                      //top three container main row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: Dimensions.height90,
                            width: Dimensions.height120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                color: mainAppColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "Orders",
                                  fontWeight: FontWeight.bold,
                                  size: Dimensions.fontSize15,
                                  color: white,
                                ),
                                Image.asset(
                                  'images/orderLogo.png',
                                  color: Colors.white,
                                  height: Dimensions.height25,
                                ),
                                BigText(
                                  text: '${countData[2]}',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  size: Dimensions.fontSize18,
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                height: Dimensions.height90,
                                width: Dimensions.height120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    color: mainAppColor),
                                child: Stack(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  alignment: Alignment.center,
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //notifications text
                                    Positioned(
                                      top: Dimensions.height10,
                                      child: BigText(
                                        text: "Notifications",
                                        fontWeight: FontWeight.bold,
                                        size: Dimensions.fontSize15,
                                        color: white,
                                      ),
                                    ),
                                    //notifications icon
                                    Positioned(
                                      top: Dimensions.height50,
                                      child: Icon(
                                        Icons.notifications,
                                        color: white,
                                        size: Dimensions.icon30,
                                      ),
                                    ),
                                    //notifications count circle
                                    Positioned(
                                        top: Dimensions.height45,
                                        right: Dimensions.height45,
                                        child: countData[4] + countData[5] == 0
                                            ? Container()
                                            : CircleAvatar(
                                                radius: Dimensions.radius10,
                                                backgroundColor: Colors.yellow,
                                                child: Text(
                                                  "${countData[4] + countData[5]}",
                                                  style: const TextStyle(
                                                      color: Vx.black),
                                                ),
                                              ))
                                  ],
                                ),
                              ).onTap(() {
                                Get.to(() => const NotificationScreen());
                              }),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const MessagesList());
                            },
                            child: Container(
                              height: Dimensions.height90,
                              width: Dimensions.height120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  color: mainAppColor),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BigText(
                                    text: "Messages",
                                    fontWeight: FontWeight.bold,
                                    size: Dimensions.fontSize14,
                                    color: white,
                                  ),
                                  Icon(
                                    Icons.message_rounded,
                                    size: Dimensions.icon25,
                                    color: white,
                                  ),
                                  BigText(
                                    text: '${countData[3]}',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    size: Dimensions.fontSize18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      10.heightBox,
                      //below three container main row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //logout container
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            height: Dimensions.height90,
                            width: Dimensions.height120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: mainAppColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "Logout",
                                  fontWeight: FontWeight.bold,
                                  size: Dimensions.fontSize14,
                                  color: white,
                                ),
                                Icon(
                                  Icons.logout,
                                  color: white,
                                  size: Dimensions.icon30,
                                ).onTap(() async {
                                  var sharedPref =
                                      await SharedPreferences.getInstance();
                                  sharedPref.setBool('isLogged', false);
                                  await FirebaseAuth.instance.signOut();

                                  Get.offAll(() => const MainLoginPage());
                                }),
                                5.heightBox
                              ],
                            ),
                          ),
                          //Vegetable container
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            height: Dimensions.height90,
                            width: Dimensions.height120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: mainAppColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "Vegetables",
                                  fontWeight: FontWeight.bold,
                                  size: Dimensions.fontSize14,
                                  color: white,
                                ),
                                BigText(
                                  text: "${countData[0]}",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  size: Dimensions.fontSize23,
                                ),
                                5.heightBox
                              ],
                            ),
                          ),
                          //fruits container
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            height: Dimensions.height90,
                            width: Dimensions.height120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: mainAppColor),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BigText(
                                  text: "Fruits",
                                  fontWeight: FontWeight.bold,
                                  size: Dimensions.fontSize14,
                                  color: white,
                                ),
                                BigText(
                                  text: '${countData[1]}',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  size: Dimensions.fontSize23,
                                ),
                                5.heightBox
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            Dimensions.height20.heightBox,
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Dimensions.width15),
                height: Dimensions.height50,
                width: Dimensions.screenWidth - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: Colors.grey.shade200,
                ),
                child: BigText(
                  text: "Today added Veggies",
                  fontWeight: FontWeight.w600,
                  size: Dimensions.fontSize16,
                  color: Colors.grey[800],
                ),
              ),
            ),
            //popular veggies
            Dimensions.height20.heightBox,
            StreamBuilder(
              stream: FireStoreServices.getNewestVeg(
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(mainAppColor);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(noItem, height: Dimensions.width150),
                        BigText(
                          text: "No products added today",
                          fontWeight: FontWeight.w500,
                          size: Dimensions.fontSize18,
                          color: Colors.grey[600],
                        )
                      ],
                    ),
                  );
                } else {
                  var veggies = snapshot.data!.docs;

                  return ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                        veggies.length,
                        (index) => ListTile(
                              onTap: () {
                                Get.to(() => VegDetail(
                                      data: veggies[index],
                                    ));
                              },
                              leading: Container(
                                clipBehavior: Clip.antiAlias,
                                width: Dimensions.height100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5)),
                                child: Image.network(
                                  veggies[index]['v_image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: BigText(
                                text: "${veggies[index]['v_name']}",
                                fontWeight: FontWeight.w700,
                                size: Dimensions.fontSize16,
                                color: nicePurple,
                              ),
                              subtitle: "Rs.${veggies[index]['v_price']}"
                                  .text
                                  .semiBold
                                  .color(Colors.grey[800])
                                  .make(),
                            )),
                  );
                }
              },
            ),
            Dimensions.height20.heightBox,
            Align(
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: Dimensions.width15),
                height: Dimensions.height50,
                width: Dimensions.screenWidth - 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  color: Colors.grey.shade200,
                ),
                child: BigText(
                  text: "Today added Fruits",
                  fontWeight: FontWeight.w600,
                  size: Dimensions.fontSize16,
                  color: Colors.grey[800],
                ),
              ),
            ),
            //popular fruits
            Dimensions.height20.heightBox,
            StreamBuilder(
              stream: FireStoreServices.getNewestFruit(
                  FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(mainAppColor);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(noItem, height: Dimensions.width150),
                        BigText(
                          text: "No products added today",
                          fontWeight: FontWeight.w500,
                          size: Dimensions.fontSize18,
                          color: Colors.grey[600],
                        )
                      ],
                    ),
                  );
                } else {
                  var fruits = snapshot.data!.docs;
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                        fruits.length,
                        (index) => ListTile(
                              onTap: () {
                                Get.to(() => FruitDetail(
                                      data: fruits[index],
                                    ));
                              },
                              leading: Container(
                                width: Dimensions.height100,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius5)),
                                child: Image.network(
                                  fruits[index]['f_image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: BigText(
                                text: "${fruits[index]['f_name']}",
                                fontWeight: FontWeight.w700,
                                size: Dimensions.fontSize16,
                                color: nicePurple,
                              ),
                              subtitle: "Rs.40"
                                  .text
                                  .semiBold
                                  .color(Colors.grey[800])
                                  .make(),
                            )),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
