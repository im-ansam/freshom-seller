import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/home_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/message_screens/messages_list.dart';
import 'package:fresh_om_seller/views/products_screen/details/fruit_detail_page.dart';
import 'package:fresh_om_seller/views/products_screen/details/veg_detail_page.dart';

import '../../utils/reusable_big_text.dart';
import 'package:intl/intl.dart' as intl;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    homeController.update();
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        toolbarHeight: Dimensions.height70,
        automaticallyImplyLeading: false,
        backgroundColor: mainBackGround,
        elevation: 0,
        foregroundColor: nicePurple,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Hi, ${homeController.username}"
                .text
                .size(Dimensions.fontSize23)
                .letterSpacing(1)
                .color(nicePurple)
                .bold
                .make(),
            Text(
              intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
              style: TextStyle(
                  fontSize: Dimensions.fontSize16,
                  color: Vx.gray500,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Container(
            height: Dimensions.height60,
            width: Dimensions.height60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(homeController.userImage),
                    fit: BoxFit.cover),
                shape: BoxShape.circle,
                color: Colors.grey),
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
              future: FireStoreServices.getCount(FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(nicePurple);
                } else {
                  var countData = snapshot.data;
                  return Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //total products container
                            Container(
                              padding:
                                  EdgeInsets.only(top: Dimensions.height15),
                              height: Dimensions.height100,
                              width: Dimensions.width170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10),
                                  color: nicePurple),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "Vegetables"
                                          .text
                                          .color(Colors.white)
                                          .size(Dimensions.fontSize18)
                                          .bold
                                          .make(),
                                      BigText(
                                        text: "${countData[0]}",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        size: Dimensions.fontSize24,
                                      ),
                                      5.heightBox
                                    ],
                                  ),
                                  Image.asset(
                                    'images/productsIcon.png',
                                    color: Colors.white,
                                    height: Dimensions.height50,
                                  ),
                                ],
                              ),
                            ),

                            //orders container
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: Dimensions.height100,
                                width: Dimensions.width170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    // gradient: LinearGradient(
                                    //     // tileMode: TileMode.repeated,
                                    //     colors: [nicePurple, niceBlue])

                                    //try this also
                                    color: nicePurple),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "Orders"
                                            .text
                                            .color(Colors.white)
                                            .size(Dimensions.fontSize18)
                                            .bold
                                            .make(),
                                        BigText(
                                          text: '${countData[2]}',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          size: Dimensions.fontSize24,
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                      'images/orderLogo.png',
                                      color: Colors.white,
                                      height: Dimensions.height50,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            //total products container
                            Container(
                              padding:
                                  EdgeInsets.only(top: Dimensions.height15),
                              height: Dimensions.height100,
                              width: Dimensions.width170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius10),
                                  color: nicePurple),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      "Fruits"
                                          .text
                                          .color(Colors.white)
                                          .size(Dimensions.fontSize18)
                                          .bold
                                          .make(),
                                      BigText(
                                        text: '${countData[1]}',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        size: Dimensions.fontSize24,
                                      ),
                                      Dimensions.width5.heightBox
                                    ],
                                  ),
                                  Image.asset(
                                    'images/productsIcon.png',
                                    color: Colors.white,
                                    height: Dimensions.height50,
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const MessagesList());
                              },
                              child: Container(
                                height: Dimensions.height100,
                                width: Dimensions.width170,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    // gradient: LinearGradient(
                                    //     // tileMode: TileMode.repeated,
                                    //     colors: [nicePurple, niceBlue])

                                    //try this also
                                    color: nicePurple),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        "Messages"
                                            .text
                                            .color(Colors.white)
                                            .size(Dimensions.fontSize18)
                                            .bold
                                            .make(),
                                        BigText(
                                          text: '${countData[3]}',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          size: Dimensions.fontSize24,
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.message_rounded,
                                      size: Dimensions.icon50,
                                      color: white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                child: "Popular Veggies"
                    .text
                    .color(Colors.grey[800])
                    .size(Dimensions.fontSize18)
                    .semiBold
                    .make(),
              ),
            ),
            //popular veggies
            Dimensions.height20.heightBox,
            StreamBuilder(
              stream: FireStoreServices.getPopularVeg(FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(nicePurple);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: headingText(text: "No popular products"),
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
                              title: "${veggies[index]['v_name']}"
                                  .text
                                  .semiBold
                                  .color(Colors.grey[800])
                                  .make(),
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
                child: "Popular Fruits"
                    .text
                    .color(Colors.grey[800])
                    .size(Dimensions.fontSize18)
                    .semiBold
                    .make(),
              ),
            ),
            //popular fruits
            Dimensions.height20.heightBox,
            StreamBuilder(
              stream: FireStoreServices.getPopularFruit(FirebaseAuth.instance.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return progressIndicator(nicePurple);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: headingText(text: "No popular products"),
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
                              title: "${fruits[index]['f_name']}"
                                  .text
                                  .semiBold
                                  .color(Colors.grey[800])
                                  .make(),
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
