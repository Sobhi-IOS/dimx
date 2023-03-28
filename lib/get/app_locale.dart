import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // onbording screen
      'get_start': 'Get started',
      'next': 'Next',
      'skip': 'Skip',
      'option': '(option)',


      'title1': 'Welcome',
      'sub_title1': 'Welcome to the Dimax app, we are very happy to have you join us',

      'title2': 'Browse products',
      'sub_title2': 'Browse all products available Ease by categories ',

      'title3': 'Ease of delivery',
      'sub_title3': 'Your products will be delivered to your door easily and quickly',

      //settings_screen
      'account':'account',
      'edit_profile':'Edit Profile',
      'change_password':'Change Password',
      'my_address':'My Address',
      'general':'general',
      'language':'Language',
      'contact_us':'Contact Us',
      'policy_policies':'Privacy Policies',
      'terms_and_conditions':'Terms And Conditions',
      'logout':'Logout',

      //forget_password
      'forget_password_title':'Forget Password',
      'forget_password_msg':'Please enter your Email address and we will  send you a code to your email  to rest the password',
      'send_code_msg': 'Your recovery code is being sent, please wait a moment',
      'continue':'Continue',

      //reset password
      'reset_password':'Reset Password',
      'reset_msg':'Enter 5 digit code verification, the code sent to your email',
      'confirm_password':'Confirm Password',
      'confirm_password_msg_error':'Password is not confirmed correctly!',

      //chang password
      'chang_password_msg':'To change the password, you must fill in these fields correctly',
      'new_password':'New Password',
      'old_password':'Old Password',
      'current_pass':'Current Password',

      //contact_us
      'contact_us_msg': 'Contact us if you need help or are having problems, we will respond as soon as possible',


      //main_screen
      'home':'Home',
      'category':'Category',
      'favorite':'Favorite',
      'order':'Orders',
      'settings':'Settings',
      'offers':'Offers',


      // validation msg
      'field_is_required': 'This field is required!',
      'enter_required_data': 'Enter required data!',
      'email_is_required': 'Email is required !',
      'password_is_required': 'Password is required !',
      'name_is_required': 'Name is required !',
      'mobile_is_required': 'Mobile is required !',
      'address_is_required': 'Address is required !',
      'birthday_is_required': 'Birthday is required !',

      'no_internet_connection': 'Oops! No Internet Connection',

      //auth
      'email': 'Email',
      'password': 'Password',
      'name': 'Name',
      'mobile': 'Mobile',
      'address': 'Address',
      'birthday': 'Birthday',
      'female': 'Female',
      'male': 'Male',
      'login': 'Login',
      'register': 'Register',
      'forget_password': 'Forgot password?',
      'dont_have_account': 'I don\'t have an account ?',
      'sign_up': 'Sign Up',
      'send': 'Send',
      'message': 'Message',

      //edit prfile
      'update': 'Update',

      //product_details
      'pc':'ps',
      'products':'Products',
      'description':'Description',
      'colors':'Colors',
      'sizes':'Sizes',
      'total_amount':'Total amount',
      'add_to_cart':'Add to cart',
      'see_more':'See More',
      'last_added':'Last Added',
      'special_product':'Special Products',

      'login_alert_title':'Alert',
      'login_alert_desc':'To use this feature, please login',
      'login_msg':'The data entered is being verified, please wait a moment',
      'server_error': 'Oops! Server Error 500',
      'oops':'Oops!',

      'addresses': 'Addresses',
      'saved_addresses' : 'Saved Addresses',
      'add_address':'Add Address',
      'delete':'Delete',
      'edit':'Edit',
      'add':'Add',
      'add_address_msg':'Add your addresses for easy access when making orders',

      'no_data':'No Data',
      'code':'code',

      // order
      'unlisted':'Unlisted',
      'order_id': 'Order ID',
      'view_details': 'View Details',
      'items': 'Items',
      'total': 'Invoice value',
      'discount': 'Discount',
      'deserved_amount': 'Deserved amount',
      'color': 'color',
      'size': 'size',
      'quantity': 'quantity',
      'note': 'Note',
      'features':'Features',




      'items_available': 'Items Available',
      'cart': 'Items Available',
      'cart_total': 'Total',
      'checkout': 'CheckOut',

      'activate_account_dialog_title': 'Activate your account',
      'activate_account_dialog_msg': 'Please activate your account to ensure the quality and completion of the process',
      'send_code': 'Send Code',

      'activate_account': 'Activate Account',
      'activate_account_msg': 'The activation code has been sent to your email address',

      'confirm_order': 'Confirm Order',
      'code_optional': 'Code (Optional)',
      'note_optional': 'Note (Optional)',
      'confirm_order_msg': 'Are you sure? To confirm the request, click continue',

      'successfully': 'operation accomplished successfully',
      'successfully_msg': 'The process has been completed successfully. You will receive your order as soon as possible. Thank you',

      'operation_failed': 'The operation failed',
      'operation_failed_msg': 'Operation failed. Something went wrong.',
      'cancel_order': 'Cancel Order',
      'cancel': 'Cancel',
      'cancel_msg': 'The order cannot be canceled, the order is in process',
      '401_msg': 'The session has expired, please log in again',
      'aed': 'AED',
      'order_details': 'Order Details',
      'close': 'Close',

      'new': 'New',
      'pending': 'Pending',
      'progress': 'Progress',
      'complete': 'Complete',
      'cancel_o': 'Cancel',
      'logout_msg': 'You are being logged out. Please wait a moment',
      'search': 'Search',


      'remove_account': 'Delete Account',
      'remove_account_msg': 'ِALERT if the account is deleted, you cannot recover the account data.',

    },
    'ar': {
      // onbording screen
      'get_start': 'أبدا الآن',
      'next': 'التالي',
      'skip': 'تخطي',
      'option': '(اختياري)',
      'title1': 'مرحباً بك',
      'sub_title1': 'مرحباً بك في تطبيق ديماكس نحن سعداء جداً لانضممامك لنا',

      'title2': 'تصفح المنتجات',
      'sub_title2': 'تصفح المنتجات المتاحة بكل سهولة حسب الفئات',

      'title3': 'سهولة التوصيل',
      'sub_title3': 'منتجاتك ستصلك الي باب بيتك بكل سهولة وسرعة',

      //settings_screen
      'account':'اعدادات الحساب',
      'edit_profile':'تعديل الملف الشخصي',
      'change_password':'تغير كلمة المرور',
      'my_address':'العناوين الخاصة بي',
      'general':'اعدادات عامة',
      'language':'اللغة',
      'contact_us':'تواصل معنا',
      'logout':'تسجيل خروج',
      'policy_policies':'سياسات الخصوصية',
      'terms_and_conditions':'الشروط والاحكام',

      //forget_password
      'forget_password_title':'استرجاع كلمة المرور',
      'forget_password_msg':' من فضلك قم بادخال البريد الالكتروني الخاص بك لارسال كود الاسترجاع للتتمكن من تغير كلمة المرور',
      'continue':'متابعة',
      'send_code_msg': 'يتم الان ارسال كود الاسترجاع الخاص بك يرجى الانتظار قليلاً',

      //reset password
      'reset_password':'اعادة تعين كلمة المرور',
      'reset_msg':'ادخل كود التفعيل المكون من 5 ارقام والذي تم ارساله الى بريدك الالكتروني',
      'confirm_password':'تأكيد كلمة المرور',
      'confirm_password_msg_error':'كلمة المرور غير متطابقة',


      //chang password
      'chang_password_msg':'لتغير كلمة المرور يجب عليك ان تقوم بملئ هذة الحقول بشكل صحيح',
      'new_password':'كلمة المرور الجديدة',
      'old_password':'كلمة المرور القديمة',

      //contact_us
      'contact_us_msg': 'اتصل بنا إذا كنت بحاجة إلى مساعدة أو كنت تواجه مشاكل ، وسنرد عليك في أقرب وقت ممكن',


      //main_screen
      'home':'الرئيسية',
      'category':'الفئات',
      'favorite':'المفضلة',
      'order':'الطلبات',
      'settings':'الاعدادات',
      'offers':'العروض',

      // validation msg
      'field_is_required': 'هذا الحقل مطلوب',
      'enter_required_data': 'ادخل البيانات المطلوبة',
      'email_is_required': 'ادخل البريد الالكتروني',
      'password_is_required': 'ادخال كلمة المرور',

      'name_is_required': 'ادخال اسم المستخدم',
      'mobile_is_required': 'ادخال رقم الهاتف',
      'address_is_required': 'ادخال العنوان',
      'birthday_is_required': 'ادخال تاريخ الميلاد',
      'no_internet_connection': 'خطأ! لايوجد اتصال بالانترنت',

      //auth
      'email': 'البريد الالكتروني',
      'password': 'كلمة المرور',
      'name': 'الأسم',
      'mobile': 'رقم الهاتف',
      'address': 'العنوان',
      'birthday': 'تاريخ الميلاد',
      'female': 'أنثى',
      'male': 'ذكر',

      'login': 'تسجيل الدخول',
      'register': 'تسجيل',

      'forget_password': 'نسيت كلمة المرور؟',
      'dont_have_account': 'لا امتلك حساب',
      'sign_up': 'تسجيل',
      'send': 'أرسال',
      'message': 'الرسالة',

      //edit prfile
      'update': 'تعديل',


      //product_details
      'pc':'قطعة',
      'products':'المنتجات',
      'description':'الوصف',
      'colors':'الألوان',
      'sizes':'المقاسات',
      'total_amount':'المجموع',
      'add_to_cart':'أضافة الى السلة',
      'see_more':'المزيد',
      'last_added':'المضافة مؤخرا',
      'special_product':'منتجات مميزة',
      'features':'المواصفات',

      'login_alert_title':'تنبية!',
      'login_alert_desc':'لاستخدام هذة الخاصية من فضلك قم بتسجيل الدخول',

      'login_msg':'يتم التحقق من البيانات التي تم إدخالها ، يرجى الانتظار قليلاً',
      'server_error': 'يوجد عطل بالخادم الرجاء المحاولة فيما بعد',
      'oops':'نأسف!',

      'addresses': 'العناوين',
      'saved_addresses' : 'العناوين المحفوظة',
      'delete':'حذف',
      'edit':'تعديل',
      'add_address':'أضافة عنوان',
      'add':'أضافة',
      'no_data':'لا يوجد بيانات',
      'add_address_msg':'قم باضفة العنواوين الخاصة بك وذالك لسهولة الوصول لها عند عمل الطلبيات ',


      'code':'الرمز',

      'unlisted':'غير مدرج',
      'order_id': 'رقم الطلبية',
      'view_details': 'رؤية التفاصيل',
      'items': 'عدد العناصر',
      'total': 'قيمة الفاتورة',
      'discount': 'نسبة الخصم',
      'deserved_amount': 'المبلغ المستحق',
      'color': 'اللون',
      'size': 'المقاس',
      'quantity': 'الكمية',
      'note': 'الملاحظات',



      'items_available': 'العناصر الموجودة',
      'cart': 'السلة',
      'cart_total': 'المجموع',
      'checkout': 'انشاء الطلبية',

      'activate_account_dialog_title': 'تفعيل الحساب',
      'activate_account_dialog_msg': 'يرجى تفعيل حسابك لضمان جودة العملية واستكمالها',
      'send_code': 'ارسال الرمز',

      'activate_account': 'تفعيل الحساب',
      'activate_account_msg': 'لقد تم ارسال رمز التفعيل الى عنوان بريدك الالكتروني',

      'confirm_order': 'تأكيد الطلبية',
      'code_optional': 'كود الخصم (اختياري)',
      'note_optional': 'ملاحظات (اختياري)',
      'confirm_order_msg': 'هل انت متأكد, لتاكيد الطلب اضغط تاكيد.',

      'successfully': 'تمت العملية بنجاح',
      'successfully_msg': 'تمت بنجاح العملية بنجاح ستصلك طلبيتك في اقرب وقت شكراً لك',

      'operation_failed': 'فشلت العملية!',
      'operation_failed_msg': 'فشلت العملية هنالك خطأ ما..',
      'cancel_order': 'الغاء الطلبية',
      'cancel': 'الغاء',
      'cancel_msg': 'لا يمكن الغاء الطلبية ،  الطلبية قيد التجهيز',
      '401_msg': 'الجلسة انتهت يرجى تسجيل الدخول من جديد',
      'aed': 'درهم',
      'order_details': 'تفاصيل الطلبية',
      'close': 'اغلاق',


      'new': 'طلبيات \nجديدة',
      'pending': 'قيد \nالتجهيز',
      'progress': ' قيد \nالتوصيل',
      'complete': 'تم \nالتوصيل',
      'cancel_o': 'طلبيات \nملغية',

      'logout_msg': 'يتم الان تسجيل لخروج من فضلك انتظر قليلاً',
      'search': 'بحث',
      'remove_account': 'حذف الحساب',
      'remove_account_msg': 'تنبيه إذا تم حذف الحساب ، لا يمكنك استعادة بيانات الحساب.',
      'current_pass':'كلمة المرور الحالية',
    }
  };
  static void changeLang() {
    String newLanguageCode = SharedPreferencesController().languageCode == 'en' ? 'ar' : 'en';
    Get.updateLocale(Locale(newLanguageCode));
    SharedPreferencesController().setLanguage(newLanguageCode);
  }
}
