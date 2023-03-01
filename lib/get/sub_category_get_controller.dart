
import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/product_get_controller.dart';
import 'package:dimax/models/sub_category_model.dart';
import 'package:get/get.dart';

class SubCategoryGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<SubCategoryModel> subCategories = <SubCategoryModel>[].obs;
  RxBool loading = false.obs;

  static SubCategoryGetController get to => Get.find();

  Future<void> getSubCategories({required int categoryId}) async {
    loading.value = true;
    ProductGetController.to.loading.value =true;
    subCategories.value = await apiController.getSubCategory(categoryId: categoryId);
    ProductGetController.to.getProduct(subCategoryId: subCategories.first.id!);
    subCategories.first.isSelect = true;
    update();
  }

  changeState(int subCategoryId) {
    for (var element in subCategories) {
      if (element.id == subCategoryId) {
        element.isSelect = true;
        ProductGetController.to.getProduct(subCategoryId: subCategoryId);
      }else{
        element.isSelect = false;
      }
    }
    subCategories.refresh();
  }
}
