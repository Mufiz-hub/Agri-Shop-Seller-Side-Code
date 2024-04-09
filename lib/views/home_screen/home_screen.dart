import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/orders_controller.dart';
import 'package:project_final_year_seller/services/store_serices.dart';
import 'package:project_final_year_seller/views/product_screen/product_details.dart';
import 'package:project_final_year_seller/views/widgets/appbar_widget.dart';
import 'package:project_final_year_seller/views/widgets/dashboard_button.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        dashboardButton(
                          context,
                          title: order,
                          count: "${Get.find<OrderController>().orders.length}",
                          icon: icOrders,
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(
                          context,
                          title: rating,
                          count: "0",
                          icon: icStar,
                        ),
                        dashboardButton(
                          context,
                          title: totalSales,
                          count: "30",
                          icon: icOrders,
                        ),
                      ],
                    ),
                    10.heightBox,
                    Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                        data.length,
                        (index) => data[index]['p_wishlist'] == 0
                            ? SizedBox()
                            : ListTile(
                                onTap: () {
                                  Get.to(ProductDetails(
                                    data: data[index],
                                  ));
                                },
                                leading: Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: normalText(
                                    text: "${data[index]['p_price']}",
                                    color: darkFontGrey),
                              ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
