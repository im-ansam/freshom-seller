import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;

Widget chatBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h,mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: data['uid'] == currentUser!.uid
            ? BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20))
            : BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.size(16).color(white).semiBold.make(),
          const SizedBox(
            height: 10,
          ),
          time.text.size(14).color(white).make(),
        ],
      ),
    ),
  );
}
