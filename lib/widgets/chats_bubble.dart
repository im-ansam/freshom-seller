import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;

import '../utils/reusable_big_text.dart';

Widget chatBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h,mma").format(t);
  return Directionality(
    textDirection: data['uid'] == FirebaseAuth.instance.currentUser!.uid
        ? TextDirection.rtl
        : TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(Dimensions.height12),
      margin: EdgeInsets.only(bottom: Dimensions.width8),
      decoration: BoxDecoration(
        color: mainAppColor,
        borderRadius: data['uid'] == FirebaseAuth.instance.currentUser!.uid
            ? BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
                bottomLeft: Radius.circular(Dimensions.radius20))
            : BorderRadius.only(
                topRight: Radius.circular(Dimensions.radius20),
                topLeft: Radius.circular(Dimensions.radius20),
                bottomRight: Radius.circular(Dimensions.radius20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(
            text: "${data['msg']}",
            fontWeight: FontWeight.w600,
            size: Dimensions.fontSize16,
            color: white,
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          time.text.size(Dimensions.fontSize14).color(white).make(),
        ],
      ),
    ),
  );
}
