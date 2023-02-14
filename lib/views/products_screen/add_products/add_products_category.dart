import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/views/products_screen/add_products/add_fruits.dart';
import 'package:fresh_om_seller/views/products_screen/add_products/add_vegetables.dart';

class AddProducts extends StatelessWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackGround,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mainBackGround,
        elevation: 0,
        title: addProduct.text
            .size(Dimensions.fontSize18)
            .color(nicePurple)
            .semiBold
            .make(),
      ),
      body: Container(
        padding: EdgeInsets.only(
            top: Dimensions.height20, bottom: Dimensions.height20),
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
                  height: Dimensions.height110,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: Container(
                    height: Dimensions.height85,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
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
                fruits.text.semiBold
                    .size(Dimensions.fontSize23)
                    .letterSpacing(1)
                    .color(Colors.grey[900])
                    .make(),
                Dimensions.height15.heightBox,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: niceViolet),
                  onPressed: () {
                    Get.to(() => const AddFruits());
                  },
                  child: "Select"
                      .text
                      .bold
                      .size(Dimensions.fontSize16)
                      .letterSpacing(1)
                      .color(white)
                      .make(),
                )
              ],
            )
                .box
                .shadowMd
                .width(Dimensions.height250)
                .padding(EdgeInsets.only(top: Dimensions.height30))
                .height(Dimensions.height250)
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
                  height: Dimensions.height110,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[300]),
                  child: Container(
                    height: Dimensions.height85,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
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
                  style: ElevatedButton.styleFrom(backgroundColor: niceViolet),
                  onPressed: () {
                    Get.to(() => AddVegetable());
                  },
                  child: "Select"
                      .text
                      .bold
                      .size(Dimensions.fontSize16)
                      .letterSpacing(1)
                      .color(white)
                      .make(),
                )
              ],
            )
                .box
                .shadowMd
                .width(Dimensions.height250)
                .padding(EdgeInsets.only(top: Dimensions.height30))
                .height(Dimensions.height250)
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
