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
import 'package:google_fonts/google_fonts.dart';

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
            BigText(
              text: "Hi,  ${homeController.username}",
              fontWeight: FontWeight.w600,
              color: nicePurple,
              size: Dimensions.fontSize23,
            ),
            Text(intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
                style: GoogleFonts.poppins(
                    fontSize: Dimensions.fontSize16,
                    color: Vx.gray500,
                    fontWeight: FontWeight.bold))
          ],
        ),
        actions: [
          FutureBuilder(
            future: FireStoreServices.getProfile(
                FirebaseAuth.instance.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return progressIndicator(nicePurple);
              } else {
                var prof = snapshot.data!.docs[0];
                return Container(
                  height: Dimensions.height60,
                  width: Dimensions.height60,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(prof['imageUrl']),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: Colors.grey),
                ).paddingOnly(right: Dimensions.width15);
              }
            },
          )
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
                  return progressIndicator(nicePurple);
                } else {
                  var countData = snapshot.data;
                  return Column(
                    children: [
                      //top two container main row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //vegetables count container
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            height: Dimensions.height100,
                            width: Dimensions.width170,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: nicePurple),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: "Vegetables",
                                      fontWeight: FontWeight.bold,
                                      size: Dimensions.fontSize18,
                                      color: white,
                                    ),
                                    BigText(
                                      text: "${countData[0]}",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      size: Dimensions.fontSize24,
                                    ).paddingOnly(left: Dimensions.height15),
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

                          //orders count container
                          Container(
                            height: Dimensions.height100,
                            width: Dimensions.width170,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius15),
                                // gradient: LinearGradient(
                                //     // tileMode: TileMode.repeated,
                                //     colors: [nicePurple, niceBlue])

                                //try this also
                                color: nicePurple),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: "Orders",
                                      fontWeight: FontWeight.bold,
                                      size: Dimensions.fontSize18,
                                      color: white,
                                    ),
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
                          )
                        ],
                      ),
                      10.heightBox,
                      //below two container main row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          //fruits count container
                          Container(
                            padding: EdgeInsets.only(top: Dimensions.height15),
                            height: Dimensions.height100,
                            width: Dimensions.width170,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius10),
                                color: nicePurple),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(
                                      text: "Fruits",
                                      fontWeight: FontWeight.bold,
                                      size: Dimensions.fontSize18,
                                      color: white,
                                    ),
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
                          //messages container

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
                                      BigText(
                                        text: "Messages",
                                        fontWeight: FontWeight.bold,
                                        size: Dimensions.fontSize18,
                                        color: white,
                                      ),
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
                  return progressIndicator(nicePurple);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: headingText(text: "No products added today"),
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
                                color: Colors.grey[800],
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
                  return progressIndicator(nicePurple);
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: headingText(text: "No products added today"),
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
                                color: Colors.grey[800],
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
