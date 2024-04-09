import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_final_year_seller/const/color.dart';
import 'package:project_final_year_seller/const/images.dart';
import 'package:project_final_year_seller/const/string.dart';
import 'package:project_final_year_seller/controllers/home_controllers.dart';
import 'package:project_final_year_seller/views/home_screen/home_screen.dart';
import 'package:project_final_year_seller/views/orders_screen/order_screen.dart';
import 'package:project_final_year_seller/views/product_screen/products_screen.dart';
import 'package:project_final_year_seller/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrderScreen(),
      ProfileScreen(),
    ];

    var bottomNavBar = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkFontGrey,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkFontGrey,
          ),
          label: order),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
            width: 24,
            color: darkFontGrey,
          ),
          label: setting),
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          items: bottomNavBar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkFontGrey,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            ),
          ],
        ),
      ),
    );
  }
}
