import 'package:flutter/material.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

Widget customTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    style: TextStyle(color: whiteColor),
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: whiteColor),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: lightGrey)),
  );
}
