import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/controllers/products_controller.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
            child: DropdownButton(
                hint: normalText(text: "$hint", color: fontGrey),
                value: dropvalue.value == '' ? null : dropvalue.value,
                isExpanded: true,
                items: list.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: e.toString().text.make(),
                  );
                }).toList(),
                onChanged: (newvalue) {
                  if (hint == "Category") {
                    controller.subcategoryValue.value = '';
                    controller.populateSubCaegory(newvalue.toString());
                  }
                  dropvalue.value = newvalue.toString();
                }))
        .box
        .white
        .padding(EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
