

import 'package:dimax/local_storage/shared_preferences.dart';

class ApiSettings {
  //auth
  static String login = 'http://dimaxapp.live/api/v1/auth/login?lang=${SharedPreferencesController().languageCode}';
  static String register = 'http://dimaxapp.live/api/v1/auth/register?lang=${SharedPreferencesController().languageCode}';
  static String forgetPassword = 'http://dimaxapp.live/api/v1/auth/forget_password?lang=${SharedPreferencesController().languageCode}';
  static String resetPassword = 'http://dimaxapp.live/api/v1/auth/reset_password?lang=${SharedPreferencesController().languageCode}';
  static String changePassword = 'http://dimaxapp.live/api/v1/change_password?lang=${SharedPreferencesController().languageCode}';
  static String removeAccount = 'http://dimaxapp.live/api/v1/delete-account?lang=${SharedPreferencesController().languageCode}';
  static String updateUserProfile = 'http://dimaxapp.live/api/v1/update_profile?lang=${SharedPreferencesController().languageCode}';
  static String categories = 'http://dimaxapp.live/api/v1/categories?lang=${SharedPreferencesController().languageCode}';
  static String offers = 'http://dimaxapp.live/api/v1/offers?lang=${SharedPreferencesController().languageCode}';
  static String subCategories ({required int categoryId}) => 'http://dimaxapp.live/api/v1/sub_categories/$categoryId?lang=${SharedPreferencesController().languageCode}';
  static String products ({required int subCategoryId}) => 'http://dimaxapp.live/api/v1/sub_category/$subCategoryId/products?lang=${SharedPreferencesController().languageCode}';
  static String productDetails ({required int productId}) => 'http://dimaxapp.live/api/v1/product_details/$productId?lang=${SharedPreferencesController().languageCode}';
  static String favorite = 'http://dimaxapp.live/api/v1/favorites?lang=${SharedPreferencesController().languageCode}';
  static String addToFavorite = 'http://dimaxapp.live/api/v1/add_favorite?lang=${SharedPreferencesController().languageCode}';
  static String contactUs = 'http://dimaxapp.live/api/v1/send_contact?lang=${SharedPreferencesController().languageCode}';
  static String address = 'http://dimaxapp.live/api/v1/all_addresses?lang=${SharedPreferencesController().languageCode}';
  static String updateAddress = 'http://dimaxapp.live/api/v1/update_address?lang=${SharedPreferencesController().languageCode}';
  static String addAddress = 'http://dimaxapp.live/api/v1/add_address?lang=${SharedPreferencesController().languageCode}';
  static String deleteAddress ({required int addressId}) => 'http://dimaxapp.live/api/v1/address/$addressId?lang=${SharedPreferencesController().languageCode}';
  static String home = 'http://dimaxapp.live/api/v1/home?lang=${SharedPreferencesController().languageCode}';
  static String addToCart = 'http://dimaxapp.live/api/v1/add_cart?lang=${SharedPreferencesController().languageCode}';
  static String getCart = 'http://dimaxapp.live/api/v1/get_cart?lang=${SharedPreferencesController().languageCode}';
  static String removeFromCart = 'http://dimaxapp.live/api/v1/remove_from_cart?lang=${SharedPreferencesController().languageCode}';
  static String removeAllFromCart = 'http://dimaxapp.live/api/v1/remove_all_fromc_cart?lang=${SharedPreferencesController().languageCode}';
  static String updateCartItem = 'http://dimaxapp.live/api/v1/update_quantity?lang=${SharedPreferencesController().languageCode}';
  static String countCartItem = 'http://dimaxapp.live/api/v1/count_item_in_cart?lang=${SharedPreferencesController().languageCode}';


  static String sendCode = 'http://dimaxapp.live/api/v1/send_code?lang=${SharedPreferencesController().languageCode}';
  static String activationAccount = 'http://dimaxapp.live/api/v1/activation_account?lang=${SharedPreferencesController().languageCode}';
  static String checkOut = 'http://dimaxapp.live/api/v1/checkout?lang=${SharedPreferencesController().languageCode}';

  static String order = 'http://dimaxapp.live/api/v1/user_orders?lang=${SharedPreferencesController().languageCode}';
  static String orderDetails ({required int orderID}) => 'http://dimaxapp.live/api/v1/order_Details/$orderID?lang=${SharedPreferencesController().languageCode}';


  static String policy = 'http://dimaxapp.live/api/v1/static_pages?flag=privacy';
  static String condations = 'http://dimaxapp.live/api/v1/static_pages?flag=Terms_and_Conditions';

  static String cancelOrder = 'http://dimaxapp.live/api/v1/rejected_order?lang=${SharedPreferencesController().languageCode}';

  static String refreshToken = 'http://dimaxapp.live/api/v1/refresh-fcm';
  static String removeFcmToken = 'http://dimaxapp.live/api/v1/remove-fcm?fcm=${SharedPreferencesController().getFcmToken}';

}
