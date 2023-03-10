import 'dart:async';

import 'package:dimax/api/api_controller.dart';
import 'package:dimax/get/app_locale.dart';
import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/auth/change_password_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_order_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/chips_widget.dart';
import 'package:dimax/ui/widgets/drawer_widget.dart';
import 'package:dimax/ui/widgets/no_data_widget.dart';
import 'package:dimax/ui/widgets/order_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class MarektedMainScreen extends StatefulWidget {
  const MarektedMainScreen({Key? key}) : super(key: key);

  @override
  State<MarektedMainScreen> createState() => _MarektedMainScreenState();
}

class _MarektedMainScreenState extends State<MarektedMainScreen> with SingleTickerProviderStateMixin{

  late TabController tabController;
  late TextEditingController textEditingController;
  StreamSubscription? streamSubscription ;

  @override
  void initState() {
    refreshToken();
    tabController = TabController(length: 5, vsync: this);
    textEditingController = TextEditingController();
    OrderGetController.to.getOrder();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    textEditingController.dispose();
    if(streamSubscription != null) streamSubscription!.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: AppTextWidget(
          content: 'order'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TabBar(
                    indicatorColor: Colors.transparent,
                    labelPadding: EdgeInsets.all(1.h),
                    controller: tabController,
                    tabs: [
                      ChipsWidget(
                        title: 'new'.tr,
                        color: Colors.orangeAccent,
                      ),
                      ChipsWidget(
                        title: 'pending'.tr,
                        color: Colors.orange,
                      ),
                      ChipsWidget(
                        title: 'progress'.tr,
                        color: Colors.blueAccent,
                      ),

                      ChipsWidget(
                        title: 'complete'.tr,
                        color: Colors.green,
                      ),
                      ChipsWidget(
                        title: 'cancel_o'.tr,
                        color: Colors.red,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 15.h,
                  ),

                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      maxLines: 1,
                      controller: textEditingController,
                      onChanged: (String x){
                        setState(() {
                          OrderGetController.to.search(x);
                        });
                      },
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade50,
                        filled: true,
                        hintText: 'search'.tr,

                        suffixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),

                   GetX<OrderGetController>(builder: (controller) {
                    return BaseWidget(
                        lodgingWidget: Expanded(child: ShimmerOrderScreen()),
                        widget: textEditingController.text.isEmpty ? Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              controller.filterList(1).isNotEmpty ?
                              RefreshIndicator(
                                onRefresh: () => OrderGetController.to.getOrder(),
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return OrderWidget(orderModel: controller.filterList(1).elementAt(index));
                                },itemCount: controller.filterList(1).length,),
                              ) : const Center(child: NoDataWidget()),

                              controller.filterList(2).isNotEmpty ?
                              RefreshIndicator(
                                onRefresh: () => OrderGetController.to.getOrder(),
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return OrderWidget(orderModel: controller.filterList(2).elementAt(index));
                                },itemCount: controller.filterList(2).length,),
                              ) : const Center(child: NoDataWidget()),


                              controller.filterList(3).isNotEmpty ?
                              RefreshIndicator(
                                onRefresh: () => OrderGetController.to.getOrder(),
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return OrderWidget(orderModel: controller.filterList(3).elementAt(index));
                                },itemCount: controller.filterList(3).length,),
                              ) : const Center(child: NoDataWidget()),


                              controller.filterList(4).isNotEmpty ?
                              RefreshIndicator(
                                onRefresh: () => OrderGetController.to.getOrder(),
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return OrderWidget(orderModel: controller.filterList(4).elementAt(index));
                                },itemCount: controller.filterList(4).length,),
                              ) : const Center(child: NoDataWidget()),

                              controller.filterList(5).isNotEmpty ?
                              RefreshIndicator(
                                onRefresh: () => OrderGetController.to.getOrder(),
                                child: ListView.builder(itemBuilder: (context, index) {
                                  return OrderWidget(orderModel: controller.filterList(5).elementAt(index));
                                },itemCount: controller.filterList(5).length,),
                              ) : const Center(child: NoDataWidget()),

                            ],
                          ),
                        ):
                        Expanded(
                          child: ListView.builder(itemBuilder: (context, index) {
                            return OrderWidget(orderModel: OrderGetController.to.filterOrder.elementAt(index));
                          },itemCount: OrderGetController.to.filterOrder.length,),
                        ),
                        loading: controller.loading.value,
                        complete: controller.complete.value);
                  },)
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: SizedBox(
        width: 314.w,
        child: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade50,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                  ],
                )),
            child: Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: PRIMARY_COLOR,
                          child: AppTextWidget(
                            content: SharedPreferencesController().userModel.name != null ?
                            SharedPreferencesController().userModel.name![0].toUpperCase():'',
                            fontSize: 30.sp,
                          ),
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppTextWidget(
                                  content: 'name'.tr +':',
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppTextWidget(
                                  content: SharedPreferencesController().userModel.name??'',
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                AppTextWidget(
                                  content: 'code'.tr +':',
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                AppTextWidget(
                                  content: SharedPreferencesController().userModel.code??'',
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 70.h,),
                    DrawerWidget(
                      label: 'language'.tr,
                      onTap: () {
                        AppLocale.changeLang();
                      },
                    ),


                    DrawerWidget(
                        label: 'change_password'.tr,
                        onTap: ()=> Get.to(const ChangePasswordScreen())
                    ),

                    DrawerWidget(
                        label: 'logout'.tr,
                        onTap: () async {
                          bool status = await AuthGetController.to.logout();
                          if(status){
                            Get.offAll(const MainScreen());
                          }
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshToken() async{
    streamSubscription = FirebaseMessaging.instance.onTokenRefresh.listen((String newToken) {
      ApiController().refreshToken(oldFcm: SharedPreferencesController().getFcmToken, newFcm: newToken);
    });
  }
}
