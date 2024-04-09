import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/products_controller.dart';
import 'package:project_final_year_seller/views/product_screen/componants/product_dropdown.dart';
import 'package:project_final_year_seller/views/product_screen/componants/product_images.dart';
import 'package:project_final_year_seller/views/product_screen/product_details.dart';
import 'package:project_final_year_seller/views/widgets/custome_textfeld.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
          title: boldText(text: "Add Product", size: 16.0, color: fontGrey),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: whiteColor)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.uploadImages();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: save, color: fontGrey))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. BMW",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                customTextField(
                    hint: "eg. \$100",
                    label: "Price",
                    controller: controller.ppriceController),
                10.heightBox,
                customTextField(
                    hint: "eg. 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                productDropdown('Category', controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropdown('SubCategory', controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                Divider(),
                boldText(text: "Choose product image"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImgsLists[index] != null
                          ? Image.file(
                              controller.pImgsLists[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImg(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImg(index, context);
                            }),
                    ),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
