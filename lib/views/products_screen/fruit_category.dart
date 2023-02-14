import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_big_text.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/views/products_screen/details/fruit_detail_page.dart';

class FruitCategory extends StatelessWidget {
  const FruitCategory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return StreamBuilder(
      stream: FireStoreServices.getFruits(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return progressIndicator(nicePurple);
        } else if (snapshot.data!.docs.isEmpty) {
          return Center(
              child: headingText(text: "You have not added any products"));
        } else {
          var data = snapshot.data!.docs;
          return GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: Dimensions.height30,
                  crossAxisSpacing: Dimensions.width20,
                  mainAxisExtent: Dimensions.height270),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => FruitDetail(
                          data: data[index],
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.width8),
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            clipBehavior: Clip.antiAlias,
                            height: Dimensions.width150,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius10),
                            ),
                            child: Image.network(
                              data[index]['f_image'],
                              fit: BoxFit.cover,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                        overFlow: TextOverflow.ellipsis,
                                        text: "${data[index]['f_name']}",
                                        fontWeight: FontWeight.w600,
                                        size: Dimensions.fontSize16,
                                        color: Colors.grey[800])
                                    .box
                                    .width(Dimensions.height120)
                                    .make(),
                                "Rs.${data[index]['f_price']}"
                                    .text
                                    .size(Dimensions.fontSize16)
                                    .color(priceColor)
                                    .semiBold
                                    .color(Colors.grey[800])
                                    .make(),
                              ],
                            ),
                            VxPopupMenu(
                                    menuBuilder: () => Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: List.generate(
                                            popupMenuIcons.length,
                                            (i) => Row(
                                              children: [
                                                Icon(
                                                  popupMenuIcons[i],
                                                ),
                                                Dimensions.height10.widthBox,
                                                popupMenuTitles[i]
                                                    .text
                                                    .size(Dimensions.fontSize15)
                                                    .semiBold
                                                    .color(Colors.grey[600])
                                                    .make()
                                              ],
                                            )
                                                .paddingAll(Dimensions.height10)
                                                .onTap(() {
                                              switch (i) {
                                                case 0:
                                                  break;
                                                case 1:
                                                  controller.removeFruits(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: 'Product Removed');
                                                  break;
                                              }
                                            }),
                                          ),
                                        )
                                            .box
                                            .white
                                            .roundedSM
                                            .width(Dimensions.height100 * 2)
                                            .make(),
                                    clickType: VxClickType.singleClick,
                                    child: const Icon(Icons.more_vert))
                                .paddingOnly(
                                    right: Dimensions.width10,
                                    top: Dimensions.height20)
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      },
    );
  }
}