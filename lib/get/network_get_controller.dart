import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dimax/get/address_get_controller.dart';
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/get/category_get_controller.dart';
import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/get/home_getx_controller.dart';
import 'package:dimax/get/offers_get_controller.dart';
import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/get/policy_get_controller.dart';
import 'package:dimax/get/product_get_controller.dart';
import 'package:dimax/get/sub_category_get_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:get/get.dart';

class InterNetGetController extends GetxController{

  static InterNetGetController get to => Get.find();
  RxBool hasNetwork =false.obs;
  late Connectivity _connectivity;
  RxInt state = 0.obs;



  startMonitoring() async{
    _connectivity = Connectivity();
    _connectivity.onConnectivityChanged.listen((result) async{
      if(result == ConnectivityResult.none){
        hasNetwork.value=false;
        state.value = 1;
      }else{
        Get.put(HomeGetController());
        Get.put(CategoryGetController());
        Get.put(OfferGetController());
        Get.put(AuthGetController());
        Get.put(PolicyGetController());
        Get.put(SubCategoryGetController());
        Get.put(ProductGetController());
        Get.put(CartGetController());
        Get.put(OrderGetController());
        Get.put(AddressGetController());
        Get.put(FavoriteGetController());
        hasNetwork.value=true;
        refresh();
      }
    });
  }

  @override
  void onInit() {
    startMonitoring();
    super.onInit();
  }
}