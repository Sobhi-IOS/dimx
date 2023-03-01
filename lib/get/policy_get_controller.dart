import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/address_model.dart';
import 'package:get/get.dart';


class PolicyGetController extends GetxController {
  final ApiController apiController = ApiController();
  String? policy;
  String? conditional;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static PolicyGetController get to => Get.find();

  @override
  void onInit() {
    getPage();
    super.onInit();
  }

  Future<void> getPage() async {
    loading.value = true;
    policy = await apiController.policy();
    conditional = await apiController.condition();
    loading.value = false;
    update();
  }

}
