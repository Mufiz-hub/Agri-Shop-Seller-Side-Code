import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_final_year_seller/const/const.dart';

class OrderController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var ondeliery = false.obs;
  var deliverd = false.obs;
  getOrders(data) {
    orders.clear();

    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(ordersCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
