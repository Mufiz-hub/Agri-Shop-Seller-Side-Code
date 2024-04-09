import 'dart:io';
import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_final_year_seller/const/const.dart';
import 'package:project_final_year_seller/controllers/home_controllers.dart';
import 'package:project_final_year_seller/models/category_model.dart'
    as MyCategory;

class ProductsController extends GetxController {
  var isLoading = false.obs;
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();
  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<MyCategory.Category> category = [];
  var pImagesLinks = [];
  var pImgsLists = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = MyCategory.categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCaegory(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat);
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImg(index, context) async {
    try {
      var img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImgsLists[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    if (pImgsLists != null) {
      for (var item in pImgsLists) {
        if (item != null) {
          // Check if item is not null
          var filename = basename(item.path);
          var destination = 'images/vendors/${currentUser!.uid}/$filename';
          Reference ref = FirebaseStorage.instance.ref().child(destination);
          await ref.putFile(item);
          var n = await ref.getDownloadURL();
          pImagesLinks.add(n);
        }
      }
    }
  }
  // uploadImages() async {
  //   pImagesLinks.clear();
  //   for (var item in pImgsLists) {
  //     if (pImgsLists != null) {
  //       var filename = basename(item.path);
  //       var destination = 'images/vendors/${currentUser!.uid}/$filename';
  //       Reference ref = FirebaseStorage.instance.ref().child(destination);
  //       await ref.putFile(item);
  //       var n = await ref.getDownloadURL();
  //       pImagesLinks.add(n);
  //     }
  //   }
  // }

  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_desc': pdescController.text,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_rating': '5.0',
      'p_seller': Get.find<HomeController>().userName,
      'p_subcategory': subcategoryValue.value,
      'p_wishlist': FieldValue.arrayUnion([]),
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isLoading(false);
    VxToast.show(context, msg: 'Product Uploded Successfully!');
  }

  addFeature(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': currentUser!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removeFeature(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': '', 'is_featured': false}, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productCollection).doc(docId).delete();
  }

  validateFeaturedProduct(data, docID, context) {
    bool hasFeaturedCategory = false;

    for (var item in data) {
      if (item['featured_id'] != null && item['featured_id'] != '') {
        // A featured category already exists
        hasFeaturedCategory = true;
        break; // No need to check further, exit the loop
      }
    }

    if (!hasFeaturedCategory) {
      // No featured category found, allow adding one
      addFeature(docID);
      VxToast.show(context, msg: "Added");
    } else {
      VxToast.show(context, msg: "You Can Add Featured Product only once");
    }
  }
}
