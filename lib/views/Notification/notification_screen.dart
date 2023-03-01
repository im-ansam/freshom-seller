import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';

import '../../utils/reusable_big_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        backgroundColor: mainAppColor,
        foregroundColor: white,
        elevation: 0,
        title: BigText(
          text: "Notifications",
          fontWeight: FontWeight.w600,
          size: Dimensions.fontSize18,
          color: white,
        ),
      ),
      body: Column(
        children: [
          BigText(
            text: "Expired Fruits",
            fontWeight: FontWeight.w500,
            size: Dimensions.fontSize18,
            color: Colors.grey[900],
          )
              .box
              .alignCenter
              .color(Colors.grey.shade300)
              .width(double.infinity)
              .height(50)
              .make(),
          Dimensions.height10.heightBox,
          StreamBuilder(
            stream: FireStoreServices.getDeletedFruits(
                FirebaseAuth.instance.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return progressIndicator(mainAppColor);
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: BigText(
                    text: 'No fruits expired',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    size: Dimensions.fontSize18,
                  ),
                );
              } else {
                // var data = snapshot.data!.docs;
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Dismissible(
                      key: Key(document.id),
                      onDismissed: ((direction) {
                        controller.removeFruitsNotification(document.id);
                      }),
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.antiAlias,
                          width: Dimensions.height100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius5)),
                          child: Image.network(
                            document['f_image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: BigText(
                          text: "${document['f_name']}",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize16,
                          color: fontGrey,
                        ),
                        subtitle: "Uploaded on ${document['f_uploaded_date']}"
                            .text
                            .semiBold
                            .color(Colors.grey[600])
                            .make(),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
          Dimensions.height20.heightBox,
          BigText(
            text: "Expired Vegetables",
            fontWeight: FontWeight.w500,
            size: Dimensions.fontSize18,
            color: Colors.grey[900],
          )
              .box
              .alignCenter
              .color(Colors.grey.shade300)
              .width(double.infinity)
              .height(50)
              .make(),
          Dimensions.height10.heightBox,
          StreamBuilder(
            stream: FireStoreServices.getDeletedVeg(
                FirebaseAuth.instance.currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return progressIndicator(mainAppColor);
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: BigText(
                    text: 'No vegetables expired',
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    size: Dimensions.fontSize18,
                  ),
                );
              } else {
                // var data = snapshot.data!.docs;
                return ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((document) {
                    return Dismissible(
                      key: Key(document.id),
                      onDismissed: ((direction) {
                        controller.removeVegNotification(document.id);
                      }),
                      child: ListTile(
                        leading: Container(
                          clipBehavior: Clip.antiAlias,
                          width: Dimensions.height100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius5)),
                          child: Image.network(
                            document['v_image'],
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: BigText(
                          text: "${document['v_name']}",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize16,
                          color: fontGrey,
                        ),
                        subtitle: "Uploaded on ${document['v_uploaded_date']}"
                            .text
                            .semiBold
                            .color(Colors.grey[600])
                            .make(),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
