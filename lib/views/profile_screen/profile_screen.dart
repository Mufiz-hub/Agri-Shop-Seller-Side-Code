import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_final_year_seller/common_widget/loading_indicator.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/auth_controller.dart';
import 'package:project_final_year_seller/controllers/profile_controller.dart';
import 'package:project_final_year_seller/services/store_serices.dart';
import 'package:project_final_year_seller/views/auth_screen/login_screen.dart';
import 'package:project_final_year_seller/views/messages_screen/messages_screen.dart';
import 'package:project_final_year_seller/views/profile_screen/edit_screen.dart';
import 'package:project_final_year_seller/views/shop_setting/shop_setting_screen.dart';
import 'package:project_final_year_seller/views/widgets/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: setting, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: Icon(
                  Icons.edit,
                  color: whiteColor,
                )),
            TextButton(
                onPressed: () async {
                  Get.find<AuthController>().signOutMethod(context);
                  Get.offAll(() => LoginScreen());
                },
                child: normalText(text: logout))
          ],
        ),
        body: FutureBuilder(
            future: StoreServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(circleColor: whiteColor);
              } else {
                controller.snapshotData = snapshot.data!.docs[0];

                return Column(
                  children: [
                    ListTile(
                      leading: controller.snapshotData['imageUrl'] == ''
                          ? Image.asset(
                              imgProduct,
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.network(
                              controller.snapshotData['imageUrl'],
                              width: 100,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                      title: boldText(
                          text: "${controller.snapshotData['vendor_name']}"),
                      subtitle: normalText(
                          text: "${controller.snapshotData['email']}"),
                    ),
                    Divider(),
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: List.generate(
                            profileButtonIcons.length,
                            (index) => ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => ShopSetting());
                                        break;
                                      case 1:
                                        Get.to(() => MessagesScreen());

                                        break;
                                      default:
                                    }
                                  },
                                  leading: Icon(
                                    profileButtonIcons[index],
                                    color: whiteColor,
                                  ),
                                  title: normalText(
                                      text: profileButtonTitle[index]),
                                )),
                      ),
                    )
                  ],
                );
              }
            }));
  }
}
