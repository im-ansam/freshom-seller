import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/chats_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/utils/reusable_text.dart';

import 'package:fresh_om_seller/views/message_screens/chat_screen.dart';
import 'package:intl/intl.dart' as intl;

class MessagesList extends StatelessWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: nicePurple,
        backgroundColor: mainBackGround,
        elevation: 0,
        title: messages.text
            .size(Dimensions.fontSize18)
            .color(nicePurple)
            .semiBold
            .make(),
      ),
      backgroundColor: mainBackGround,
      body: StreamBuilder(
        stream: FireStoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return progressIndicator(nicePurple);
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: headingText(
                  text: "No messages found",
                  fontSize: Dimensions.fontSize20,
                  color: nicePurple),
            );
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: EdgeInsets.all(Dimensions.width8),
              child: Column(
                  children: List.generate(data.length, (index) {
                var t = data[index]['created_on'] == null
                    ? DateTime.now()
                    : data[index]['created_on'].toDate();
                var time = intl.DateFormat("h:mma").format(t);
                return Card(
                  color: Colors.grey.shade200,
                  child: ListTile(
                    dense: true,
                    onTap: () {
                      Get.to(() => ChatScreen(), arguments: [
                        data[index]['sender_name'],
                        data[index]['fromId'],
                      ]);
                    },
                    leading: CircleAvatar(
                      backgroundColor: Vx.randomColor,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: "${data[index]['sender_name']}"
                        .text
                        .bold
                        .color(nicePurple)
                        .size(16)
                        .make(),
                    subtitle: "${data[index]['last_msg']}"
                        .text
                        .semiBold
                        .color(Colors.grey[500])
                        .size(Dimensions.fontSize15)
                        .make(),
                    trailing: time.text.semiBold
                        .color(Colors.black54)
                        .size(Dimensions.fontSize16)
                        .make(),
                  ),
                );
              })),
            );
          }
        },
      ),
    );
  }
}