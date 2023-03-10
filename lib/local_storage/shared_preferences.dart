// import 'package:demax/models/user_model.dart';
import 'package:dimax/api/api_controller.dart';
import 'package:dimax/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {

  static SharedPreferencesController instance = SharedPreferencesController._();
  late SharedPreferences sharedPreferences;

  SharedPreferencesController._();

  factory SharedPreferencesController() {
    return instance;
  }

  Future<void> initSharedPreference() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // for language
  String get languageCode => sharedPreferences.getString('language_code') ?? 'en';
  Future<bool> setLanguage(String languageCode) async =>  await sharedPreferences.setString('language_code', languageCode);

  // for check the first time use or not
  bool get isFirstTime => sharedPreferences.getBool('is_first_time') ?? true;
  Future<bool> setIsFirstTime(bool state) async => await sharedPreferences.setBool('is_first_time', state);




  String get token => sharedPreferences.getString('token') ?? '';
  bool get loggedIn => sharedPreferences.getBool('logged_in') ?? false;
  bool get isUser => sharedPreferences.getBool('isUser') ?? false;
  bool get isMarketed => sharedPreferences.getBool('isMarketed') ?? false;

  String get getFcmToken => sharedPreferences.getString('fcmToken') ?? '';
  Future<bool> setFcmToken(String token) async {
    return await sharedPreferences.setString('fcmToken', token);
  }

  Future<void> saveUser({required UserModel userModel,bool isUser = false, bool isMarketed = false}) async {
    await sharedPreferences.setBool('logged_in', true);
    await sharedPreferences.setBool('isUser', isUser);
    await sharedPreferences.setBool('isMarketed', isMarketed);
    await sharedPreferences.setInt('id', userModel.id??-1);
    await sharedPreferences.setString('name', userModel.name??'');
    await sharedPreferences.setString('email', userModel.email??'');
    await sharedPreferences.setString('emailVerifiedAt', userModel.emailVerifiedAt??'');
    await sharedPreferences.setString('createdAt', userModel.createdAt??'');
    await sharedPreferences.setString('updatedAt', userModel.updatedAt??'');
    await sharedPreferences.setString('mobile', userModel.mobile??'');
    await sharedPreferences.setString('image', userModel.image??'');
    await sharedPreferences.setString('code', userModel.code??'');
    await sharedPreferences.setString('dob', userModel.dob??'');
    await sharedPreferences.setString('gender', userModel.gender??'');
    await sharedPreferences.setString('fcmToken', userModel.fcmToken??'');
    await sharedPreferences.setInt('type', userModel.type??-1);
    await sharedPreferences.setString('address', userModel.address??'');
    await sharedPreferences.setString('activationCode', userModel.activationCode??'');
    await sharedPreferences.setBool('activationStatus', userModel.activationStatus??false);
    await sharedPreferences.setString('token', userModel.token??'');
  }

  UserModel get userModel {
    UserModel userModel = UserModel();
    userModel.id = sharedPreferences.getInt('id')??-1;
    userModel.name = sharedPreferences.getString('name')??'';
    userModel.email = sharedPreferences.getString('email')??'';
    userModel.emailVerifiedAt = sharedPreferences.getString('emailVerifiedAt')??'';
    userModel.createdAt = sharedPreferences.getString('createdAt')??'';
    userModel.updatedAt = sharedPreferences.getString('updatedAt')??'';
    userModel.mobile = sharedPreferences.getString('mobile')??'';
    userModel.image = sharedPreferences.getString('image')??'';
    userModel.code = sharedPreferences.getString('code')??'';
    userModel.dob = sharedPreferences.getString('dob')??'';
    userModel.gender = sharedPreferences.getString('gender')??'';
    userModel.fcmToken = sharedPreferences.getString('fcmToken')??'';
    userModel.type = sharedPreferences.getInt('type')??-1;
    userModel.address = sharedPreferences.getString('address')??'';
    userModel.activationCode = sharedPreferences.getString('activationCode')??'';
    userModel.activationStatus = sharedPreferences.getBool('activationStatus')??false;
    userModel.token = sharedPreferences.getString('token')??'';
    return userModel;
  }




  // for logout
  Future<bool> logout() async {
    if(await ApiController().removeFcmToken()){
      bool firstTime = isFirstTime;
      String language = languageCode;
      String fcm = getFcmToken;
      bool status = await sharedPreferences.clear();
      setIsFirstTime(firstTime);
      setLanguage(language);
      setFcmToken(fcm);
      return status;
    }
    return false;
  }
}
