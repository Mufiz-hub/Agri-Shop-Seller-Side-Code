import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_final_year_seller/const/const.dart';

class HomeController extends GetxController {
  var navIndex = 0.obs;
  @override
  void onInit() {
    getUserName();
    super.onInit();
  }

  var userName = '';

  getUserName() async {
    var n = await firestore
        .collection(vendorCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    userName = n;
    print(userName);
  }
}
