import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/orders_controller.dart';
import 'package:fresh_om_seller/views/order_screen/Components/order_place_details.dart';
import 'package:intl/intl.dart' as intl;

import '../../utils/reusable_big_text.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (Scaffold(
          backgroundColor: mainBackGround,
          bottomNavigationBar: Visibility(
            visible: !controller.confirmed.value,
            child: Container(
                alignment: Alignment.center,
                height: Dimensions.height55,
                color: mainAppColor,
                child: BigText(
                  text: "Confirm Order",
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  size: Dimensions.fontSize16,
                )).onTap(() {
              controller.confirmed(true);
              controller.changeOrder(
                  title: "order_confirmed",
                  status: true,
                  docId: widget.data.id);
            }),
          ),
          appBar: AppBar(
            foregroundColor: white,
            backgroundColor: mainAppColor,
            elevation: 0,
            title: BigText(
              text: orderDetails,
              fontWeight: FontWeight.w600,
              size: Dimensions.fontSize18,
              color: white,
            ),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //delivery status section
                Dimensions.height10.heightBox,
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Order Status:",
                        fontWeight: FontWeight.w700,
                        size: Dimensions.fontSize18,
                        color: nicePurple,
                      ).paddingOnly(
                          left: Dimensions.width10, top: Dimensions.height10),
                      SwitchListTile(
                        activeColor: mainAppColor,
                        value: true,
                        onChanged: (value) {},
                        title: const BigText(
                          text: orderPlaced,
                          color: nicePurple,
                          fontWeight: FontWeight.w600,
                          size: 14,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: mainAppColor,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: const BigText(
                          text: orderConfirmed,
                          color: nicePurple,
                          fontWeight: FontWeight.w600,
                          size: 14,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: mainAppColor,
                        value: controller.onDelivery.value,
                        onChanged: (value) {
                          controller.onDelivery.value = value;
                          controller.changeOrder(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: const BigText(
                          text: orderOnDelivery,
                          color: nicePurple,
                          fontWeight: FontWeight.w600,
                          size: 14,
                        ),
                      ),
                      SwitchListTile(
                        activeColor: mainAppColor,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                          controller.changeOrder(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: const BigText(
                          text: orderDelivered,
                          color: nicePurple,
                          fontWeight: FontWeight.w600,
                          size: 14,
                        ),
                      )
                    ],
                  )
                      .box
                      .outerShadowMd
                      .color(mainBackGround)
                      .margin(EdgeInsets.only(top: Dimensions.height10))
                      .make(),
                ),
                Dimensions.height10.heightBox,
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 2,
                  indent: Dimensions.width20,
                  endIndent: Dimensions.width20,
                ),
                Dimensions.height10.heightBox,

                //center address details
                Column(
                  children: [
                    orderPlaceDetails(
                        title1: "Order By Id",
                        d1: '${widget.data['order_by']}',
                        title2: "Delivery Method",
                        d2: '${widget.data['delivery_method']}'),
                    orderPlaceDetails(
                        title1: "Order Date",
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format(widget.data['order_date'].toDate()),
                        title2: "Payment Method",
                        d2: '${widget.data['payment_method']}'),
                    orderPlaceDetails(
                        title1: "Payment Status",
                        d1: widget.data['order_delivered'] == true
                            ? "Paid"
                            : "Unpaid",
                        title2: "Delivery Status",
                        d2: "Order Placed"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: "Delivery Address",
                              fontWeight: FontWeight.w700,
                              size: Dimensions.fontSize15,
                              color: nicePurple,
                            ),
                            addressDetails(
                                data: widget.data["order_by_name"],
                                leading: "Name    :"),
                            addressDetails(
                                data: widget.data['order_by_email'],
                                leading: "Email     :"),
                            addressDetails(
                                data: widget.data['order_by_address'],
                                leading: "Address:"),
                            addressDetails(
                                data: widget.data['order_by_city'],
                                leading: "City        :"),
                            addressDetails(
                                data: widget.data['order_by_phone'],
                                leading: "Phone    :"),
                            addressDetails(
                                data: widget.data['order_by_postal'],
                                leading: "Postal    :"),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height110,
                          width: Dimensions.height120,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              BigText(
                                text: "Total Amount",
                                fontWeight: FontWeight.w700,
                                size: Dimensions.fontSize16,
                                color: nicePurple,
                              ),
                              Dimensions.height30.heightBox,
                              "Rs.${widget.data['total_amount']}"
                                  .text
                                  .bold
                                  .size(Dimensions.fontSize20)
                                  .color(orangeRed)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                )
                    .box
                    .outerShadowMd
                    .padding(EdgeInsets.all(Dimensions.width13))
                    .color(mainBackGround)
                    .make(),
                Dimensions.height20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1,
                      width: Dimensions.width50 * 2,
                      color: Colors.grey.shade400,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: BigText(
                          text: "Ordered Products",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize18,
                          color: nicePurple,
                        )),
                    Container(
                      height: 1,
                      width: Dimensions.width50 * 2,
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
                Dimensions.height15.heightBox,

                ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      children: [
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                        orderPlaceDetails(
                            title1: controller.orders[index]['title'],
                            title2: "Rs .${controller.orders[index]['tPrice']}",
                            d1: "Quantity",
                            d2: "${controller.orders[index]['qty']} kg"),
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .padding(EdgeInsets.all(Dimensions.height12))
                    .color(mainBackGround)
                    .make(),
                Dimensions.height50.heightBox
              ],
            ),
          ),
        )));
  }
}
