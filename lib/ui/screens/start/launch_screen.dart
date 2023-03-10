import 'package:dimax/firebase/fb_notifications.dart';
import 'package:dimax/get/network_get_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/app/marketed_main_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/screens/start/on_boarding_screen.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen>with FbNotifications{

  late Widget route;

  @override
  void initState() {
    super.initState();
    Get.put(InterNetGetController());
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    if(SharedPreferencesController().isFirstTime){
      route = const OnBoardingScreen();
    }
    else {
      route =SharedPreferencesController().isMarketed ? const MarektedMainScreen() :const MainScreen();
    }
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(route);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: Image.asset('assets/images/launch.jpg',height: double.infinity,width: double.infinity,),
    );
  }
}



