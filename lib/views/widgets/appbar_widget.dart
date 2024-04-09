import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: whiteColor,
    automaticallyImplyLeading: false,
    title: boldText(
      text: title,
      size: 16.0,
      color: fontGrey,
    ),
    actions: [
      Center(
          child: normalText(
              text: intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
              color: purpleColor)),
      10.widthBox,
    ],
  );
}
