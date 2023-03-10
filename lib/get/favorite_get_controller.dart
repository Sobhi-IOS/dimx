import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/home_getx_controller.dart';
import 'package:dimax/get/offers_get_controller.dart';
import 'package:dimax/get/product_get_controller.dart';
import 'package:dimax/models/product_model.dart';
import 'package:get/get.dart';


class FavoriteGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<ProductModel> favoriteProduct = <ProductModel>[].obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static FavoriteGetController get to => Get.find();


  Future<void> getFavorite() async {
    loading.value = true;
    favoriteProduct.value = await apiController.getFavoriteProducts();
    complete.value = favoriteProduct.isNotEmpty;
    loading.value = false;
    update();
  }


  Future<void> addFavoriteProducts({required ProductModel product}) async {
    bool status = await apiController.addFavoriteProducts(id: product.id!);
    if(status){
      if(product.isFavorite!){
        favoriteProduct.remove(product);
        ProductGetController.to.changeState(product.id!);
        OfferGetController.to.changeState(product.id!);
        HomeGetController.to.addToFavorite(product.id!, false);
        if(favoriteProduct.isEmpty){
          complete.value = false;
        }
      }else{
        favoriteProduct.add(product);
        ProductGetController.to.changeState(product.id!);
        OfferGetController.to.changeState(product.id!);
        HomeGetController.to.addToFavorite(product.id!, true);
      }
      update();
      favoriteProduct.refresh();
    }
  }

}
