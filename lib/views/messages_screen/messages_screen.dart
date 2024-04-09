import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/services/store_serices.dart';
import 'package:project_final_year_seller/views/messages_screen/chart_screen.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: darkFontGrey,
            ),
          ),
          title: boldText(text: messages, size: 16.0, color: fontGrey),
        ),
        body: StreamBuilder(
          stream: StoreServices.getMesseges(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return ListTile(
                          onTap: () {
                            Get.to(() => ChatScreen());
                          },
                          leading: CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: whiteColor,
                            ),
                          ),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: fontGrey),
                          subtitle: normalText(
                              text: "${data[index]['last_msg']}",
                              color: darkFontGrey),
                          trailing:
                              normalText(text: "${time}", color: darkFontGrey),
                        );
                      }),
                    ),
                  ));
            }
          },
        ));
  }
}
