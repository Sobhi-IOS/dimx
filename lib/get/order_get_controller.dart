import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/models/order_details.dart';
import 'package:dimax/models/order_model.dart';
import 'package:get/get.dart';


class OrderGetController extends GetxController with Helper{
  final ApiController apiController = ApiController();
  RxList<OrderModel> orders = <OrderModel>[].obs;
  RxList<OrderModel> filterOrder = <OrderModel>[].obs;
  OrderDetailsModel? orderDetailsModel;
  RxBool loading = false.obs;
  RxBool complete = false.obs;

  RxBool loadingOrderDetails = false.obs;
  RxBool completeOrderDetails = false.obs;

  static OrderGetController get to => Get.find();


  Future<void> getOrder() async {
    loading.value = true;
    orders.value = await apiController.getOrder();
    filterOrder.value = orders;
    complete.value = orders.isNotEmpty;
    loading.value = false;
  }

  Future<bool> checkOut({String? code, String? note,required int addressId}) async {
    if(await checkInternet(Get.context)){
      bool status = await apiController.checkOut(code: code, note: note, addressId: addressId);
      if(status){
        CartGetController.to.removeAll();
      }
      return status;
    }
    return false;
  }


  Future<void> getOrderDetails({required int id}) async {
    loadingOrderDetails.value = true;
    orderDetailsModel = await apiController.getOrderDetails(id: id);
    completeOrderDetails.value = (orderDetailsModel != null);
    loadingOrderDetails.value = false;
    update();
  }


  List<OrderModel> filterList(int state){
    switch (state){
      case 1 :
        return orders.where((p0) => p0.status == 'new Order' || p0.status == 'طلبية جديدة' ).toList();
      case 2 :
        return orders.where((p0) => p0.status == 'Pending' || p0.status == 'قيد التحضير' ).toList();
      case 3 :
        return orders.where((p0) => p0.status == 'Delivery in progress' || p0.status == 'قيد التوصيل' ).toList();
      case 4 :
        return orders.where((p0) => p0.status == 'Delivered' || p0.status == 'تم التوصيل' ).toList();
      case 5 :
        return orders.where((p0) => p0.status == 'cancel' || p0.status == 'تم الإلغاء' ).toList();
      default:
        return[];
    }
  }

   void search(String val){
    filterOrder.value = orders.where((p0) {
        return p0.invoiceNumber  != null ? p0.invoiceNumber!.contains(val):false;
    }).toList();

  }


  Future<String> cancelOrder({required int id}) async {
    if (await checkInternet(Get.context)) {
      return await apiController.cancelOrder(id: id);
    }
    return '';
  }
}
