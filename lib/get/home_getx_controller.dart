import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/homeModel.dart';
import 'package:get/get.dart';


class HomeGetController extends GetxController {
  final ApiController apiController = ApiController();
  Rx<HomeModel?> home  = HomeModel().obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static HomeGetController get to => Get.find();


  @override
  void onInit() {
    initHome();
    super.onInit();
  }


  Future<void> initHome() async {
    loading.value = true;
    HomeModel? h = await apiController.initHome();
    if( h != null){
      home.value =h;
      complete.value = true;
    }
    loading.value = false;
    update();
  }

  addToFavorite(int id, status){
    for(int i = 0 ; i< home.value!.categories!.length; i++){
      for(int j = 0 ; j< home.value!.categories!.elementAt(i).lastProducts!.length; j++){
        if(id == home.value!.categories!.elementAt(i).lastProducts!.elementAt(j).id){
          home.value!.categories!.elementAt(i).lastProducts!.elementAt(j).isFavorite = status;
          home.refresh();
        }
      }
      for(int j = 0 ; j< home.value!.categories!.elementAt(i).offers!.length; j++){
        if(id == home.value!.categories!.elementAt(i).offers!.elementAt(j).id){
          home.value!.categories!.elementAt(i).offers!.elementAt(j).isFavorite = status;
          home.refresh();
        }
      }
      for(int j = 0 ; j< home.value!.categories!.elementAt(i).specials!.length; j++){
        if(id == home.value!.categories!.elementAt(i).specials!.elementAt(j).id){
          home.value!.categories!.elementAt(i).specials!.elementAt(j).isFavorite = status;
          home.refresh();
        }
      }
    }
  }

}