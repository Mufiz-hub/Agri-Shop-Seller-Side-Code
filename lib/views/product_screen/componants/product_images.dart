import 'package:flutter/material.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
