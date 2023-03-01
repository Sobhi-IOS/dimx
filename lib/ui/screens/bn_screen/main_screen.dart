import 'dart:async';
import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/get/network_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/bottom_navigation_screen.dart';
import 'package:dimax/ui/screens/app/cart_product_screen.dart';
import 'package:dimax/ui/screens/bn_screen/category_screen.dart';
import 'package:dimax/ui/screens/bn_screen/home_screen.dart';
import 'package:dimax/ui/screens/bn_screen/offers_screen.dart';
import 'package:dimax/ui/screens/bn_screen/settings_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/no_internet_connection_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static void changePageIndex({required BuildContext context, required int index,}) {
    _MainScreenState _myAppState = context.findAncestorStateOfType<_MainScreenState>()!;
    _myAppState.changeIndex(index);
  }

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> with Helper{


  int _currentSelect = 0;
  StreamSubscription? streamSubscription ;

  @override
  void initState() {
    refreshToken();
    super.initState();
  }

  @override
  void dispose() {
    if(streamSubscription != null) streamSubscription!.cancel();
    super.dispose();
  }



  changeIndex(int index){
    setState(() {
      _currentSelect = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationScreen> screens =  <BottomNavigationScreen>[
      BottomNavigationScreen(title: 'home'.tr, widget: HomeScreen()),
      BottomNavigationScreen(title: 'category'.tr, widget: const CategoryScreen()),
      BottomNavigationScreen(title: 'offers'.tr, widget: const OffersScreen()),
      BottomNavigationScreen(title: 'settings'.tr, widget: const ProfileSettingsScreen()),
    ];


    return GetX<InterNetGetController>(builder: (controller) {
      return controller.hasNetwork.value ? Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentSelect,
            selectedItemColor: PRIMARY_COLOR,
            unselectedLabelStyle: TextStyle(fontFamily: getFontFamily(), fontSize: getFontSize(14)),
            selectedLabelStyle: TextStyle(fontFamily: getFontFamily(), fontSize: getFontSize(14), fontWeight: FontWeight.bold),
            onTap: (selectItem) {
              setState(() {
                _currentSelect = selectItem;
              });
            },
            items:  [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/home_ic.svg',
                  height: 24.h,width: 24.h,
                  color: _currentSelect == 0 ? PRIMARY_COLOR : Colors.grey,
                ),
                label: 'home'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/category.svg',
                  height: 24.h,width: 24.h,
                  color: _currentSelect == 1 ? PRIMARY_COLOR : Colors.grey,
                ),
                label: 'category'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/offer.svg',
                  height: 24.h,width: 24.h,
                  color: _currentSelect == 2 ? PRIMARY_COLOR:Colors.grey,
                ),
                label: 'offers'.tr,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/profile_ic.svg',
                  height: 24.h,width: 24.h,
                  color: _currentSelect == 3 ? PRIMARY_COLOR:Colors.grey,
                ),
                label: 'settings'.tr,
              ),
            ],
          ),

          appBar: AppBar(
            centerTitle: true,
            title: AppTextWidget(
              content: screens[_currentSelect].title,
              color: PRIMARY_TEXT_COLOR,
              fontSize: 20,
            ),
            actions: _currentSelect == 0 ?
            [
            GetX<CartGetController>(
              builder: (controller) {
                return Visibility(
                  visible: SharedPreferencesController().loggedIn,
                  child: GestureDetector(
                    onTap: (){
                      Get.to(const CartProductScreen());
                    },
                    child: SizedBox(
                      width: 40.w,
                      child: Stack(
                        children: [
                          PositionedDirectional(child: Icon(Icons.shopping_cart,color: Colors.black,size: 25.h),top: 0,bottom: 0,start: 5.w,end: 5.w,),
                          PositionedDirectional(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(3.h),
                              decoration: const BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                              child: AppTextWidget(content: controller.count.value.toString(),color: Colors.white,fontSize: 12,),)
                            ,start: 2.w,
                            top: 5.h,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            ]: null,
          ),
          body: screens[_currentSelect].widget):const Scaffold(body: NoInternetConnectionWidget(),
      backgroundColor: Colors.white,);
    },);
  }


  Future<void> refreshToken() async{
    streamSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
      ApiController().refreshToken(oldFcm: SharedPreferencesController().getFcmToken, newFcm: newToken);
    });
  }

}

