import 'dart:io';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/widgets/custom_text_field.dart';

class EditProfile extends StatefulWidget {
  final String? username;
  const EditProfile({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();
  var isLoading = false.obs;

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (Scaffold(
          backgroundColor: nicePurple,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Icon(
              Icons.arrow_back,
              color: white,
            ).onTap(() {
              Get.back();
              controller.oldPassController.clear();
              controller.newPassController.clear();
            }),
            backgroundColor: nicePurple,
            elevation: 0,
            title: editProfile.text
                .size(Dimensions.fontSize18)
                .color(white)
                .semiBold
                .make(),
            actions: [
              TextButton(
                  onPressed: () async {
                    isLoading(true);
                    //if user doesn't choose any file then the link present in database will again pasted in side that
                    if (controller.profileImgPath.value.isNotEmpty) {
                      await controller.uploadProfileImg();
                    } else {
                      controller.profileImgLink =
                          controller.snapshotData['imageUrl'];
                    }
                    //if the entering oldPassword matches the old password in database then only
                    // user can change it

                    if (controller.snapshotData['password'] ==
                        controller.oldPassController.text) {
                      await controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.oldPassController.text,
                          newPassword: controller.newPassController.text);
                      await controller.updateProfile(
                          imageUrl: controller.profileImgLink,
                          password: controller.newPassController.text,
                          name: controller.nameController.text);
                      VxToast.show(context, msg: "Updated");
                      isLoading(false);
                    } else if (controller
                            .oldPassController.text.isEmptyOrNull &&
                        controller.newPassController.text.isEmptyOrNull) {
                      await controller.updateProfile(
                          imageUrl: controller.profileImgLink,
                          password: controller.snapshotData['password'],
                          name: controller.nameController.text);
                      VxToast.show(context, msg: "Updated");
                    } else {
                      VxToast.show(context, msg: "Something went wrong");
                    }
                    isLoading(false);
                  },
                  child: isLoading.value
                      ? progressIndicator(white)
                      : "Save"
                          .text
                          .size(Dimensions.fontSize18)
                          .color(white)
                          .make())
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.width8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //top profile image container
                  Container(
                    clipBehavior: Clip.antiAlias,
                    height: Dimensions.height120,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: controller.snapshotData['imageUrl'] == "" &&
                            controller.profileImgPath.isEmpty

                        //default asset image will show
                        ? Image.asset(
                            cameraLogo,
                            fit: BoxFit.cover,
                          )

                        //else if imageUrl of database is not empty but profile image path is empty
                        : controller.snapshotData['imageUrl'] != "" &&
                                controller.profileImgPath.isEmpty

                            //
                            ? Image.network(
                                controller.snapshotData['imageUrl'],
                                fit: BoxFit.cover,
                              )

                            //else selected image will show
                            : Image.file(
                                File(controller.profileImgPath.value),
                                fit: BoxFit.cover,
                              ),
                  ),
                  Dimensions.height10.heightBox,
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: white),
                      onPressed: () {
                        controller.changeImg(context);
                      },
                      child: changeImage.text.semiBold
                          .size(Dimensions.fontSize16)
                          .color(fontGrey)
                          .make()),
                  Dimensions.height10.heightBox,
                  const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Dimensions.height10.heightBox,
                  customTextField(
                      controller: controller.nameController,
                      isPassword: false,
                      label: "Username",
                      hint: "eg. vendor name",
                      isDesc: false),
                  Dimensions.height30.heightBox,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: headingText(
                          text: "Change your password",
                          fontSize: Dimensions.fontSize18,
                          color: white)),
                  Dimensions.height20.heightBox,
                  customTextField(
                      controller: controller.newPassController,
                      isPassword: true,
                      label: "Password",
                      hint: "*****",
                      isDesc: false),
                  Dimensions.height10.heightBox,
                  customTextField(
                      controller: controller.oldPassController,
                      isPassword: true,
                      label: "Old Password",
                      hint: "Enter your previous password",
                      isDesc: false),
                ],
              ),
            ),
          ),
        )));
  }
}
