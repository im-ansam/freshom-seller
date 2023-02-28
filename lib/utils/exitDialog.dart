import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_om_seller/const/colors.dart';
import 'package:fresh_om_seller/utils/reusable_big_text.dart';

import '../const/dimensions.dart';

Widget exitDialog(context) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      padding: EdgeInsets.all(Dimensions.height12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          color: lightGreen2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BigText(
            fontWeight: FontWeight.w600,
            text: "Confirm",
            color: mainAppColor,
            size: Dimensions.fontSize25,
          ),
          const Divider(),
          SizedBox(
            height: Dimensions.height10,
          ),
          BigText(
            fontWeight: FontWeight.w600,
            text: "Are you sure you want to exit?",
            color: Colors.black54,
            size: Dimensions.fontSize16,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainAppColor)),
                child: BigText(
                  fontWeight: FontWeight.w600,
                  text: "Yes",
                  color: Colors.white,
                  size: Dimensions.fontSize14,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(mainAppColor)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: BigText(
                  fontWeight: FontWeight.w600,
                  text: "No",
                  color: Colors.white,
                  size: Dimensions.fontSize14,
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
