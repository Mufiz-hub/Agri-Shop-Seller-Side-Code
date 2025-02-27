import "package:flutter/material.dart";
import "package:project_final_year_seller/const/color.dart";
import "package:project_final_year_seller/const/const.dart";
import "package:project_final_year_seller/views/widgets/text_style.dart";

Widget dashboardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title, size: 16.0),
            boldText(text: count, size: 20.0),
          ],
        ),
      ),
      Image.asset(
        icon,
        width: 40,
        color: whiteColor,
      ),
    ],
  )
      .box
      .color(purpleColor)
      .rounded
      .size(size.width * 0.4, 80)
      .padding(EdgeInsets.all(8))
      .make();
}
