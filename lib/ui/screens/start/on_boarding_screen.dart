import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_button.dart';
import 'package:dimax/ui/widgets/on_boarding_indicator.dart';
import 'package:dimax/ui/widgets/on_boarding_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with Helper{
  int currentIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            children: [
              OnBoardingWidget(
                title: 'title1'.tr,
                subTitle: 'sub_title1'.tr,
                image: 'shop',
              ),
              OnBoardingWidget(
                title: 'title2'.tr,
                subTitle: 'sub_title2'.tr,
                image: 'shop2',
              ),
              OnBoardingWidget(
                title: 'title3'.tr,
                subTitle: 'sub_title3'.tr,
                image: 'shop3',
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Visibility(
              visible: currentIndex != 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 45.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextButton(
                        text: 'skip'.tr,
                        fontWeight: FontWeight.normal,
                        textColor: PRIMARY_TEXT_COLOR,
                        onPressed: skip,
                    fontSize: 18,),
                    Row(
                      children: [
                        OnBoardingIndicator(
                          isSelected: currentIndex == 0,
                        ),
                        OnBoardingIndicator(
                          isSelected: currentIndex == 1,
                        ),
                        OnBoardingIndicator(
                          isSelected: currentIndex == 2,
                        ),
                      ],
                    ),
                    AppTextButton(
                      text: 'next'.tr,
                      fontWeight: FontWeight.normal,
                      textColor: PRIMARY_COLOR,
                      onPressed: goToNextPage,
                      fontSize: 18,
                    ),
                  ],
                ),
              ),
              replacement: Padding(
                padding: EdgeInsets.symmetric(horizontal: 117.w, vertical: 45.h),
                child: AppElevatedButton(
                  onPressed: (){
                    loginGuest(context);
                  },
                  text: 'get_start'.tr,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void skip() {
    pageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 800),
      curve: Curves.fastOutSlowIn,
    );
  }

  void goToNextPage() {
    if (currentIndex != 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.fastOutSlowIn,
      );
    }
  }


  void loginGuest(context) async{
    bool status = await checkInternet(context);
    if(status){
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      bool statusLogin = await AuthGetController.to.guestLogin(newFcm: fcmToken!);
      if(statusLogin){
        SharedPreferencesController().setIsFirstTime(false);
        bool store = await SharedPreferencesController().setFcmToken(fcmToken);
        if(store){
          Get.off(const MainScreen());
        }
      }

    }else{
      showSnackBar(context, text: 'يرجى التحقق من الاتصال بالانترنت');
    }
  }
}