
import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/get/sub_category_get_controller.dart';
import 'package:dimax/models/product_model.dart';
import 'package:get/get.dart';

class ProductGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<ProductModel> products = <ProductModel>[].obs;

  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static ProductGetController get to => Get.find();

  Future<void> getProduct({required int subCategoryId}) async {
    loading.value = true;
    products.value = await apiController.getProduct(subCategoryId: subCategoryId);
    complete.value = products.isNotEmpty;
    loading.value = false;
    SubCategoryGetController.to.loading.value = false;
    update();
  }


  changeState(int id){
    int index = products.indexWhere((element) => element.id == id);
    if(index != -1){
      products.elementAt(index).isFavorite = !products.elementAt(index).isFavorite!;
      products.refresh();
      update();
    }
  }

}
