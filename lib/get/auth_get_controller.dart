import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/address_get_controller.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/user_model.dart';
import 'package:get/get.dart';

class AuthGetController extends GetxController with Helper {
  ApiController apiController = ApiController();

  static AuthGetController get to => Get.find();
  Rx<UserModel> userModel = UserModel().obs;


  @override
  void onInit() {
    if (SharedPreferencesController().loggedIn){
      userModel.value = SharedPreferencesController().userModel;
    }
    super.onInit();
  }


  Future<bool> login({required context,required String email, required String password, required String fcmToken,}) async {
    if(await checkInternet(context)){
      showCustomDialog(context: context, title: 'login'.tr, description: 'login_msg'.tr,);
      var user = await apiController.login(context, email: email, password: password, fcmToken: fcmToken);
      Get.put(AddressGetController());
      Get.put(CartGetController());
      Get.put(OrderGetController());
      Get.put(FavoriteGetController());
      dismissDialog(context: context);
      if(user != null){
          userModel.value = user;
          return true;
      }
    }
    return false;
  }


  Future<bool> register({ required String name, required String email, required String mobile, required String password, required String address, required String gender, required String dob, required String passwordConfirmation,}) async {
    if (await checkInternet(Get.context)) {
      showCustomDialog(context: Get.context, title: 'register'.tr, description: 'login_msg'.tr,);
      bool status = await apiController.register( name: name, email: email, mobile: mobile, password: password, address: address, gender: gender, dob: dob, passwordConfirmation: passwordConfirmation);
      dismissDialog(context: Get.context);
      return status;
    }
    return false;
  }

  Future<bool> forgetPassword( {required String email}) async {
    bool status = false;
    showCustomDialog(context: Get.context, title: 'forget_password_title'.tr, description: 'send_code_msg'.tr,);
    if(await checkInternet(Get.context)) {
      status = await apiController.forgetPassword(email: email);
      dismissDialog(context: Get.context);
    }
    return status;
  }


  Future<bool> resetPassword( {required String password,required String code}) async {
    bool status = false;
    showCustomDialog(context: Get.context, title: 'forget_password_title'.tr , description: 'login_msg'.tr,);
    if(await checkInternet(Get.context)) {
      status = await apiController.resetPassword(code: code, password: password);
      dismissDialog(context: Get.context);
    }
    return status;
  }

  Future<bool> changePassword({required String currentPassword,required String newPassword}) async {
    bool status = false;
    if(await checkInternet(Get.context)) {
      showCustomDialog(context: Get.context, title: 'change_password'.tr, description:  'login_msg'.tr,);
      status = await apiController.changePassword(currentPassword: currentPassword, newPassword: newPassword);
      dismissDialog(context: Get.context);
    }
    return status;
  }

  Future<bool> updateUserProfile({required String name, required String email, required String mobile, required String address, required String gender, required String dob, required String image}) async{
    bool status = false;
    if(await checkInternet(Get.context)) {
      showCustomDialog(context: Get.context,
        title: 'edit_profile'.tr,
        description: 'login_msg'.tr,);
      await apiController.updateUserProfile(
          name: name,
          email: email,
          mobile: mobile,
          address: address,
          gender: gender,
          dob: dob,
          image: image,
          uploadEvent: (UserModel? user){
            if(user != null){
              userModel.value.image = user.image;
              userModel.value.name = user.name;
              userModel.value.email = user.email;
              userModel.value.mobile = user.mobile;
              userModel.value.address = user.address;
              userModel.value.gender = user.gender;
              userModel.value.dob = user.dob;
              UserModel userUpdated = UserModel();
              userUpdated = SharedPreferencesController().userModel;
              userUpdated.image = user.image;
              userUpdated.name = user.name;
              userUpdated.email = user.email;
              userUpdated.mobile = user.mobile;
              userUpdated.address = user.address;
              userUpdated.gender = user.gender;
              userUpdated.dob = user.dob;
              SharedPreferencesController().saveUser(userModel: userUpdated);
              userModel.refresh();
            }
          });
      dismissDialog(context: Get.context);
    }
    return status;
  }


  Future<bool> contactUs({required String name, required String phone, required String msg}) async{
    bool status = false;
    if(await checkInternet(Get.context)) {
      status = await apiController.contactUS( phone: phone, name: name, msg: msg);
    }
    return status;
  }


  Future<bool> sendCodeActivate() async{
    bool status = false;
    if(await checkInternet(Get.context)) {
      status = await apiController.sendCodeActivate();
    }
    return status;
  }

  Future<bool> activateAccount({required String code}) async{
    bool status = false;
    if(await checkInternet(Get.context)) {
      status = await apiController.activateAccount(code: code);
      if(status){
        userModel.value.activationStatus = status;
        UserModel newuser = userModel.value;
        newuser.activationStatus = status;
        SharedPreferencesController().saveUser(userModel: newuser);
      }
    }
    return status;
  }


  Future<bool> logout() async{
    if (await checkInternet(Get.context)) {
      showCustomDialog(context: Get.context, title: 'logout'.tr, description: 'logout_msg'.tr,);
      bool status = await SharedPreferencesController().logout();
      dismissDialog(context: Get.context);
      return status;
    }
    return false;
  }

  Future<bool> guestLogin({required String newFcm}) async {
    bool status = await apiController.loginGuest(newFcm: newFcm);
    return status;
  }



}