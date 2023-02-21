import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/views/products_screen/add_products/add_fruits.dart';
import 'package:fresh_om_seller/views/products_screen/add_products/add_vegetables.dart';

import '../../../utils/reusable_big_text.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainAppColor,
        elevation: 0,
        title: BigText(
          text: addProduct,
          fontWeight: FontWeight.w600,
          size: Dimensions.fontSize18,
          color: white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: Dimensions.height40, bottom: Dimensions.height30),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //add fruit container
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //circle image container
                Container(
                  alignment: Alignment.center,
                  height: Dimensions.height100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: Container(
                    height: Dimensions.height85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      orangeImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Dimensions.height10.heightBox,
                //category text
                BigText(
                  text: fruits,
                  fontWeight: FontWeight.w600,
                  size: Dimensions.fontSize20,
                  color: nicePurple,
                ),
                Dimensions.height15.heightBox,
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                    onPressed: () {
                      Get.to(() => const AddFruits());
                    },
                    child: BigText(
                      text: "Select",
                      fontWeight: FontWeight.w600,
                      size: Dimensions.fontSize15,
                      color: white,
                    ))
              ],
            )
                .box
                .shadowMd
                .width(Dimensions.height230)
                .padding(EdgeInsets.only(top: Dimensions.height30))
                .height(Dimensions.height230)
                .roundedSM
                .color(white)
                .make(),

            //add veg container
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //circle image container
                Container(
                  alignment: Alignment.center,
                  height: Dimensions.height100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: Container(
                    height: Dimensions.height85,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      brinjalImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Dimensions.height10.heightBox,
                //category text
                vegetables.text.semiBold
                    .size(Dimensions.fontSize23)
                    .letterSpacing(1)
                    .color(Colors.grey[900])
                    .make(),
                Dimensions.height15.heightBox,
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                    onPressed: () {
                      Get.to(() => const AddVegetable());
                    },
                    child: BigText(
                      text: "Select",
                      fontWeight: FontWeight.w600,
                      size: Dimensions.fontSize15,
                      color: white,
                    ))
              ],
            )
                .box
                .shadowMd
                .width(Dimensions.height230)
                .padding(EdgeInsets.only(top: Dimensions.height30))
                .height(Dimensions.height230)
                .roundedSM
                .color(white)
                .make()

            //add veg container
          ],
        ),
      ),
    );
  }
}
