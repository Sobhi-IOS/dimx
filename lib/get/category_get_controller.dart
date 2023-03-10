import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/category_model.dart';
import 'package:get/get.dart';


class CategoryGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static CategoryGetController get to => Get.find();

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Future<void> getCategory() async {
    loading.value = true;
    categories.value = await apiController.getCategory();
    complete.value = categories.isNotEmpty;
    loading.value = false;
    update();
  }
}
