import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/orders_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/order_screen/order_details.dart';
import 'package:intl/intl.dart' as intl;

import '../../utils/reusable_big_text.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainBackGround,
        elevation: 0,
        title: BigText(
          text: orders,
          fontWeight: FontWeight.w700,
          size: Dimensions.fontSize18,
          color: nicePurple,
        ),
        actions: [
          Center(
            child: Text(
              intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
              style: TextStyle(
                  fontSize: Dimensions.fontSize18,
                  color: Vx.gray600,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Dimensions.height10.widthBox
        ],
      ),
      body: StreamBuilder(
        stream:
            FireStoreServices.getOrders(FirebaseAuth.instance.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return progressIndicator(nicePurple);
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: headingText(
                  text: "No Order Yet!",
                  color: nicePurple,
                  fontSize: Dimensions.fontSize20),
            );
          } else {
            var data = snapshot.data!.docs;
            return Padding(
                padding: EdgeInsets.all(Dimensions.width8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return Padding(
                        padding: EdgeInsets.only(bottom: Dimensions.width5),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10)),
                          tileColor: Colors.grey[300],
                          onTap: () {
                            Get.to(() => OrderDetails(
                                  data: data[index],
                                ));
                          },
                          title: "${data[index]['order_by_email']}"
                              .text
                              .bold
                              .color(nicePurple)
                              .make(),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.grey[600],
                                    size: Dimensions.icon22,
                                  ),
                                  Dimensions.width10.widthBox,
                                  Text(
                                    intl.DateFormat('EEE , MMM d,' 'yy')
                                        .format(time),
                                    style: TextStyle(
                                        fontSize: Dimensions.fontSize15,
                                        color: Vx.gray600,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.payment,
                                    color: Colors.grey[600],
                                    size: Dimensions.icon22,
                                  ),
                                  Dimensions.width10.widthBox,
                                  data[index]['order_delivered']
                                      ? "Paid"
                                          .text
                                          .semiBold
                                          .size(Dimensions.fontSize14)
                                          .color(Colors.green)
                                          .make()
                                      : unPaid.text.semiBold
                                          .size(Dimensions.fontSize14)
                                          .color(priceColor)
                                          .make()
                                ],
                              )
                            ],
                          ),
                          trailing: "Rs.${data[index]['total_amount']}"
                              .text
                              .size(Dimensions.fontSize16)
                              .bold
                              .color(nicePurple)
                              .make(),
                        ),
                      );
                    }),
                  ),
                ));
          }
        },
      ),
    );
  }
}
