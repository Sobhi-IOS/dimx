import 'package:dimax/firebase/fb_notifications.dart';
import 'package:dimax/firebase_options.dart';
import 'package:dimax/get/app_locale.dart';
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/start/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SharedPreferencesController().initSharedPreference();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await FbNotifications.initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  AuthGetController authGetController = Get.put(AuthGetController());


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context,child) => GetMaterialApp(
        title: 'Dimax',
        locale: Locale(SharedPreferencesController().languageCode),
        translations: AppLocale(),
        debugShowCheckedModeBanner: false,
        home: const LaunchScreen(),
        // home: const OnBoardingScreen(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black)
          ),
        ),
      ),
    );
  }
}
