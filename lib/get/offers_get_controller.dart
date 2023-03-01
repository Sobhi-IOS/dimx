import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/product_model.dart';
import 'package:get/get.dart';


class OfferGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<ProductModel> offers = <ProductModel>[].obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static OfferGetController get to => Get.find();

  @override
  void onInit() {
    getOffer();
    super.onInit();
  }


  Future<void> getOffer() async {
    loading.value = true;
    offers.value = await apiController.getProductOffers();
    complete.value = offers.isNotEmpty;
    loading.value = false;
    update();
  }

   changeState(int id){
    int index = offers.indexWhere((element) => element.id == id);
    if(index != -1){
      offers.elementAt(index).isFavorite = !offers.elementAt(index).isFavorite!;
      offers.refresh();
      update();
    }
  }

}
