import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/images.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/products_controller.dart';
import 'package:project_final_year_seller/services/store_serices.dart';
import 'package:project_final_year_seller/views/product_screen/add_new_product.dart';
import 'package:project_final_year_seller/views/product_screen/product_details.dart';
import 'package:project_final_year_seller/views/widgets/appbar_widget.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => AddNewProduct());
          },
          child: Icon(
            Icons.add,
            color: whiteColor,
          ),
          backgroundColor: purpleColor,
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
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
                    children: List.generate(
                      data.length,
                      (index) => ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(
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
                            text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(
                                text: "${data[index]['p_price']}",
                                color: darkFontGrey),
                            10.widthBox,
                            boldText(
                                text: data[index]['is_featured']
                                    ? "Featured"
                                    : '',
                                color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                            arrowSize: 0.0,
                            child: Icon(Icons.more_vert_rounded),
                            menuBuilder: () => Column(
                                  children: List.generate(
                                    popupMenuTitle.length,
                                    (i) => Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            popupMenuIcons[i],
                                            color: data[index]['featured_id'] ==
                                                        currentUser!.uid &&
                                                    i == 0
                                                ? green
                                                : darkFontGrey,
                                          ),
                                          10.widthBox,
                                          normalText(
                                              text: data[index]
                                                              ['featured_id'] ==
                                                          currentUser!.uid &&
                                                      i == 0
                                                  ? "Remove Feature"
                                                  : popupMenuTitle[i],
                                              color: darkFontGrey)
                                        ],
                                      ).onTap(() {
                                        switch (i) {
                                          case 0:
                                            if (data[index]['is_featured'] ==
                                                true) {
                                              controller.removeFeature(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Removed");
                                            } else {
                                              controller
                                                  .validateFeaturedProduct(data,
                                                      data[index].id, context);
                                            }
                                            break;
                                          case 1:
                                            break;
                                          case 2:
                                            controller
                                                .removeProduct(data[index].id);
                                            VxToast.show(context,
                                                msg: "Product Removed!");
                                            break;
                                          default:
                                        }
                                      }),
                                    ),
                                  ),
                                ).box.white.rounded.width(200).make(),
                            clickType: VxClickType.singleClick),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ));
  }
}
