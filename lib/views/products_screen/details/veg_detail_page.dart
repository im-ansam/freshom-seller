import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/widgets/expandable_text.dart';
import 'package:fresh_om_seller/widgets/reusable_small_text.dart';

import '../../../utils/reusable_big_text.dart';

class VegDetail extends StatelessWidget {
  final dynamic data;
  const VegDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          //head background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.height400,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(data['v_image']))),
              // child: Image.asset('images/veg2.jpeg'),
            ),
          ),
          //buttons
          Positioned(
            top: Dimensions.height55,
            left: Dimensions.height10,
            child: CircleAvatar(
                radius: Dimensions.radius18,
                backgroundColor: lightGreen1,
                child: Icon(
                  Icons.clear,
                  color: nicePurple,
                  size: Dimensions.icon25,
                )).onTap(() {
              Get.back();
            }),
          ),
          //food detail
          Positioned(
            bottom: 0,
            top: Dimensions.height350,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.height50,
                  left: Dimensions.height25,
                  right: Dimensions.height25),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade600,
                        blurRadius: 20,
                        spreadRadius: 1)
                  ],
                  color: mainBackGround,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius25),
                      topRight: Radius.circular(Dimensions.radius25))),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: data['v_name'],
                      fontWeight: FontWeight.w600,
                      color: nicePurple,
                      size: Dimensions.fontSize23,
                    ),
                    10.heightBox,
                    "Rs${data['v_price']}/kg"
                        .text
                        .bold
                        .size(Dimensions.fontSize20)
                        .color(orangeRed)
                        .make(),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Quantity :",
                          fontWeight: FontWeight.w600,
                          color: nicePurple,
                          size: Dimensions.fontSize18,
                        ),
                        Text(
                          "${data['v_qty']}kg",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize18,
                              color: Vx.gray600,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                        .box
                        .alignCenterLeft
                        .color(Colors.grey[300]!)
                        .roundedSM
                        .padding(const EdgeInsets.only(left: 10, right: 10))
                        .shadowSm
                        .width(double.infinity)
                        .height(40)
                        .make(),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          text: "Uploaded date :",
                          fontWeight: FontWeight.w600,
                          color: nicePurple,
                          size: Dimensions.fontSize18,
                        ),
                        Text(
                          "${data['v_uploaded_date']}",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize18,
                              color: Vx.gray600,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                        .box
                        .alignCenterLeft
                        .color(Colors.grey[300]!)
                        .roundedSM
                        .padding(const EdgeInsets.only(left: 10, right: 10))
                        .shadowSm
                        .width(double.infinity)
                        .height(40)
                        .make(),
                    20.heightBox,
                    Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    BigText(
                      text: 'Description',
                      fontWeight: FontWeight.w600,
                      color: nicePurple,
                      size: Dimensions.fontSize23,
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    ExpadableText(
                      text: data['v_desc'],
                    ),
                    SizedBox(
                      height: Dimensions.height100,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
