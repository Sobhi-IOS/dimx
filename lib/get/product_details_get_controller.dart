
import 'package:dimax/api/api_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/product_details_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsGetController extends GetxController with Helper{
  final ApiController apiController = ApiController();
  Rx<ProductDetailsModel?> productDetails = ProductDetailsModel().obs;
  RxList<ProductDetailsModel> favoriteProducts = <ProductDetailsModel>[].obs;

  RxBool loading = false.obs;
  RxBool complete = false.obs;

  static ProductDetailsGetController get to => Get.find();


  Future<void> getProductDetails({required int productId}) async {
    loading.value = true;
    productDetails.value = await apiController.getProductDetails(productId: productId);
    complete.value = (productDetails.value != null);
    loading.value = false;
    update();
  }

  Future<void> addFavoriteProducts({required ProductDetailsModel product,required BuildContext context}) async {
    if(SharedPreferencesController().loggedIn){
      bool status = await apiController.addFavoriteProducts(id: product.id!);
      if(status){
        productDetails.value!.isFavorite = !(productDetails.value!.isFavorite!);
        productDetails.refresh();
      }
    }
    productDetails.refresh();
    update();
  }
}

