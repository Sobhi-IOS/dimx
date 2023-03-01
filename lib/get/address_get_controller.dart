import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/address_model.dart';
import 'package:get/get.dart';


class AddressGetController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<AddressModel> address = <AddressModel>[].obs;
  RxBool loading = false.obs;
  RxBool complete = false.obs;
  static AddressGetController get to => Get.find();


  Future<void> getAddress() async {
    loading.value = true;
    address.value = await apiController.getAllAddress();
    complete.value = address.isNotEmpty;
    loading.value = false;
    update();
  }


  Future<void> deleteAddress({ required int addressId}) async {
    bool isDeleted = await apiController.deleteAddress(addressId: addressId);
    if (isDeleted) {
      int index = address.indexWhere((element) => element.id == addressId);
      address.removeAt(index);
    }
    address.refresh();
    update();
  }

  Future<bool> updateAddress({required AddressModel val}) async {
    bool isUpdated = await apiController.updateAddress(address: val);
    if (isUpdated) {
      int index = address.indexWhere((element) => element.id == val.id);
      address[index].name = val.name;
      address.refresh();
      update();
      return isUpdated;
    }
    return false;
  }

  Future<bool> createAddress({required AddressModel val}) async {
    AddressModel? newAddress = await apiController.createAddress( address: val);
    if (newAddress != null) {
      address.add(newAddress);
      complete.value = true;
      address.refresh();
      update();
      return true;
    }
    return false;
  }

}
