import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fresh_om_seller/const/const.dart';
import 'package:fresh_om_seller/controllers/chats_controller.dart';
import 'package:fresh_om_seller/services/firestore_services.dart';
import 'package:fresh_om_seller/utils/reusable_circular_indicator.dart';
import 'package:fresh_om_seller/widgets/chats_bubble.dart';

import '../../utils/reusable_big_text.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainAppColor,
        foregroundColor: white,
        elevation: 0,
        title: BigText(
          text: "${controller.friendName}",
          fontWeight: FontWeight.w600,
          size: Dimensions.fontSize18,
          color: white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.height10),
        child: Column(
          children: [
            Obx(() => controller.isLoading.value
                ? Container(
                    child: progressIndicator(mainAppColor),
                  )
                : Expanded(
                    child: StreamBuilder(
                      stream: FireStoreServices.getMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return progressIndicator(mainAppColor);
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "Send a message..."
                                .text
                                .color(Colors.black54)
                                .make(),
                          );
                        } else {
                          return ListView(
                              physics: const BouncingScrollPhysics(),
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var data = snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid'] ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: chatBubble(data));
                              }).toList());
                        }
                      },
                    ),
                  )),
            SizedBox(
              height: Dimensions.height10,
            ),
            SizedBox(
              height: Dimensions.height60,
              child: Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainAppColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainAppColor)),
                        hintText: "Enter Message",
                        border: InputBorder.none),
                  )),
                  IconButton(
                    onPressed: () {
                      controller.sendMSg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(Icons.send),
                    color: mainAppColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
