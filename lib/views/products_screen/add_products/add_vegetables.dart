import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/products_controller.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/widgets/custom_text_field.dart';
import 'package:intl/intl.dart' as intl;
import 'dart:io';

class AddVegetable extends StatelessWidget {
  const AddVegetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    DateTime currentDate = DateTime.now();

    return Obx(() => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Get.back();
                controller.productImage('');
              },
              icon: Icon(Icons.arrow_back),
            ),
            foregroundColor: white,
            backgroundColor: nicePurple,
            elevation: 0,
            title: addProduct.text.size(Dimensions.fontSize18).semiBold.make(),
            actions: [
              TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    await controller.uploadProductImage();
                    await controller.uploadVegetables(
                        context: context, imageUrl: controller.productImgLink);
                    controller.vNameController.clear();
                    controller.vDescController.clear();
                    controller.vPriceController.clear();
                    controller.vQtyController.clear();
                    controller.productImage('');
                    Get.back();
                  },
                  child: controller.isLoading.value
                      ? progressIndicator(white)
                      : "Save".text.white.size(Dimensions.fontSize18).make())
            ],
          ),
          backgroundColor: nicePurple,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(Dimensions.width8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextField(
                      controller: controller.vNameController,
                      hint: "eg. Tomato",
                      label: "Product Name",
                      isPassword: false,
                      isDesc: false),
                  Dimensions.height10.heightBox,
                  customTextField(
                      controller: controller.vDescController,
                      hint: "eg. Good product",
                      label: "Description",
                      isPassword: false,
                      isDesc: true),
                  Dimensions.height10.heightBox,
                  customTextField(
                      controller: controller.vPriceController,
                      hint: "eg. 40/kg",
                      label: "Price",
                      isPassword: false,
                      isDesc: false),
                  Dimensions.height10.heightBox,
                  customTextField(
                      controller: controller.vQtyController,
                      hint: "eg. 3kg",
                      label: "Quantity",
                      isPassword: false,
                      isDesc: false),
                  Dimensions.height20.heightBox,
                  normalText(text: "Choose product image", color: white),
                  Dimensions.height20.heightBox,
                  Align(
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: Dimensions.height140 * 2,
                      width: Dimensions.height140 * 2,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: mainBackGround),
                      child: controller.productImage.isEmpty
                          ? Image.asset(cameraLogo)
                          : Image.file(File(controller.productImage.value),
                              fit: BoxFit.cover),
                    ).onTap(() {
                      controller.pickImage(context);
                    }),
                  ),
                  Dimensions.height20.heightBox,
                  normalText(text: "Uploading on", color: white),
                  Dimensions.height20.heightBox,
                  intl.DateFormat('dd-MM-yyyy')
                      .format(currentDate)
                      .text
                      .size(Dimensions.fontSize20)
                      .semiBold
                      .color(nicePurple)
                      .make()
                      .box
                      .roundedSM
                      .alignCenter
                      .height(Dimensions.height40)
                      .color(mainBackGround)
                      .width(double.infinity)
                      .make(),
                  Dimensions.width10.heightBox,
                ],
              ),
            ),
          ),
        ));
  }
}
