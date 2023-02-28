import 'dart:io';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/profile_controller.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';
import 'package:fresh_om_seller/widgets/custom_text_field.dart';

import '../../utils/reusable_big_text.dart';

class EditProfile extends StatefulWidget {
  final String? username;
  const EditProfile({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();
  var isLoading = false.obs;
  final ansamNumber = '9061383059';
  final alanNumber = '9961314409';
  final basilNumber = '9207142244';
  final archanaNumber = '8086393456';

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => (Scaffold(
          backgroundColor: mainBackGround,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: const Icon(
              Icons.arrow_back,
              color: white,
            ).onTap(() {
              Get.back();
              controller.oldPassController.clear();
              controller.newPassController.clear();
            }),
            backgroundColor: mainAppColor,
            elevation: 0,
            title: BigText(
              text: editProfile,
              fontWeight: FontWeight.w600,
              size: Dimensions.fontSize18,
              color: white,
            ),
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
                          : BigText(
                              text: "Save",
                              size: Dimensions.fontSize18,
                              fontWeight: FontWeight.w600,
                              color: white,
                            ))
                  .paddingOnly(right: Dimensions.width10),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.width8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Dimensions.height20.heightBox,
                  //top profile image container
                  Container(
                    alignment: Alignment.center,
                    height: Dimensions.height140,
                    width: Dimensions.height140,
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      height: Dimensions.height120,
                      width: Dimensions.height120,
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
                  ),
                  Dimensions.height10.heightBox,
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: mainAppColor),
                    onPressed: () {
                      controller.changeImg(context);
                    },
                    child: BigText(
                      text: changeImage,
                      size: Dimensions.fontSize15,
                      fontWeight: FontWeight.w600,
                      color: white,
                    ),
                  ),
                  Dimensions.height10.heightBox,
                  Divider(
                    thickness: 1,
                    color: Colors.grey[400],
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
                    child: BigText(
                      text: "Change your password",
                      fontWeight: FontWeight.w600,
                      size: Dimensions.fontSize18,
                      color: nicePurple,
                    ),
                  ),
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
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BigText(
                          text: contactUs,
                          fontWeight: FontWeight.w600,
                          size: Dimensions.fontSize12,
                          color: Colors.grey[500],
                        ),
                        5.widthBox,
                        const Icon(
                          Icons.info_rounded,
                          color: mainAppColor,
                        ).onTap(() {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  title: BigText(
                                    fontWeight: FontWeight.w600,
                                    text: "Call us on mobile",
                                    color: nicePurple,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            fontWeight: FontWeight.w600,
                                            text: "Ansam -",
                                            size: Dimensions.fontSize15,
                                            color: fontGrey,
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          mainAppColor)),
                                              onPressed: () async {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(ansamNumber);
                                              },
                                              child: BigText(
                                                text: "Call",
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.fontSize15,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            fontWeight: FontWeight.w600,
                                            text: "Alan Sabu -",
                                            size: Dimensions.fontSize15,
                                            color: fontGrey,
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          mainAppColor)),
                                              onPressed: () async {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(alanNumber);
                                              },
                                              child: BigText(
                                                text: "Call",
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.fontSize15,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            fontWeight: FontWeight.w600,
                                            text: "Basil CG -",
                                            size: Dimensions.fontSize15,
                                            color: fontGrey,
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          mainAppColor)),
                                              onPressed: () async {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(basilNumber);
                                              },
                                              child: BigText(
                                                text: "Call",
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.fontSize15,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BigText(
                                            fontWeight: FontWeight.w600,
                                            text: "Archana -",
                                            size: Dimensions.fontSize15,
                                            color: fontGrey,
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          mainAppColor)),
                                              onPressed: () async {
                                                await FlutterPhoneDirectCaller
                                                    .callNumber(archanaNumber);
                                              },
                                              child: BigText(
                                                text: "Call",
                                                fontWeight: FontWeight.w500,
                                                size: Dimensions.fontSize15,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        })
                      ],
                    ).paddingOnly(top: Dimensions.screenHeight / 4.69),
                  )
                ],
              ),
            ),
          ),
        )));
  }
}
