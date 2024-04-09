import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

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
        title: boldText(text: "${data['p_name']}", color: fontGrey),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxSwiper.builder(
              autoPlay: true,
              height: 350,
              aspectRatio: 3,
              viewportFraction: 1.0,
              itemCount: data['p_imgs'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(text: "${data['p_name']}", color: fontGrey),
                10.heightBox,
                Row(
                  children: [
                    boldText(
                        text: "${data['p_category']}",
                        color: fontGrey,
                        size: 16.0),
                    10.widthBox,
                    normalText(
                        text: "${data['p_subcategory']}",
                        color: fontGrey,
                        size: 16.0),
                  ],
                ),
                10.heightBox,
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectImage: golden,
                  count: 5,
                  size: 25,
                  maxRating: 5,
                ),
                10.heightBox,
                boldText(
                    text: "${data['p_price']}", color: redColor, size: 18.0),
                10.heightBox,
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: boldText(text: "Quantity", color: fontGrey),
                    ),
                    normalText(
                        text: "${data['p_quantity']} items", color: fontGrey),
                  ],
                )
              ],
            ).box.padding(EdgeInsets.all(8)).white.make(),
          ),
          Divider(),
          20.heightBox,
          boldText(text: "Description"),
          10.heightBox,
          normalText(text: "${data['p_desc']}", color: fontGrey),
        ],
      ),
    );
  }
}
