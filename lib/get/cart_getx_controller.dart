import 'package:dimax/api/api_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/product_details_model.dart';
import 'package:get/get.dart';


class CartGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<ProductDetailsModel> cartProduct = <ProductDetailsModel>[].obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  RxInt total = 0.obs;
  RxInt count = 0.obs;
  static CartGetController get to => Get.find();


  @override
  void onInit() {
    if(SharedPreferencesController().loggedIn){
      getCartProduct();
    }
    super.onInit();
  }

  Future<void> getCartProduct() async {
    loading.value = true;
    cartProduct.value = await apiController.getCartProducts();
    complete.value = cartProduct.isNotEmpty;
    getTotal();
    count.value = cartProduct.length;
    loading.value = false;
    update();
  }


  Future<void> deleteCartItem({ required int productId}) async {
    bool isDeleted = await apiController.removeFromCart(productId: productId);
    if (isDeleted) {
      int index = cartProduct.indexWhere((element) => element.id == productId);
      cartProduct.removeAt(index);
      getTotal();
      count.value = count.value-1;
      if(cartProduct.isEmpty){
        complete.value = false;
      }
    }
    cartProduct.refresh();
    update();
  }

  Future<bool> updateCartItem({ required int productId,required int quantity}) async {
    bool updated = await apiController.updateCartItem( quantity: quantity, productId: productId);
    if (updated) {
      int index = cartProduct.indexWhere((element) => element.id == productId);
      cartProduct[index].quantity = quantity;
      getTotal();
      cartProduct.refresh();
      update();
      return updated;
    }
    return false;
  }

  Future<bool> addItemToCart({ required int productId, required int quantity,required ProductDetailsModel productModel, String? color, String? size}) async {
    bool? created = await apiController.addToCart( quantity: quantity, productId: productId,color: color,size: size);
    if (created) {
      int index = cartProduct.indexWhere((element) => element.id == productId);
      if(index != -1){
        cartProduct[index].quantity = cartProduct[index].quantity! + quantity;
      }
      else{
        cartProduct.add(productModel);
      }
      getTotal();
      count.value = count.value+1;
      cartProduct.refresh();
      complete.value = true;
      return true;
    }
    return false;
  }

  Future<bool> removeAllFromCart() async {
    bool? deleted = await apiController.removeAllFromCart();
    if (deleted) {
      cartProduct.value = <ProductDetailsModel>[];
      getTotal();
      cartProduct.refresh();
      update();
      return true;
    }
    return false;
  }


  getTotal(){
    int total = 0;
    for(int i = 0; i<cartProduct.length;i++){
      if(cartProduct.elementAt(i).isOffer!){
        total = total + (cartProduct.elementAt(i).price!*cartProduct.elementAt(i).quantity!);
      }
      total = total + (cartProduct.elementAt(i).price!*cartProduct.elementAt(i).quantity!);
    }
    this.total.value = total;
  }

  removeAll(){
    cartProduct.value = [];
    count.value = 0;
    cartProduct.refresh();
    complete.value = false;
  }
}
