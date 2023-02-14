import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/widgets/expandable_text.dart';
import 'package:fresh_om_seller/widgets/reusable_small_text.dart';

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
              left: Dimensions.height20,
              right: Dimensions.height20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.clear,
                      color: fontGrey,
                      size: Dimensions.icon30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              )),
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
                    Text(
                      data['v_name'],
                      style: TextStyle(
                          fontSize: Dimensions.fontSize23,
                          color: fontGrey,
                          fontWeight: FontWeight.w700),
                    ),
                    10.heightBox,
                    "Rs${data['v_price']}/kg"
                        .text
                        .bold
                        .size(Dimensions.fontSize20)
                        .color(Colors.redAccent)
                        .make(),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity-",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize20,
                              color: fontGrey,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          "${data['v_qty']}kg",
                          style: TextStyle(
                              fontSize: Dimensions.fontSize20,
                              color: Vx.gray600,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                        .box
                        .alignCenterLeft
                        .color(darkCream)
                        .roundedSM
                        .padding(EdgeInsets.only(left: 10, right: 10))
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
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: Dimensions.fontSize23,
                          color: fontGrey,
                          fontWeight: FontWeight.w700),
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
