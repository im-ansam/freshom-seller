import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/products_screen/fruit_category.dart';
import 'package:fresh_om_seller/views/products_screen/veg_category.dart';
import 'package:intl/intl.dart' as intl;

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
          backgroundColor: mainBackGround,
          elevation: 0,
          title: "Products".text.size(18).color(nicePurple).semiBold.make(),
          actions: [
            Center(
              child: Text(
                intl.DateFormat('EEE , MMM d,' 'yy').format(DateTime.now()),
                style: TextStyle(
                    fontSize: 18,
                    color: Vx.gray600,
                    fontWeight: FontWeight.bold),
              ),
            ),
            10.widthBox
          ],
        ),
        body: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //vegetable category
                    Column(
                      children: [
                        headingText(text: "Vegetable", fontSize: 18.0),
                        5.heightBox,
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isVeg.value
                                  ? nicePurple
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
                        .padding(EdgeInsets.only(top: 5, left: 2, right: 2))
                        .roundedSM
                        .makeCentered()
                        .onTap(() {
                      isVeg.value = true;
                      isFruit.value = false;
                    }),

                    //fruit category
                    Column(
                      children: [
                        headingText(text: "Fruits", fontSize: 18.0),
                        5.heightBox,
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:
                                isFruit.value ? nicePurple : Colors.transparent,
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