import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/orders_controller.dart';
import 'package:project_final_year_seller/services/store_serices.dart';
import 'package:project_final_year_seller/views/orders_screen/order_detail.dart';
import 'package:project_final_year_seller/views/widgets/appbar_widget.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controlller = Get.put(OrderController());
    return Scaffold(
        appBar: appbarWidget(order),
        body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        onTap: () {
                          Get.to(() => OrderDetails(data: data[index]));
                        },
                        tileColor: textfieldGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        title: boldText(
                            text: "${data[index]['order_code']}",
                            color: purpleColor),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_month),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat()
                                        .add_yMd()
                                        .format(time),
                                    color: fontGrey)
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.payment),
                                10.widthBox,
                                boldText(text: unpaid, color: redColor)
                              ],
                            ),
                          ],
                        ),
                        trailing: boldText(
                            text: "${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                      ).box.margin(EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          },
        ));
  }
}
