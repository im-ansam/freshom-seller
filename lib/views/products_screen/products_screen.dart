import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/products_screen/fruit_category.dart';
import 'package:fresh_om_seller/views/products_screen/veg_category.dart';
import 'package:intl/intl.dart' as intl;

import '../../utils/reusable_big_text.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    var isVeg = true.obs;
    var isFruit = false.obs;
    return Scaffold(
        backgroundColor: mainBackGround,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: mainAppColor,
          elevation: 0,
          title: BigText(
            text: "Products",
            fontWeight: FontWeight.w600,
            size: Dimensions.fontSize18,
            color: white,
          ),
          actions: [
            Center(
              child: Text(
                intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
                style: TextStyle(
                    fontSize: Dimensions.fontSize16,
                    color: Vx.gray300,
                    fontWeight: FontWeight.bold),
              ),
            ),
            10.widthBox
          ],
        ),
        body: Obx(() => Column(
              children: [
                Dimensions.height10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //vegetable category
                    Column(
                      children: [
                        BigText(
                          text: "Vegetable",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize15,
                        ),
                        5.heightBox,
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isVeg.value
                                  ? mainAppColor
                                  : Colors.transparent),
                          height: 4,
                          width: 30,
                        )
                      ],
                    )
                        .box
                        .height(40)
                        .width(100)
                        .color(isVeg.value ? lightBlue1 : Colors.transparent)
                        .padding(EdgeInsets.only(
                            top: 5, left: 2, right: 2, bottom: 2))
                        .roundedSM
                        .makeCentered()
                        .onTap(() {
                      isVeg.value = true;
                      isFruit.value = false;
                    }),

                    //fruit category
                    Column(
                      children: [
                        BigText(
                          text: "Fruits",
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize15,
                        ),
                        5.heightBox,
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: isFruit.value
                                ? mainAppColor
                                : Colors.transparent,
                          ),
                          height: 4,
                          width: 30,
                        )
                      ],
                    )
                        .box
                        .height(40)
                        .width(100)
                        .color(isFruit.value ? lightBlue1 : Colors.transparent)
                        .padding(EdgeInsets.only(top: 5, left: 3, right: 3))
                        .roundedSM
                        .makeCentered()
                        .onTap(() {
                      isVeg.value = false;
                      isFruit.value = true;
                    }),
                  ],
                )
                    .box
                    .outerShadowMd
                    // .padding(EdgeInsets.only(top: 10))
                    .color(darkCream)
                    .roundedSM
                    .width(Dimensions.screenWidth - 60)
                    .height(Dimensions.height50)
                    .makeCentered(),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: isVeg.value ? VegCategory() : FruitCategory()),
                )
              ],
            )));
  }
}
