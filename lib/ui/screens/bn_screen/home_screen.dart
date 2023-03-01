import 'package:carousel_slider/carousel_slider.dart';
import 'package:dimax/get/home_getx_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/homeModel.dart';
import 'package:dimax/ui/screens/app/product_details_screen.dart';
import 'package:dimax/ui/screens/app/sub_category_screen.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_home_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:dimax/ui/widgets/no_data_widget.dart';
import 'package:dimax/ui/widgets/product_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return GetX<HomeGetController>(
      builder: (HomeGetController controller) {
        return controller.loading.value ? const HomeShimmerScreen() :
        controller.complete.value ? RefreshIndicator(
          onRefresh: ()=> controller.initHome(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: controller.home.value!.sliders!.isNotEmpty,
                  child: SizedBox(
                    height: 150.h,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150.h,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: controller.home.value!.sliders!.map((Sliders slider) {
                        return Builder(builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: (){
                              if(slider.productId != null){
                                Get.to(ProductDetailsScreen(id: slider.productId!));
                              }
                            },
                            child: NetworkImageWidget(
                                height: 150.h,
                                width: double.infinity,
                                image: SharedPreferencesController().languageCode == 'en' ? slider.imageEn! : slider.imageAr!),
                          );
                        },
                        );
                      }).toList(),
                    ),
                  ),
                ),


                SizedBox(height: 5.h,),

                Visibility(
                  visible: controller.home.value!.categories!.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextWidget(content: 'category'.tr,fontSize: 16),
                        GestureDetector(
                          child: AppTextWidget(content: 'see_more'.tr,textDecoration: TextDecoration.underline,fontSize: 16,),
                          onTap: ()=> MainScreen.changePageIndex(context: context, index: 1),
                        ),
                      ],
                    ),
                  ),
                ),


                Visibility(
                  visible: controller.home.value!.categories!.isNotEmpty,
                  child: SizedBox(
                    height: 235.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.home.value!.categories!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              this.index = index;
                            });
                          },
                          child: SizedBox(
                            width: 165.w,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  NetworkImageWidget(
                                    height: 172.h,
                                    width: double.infinity,
                                    boxFit: BoxFit.contain,
                                    image: controller.home.value!.categories!.elementAt(index).image!,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.w,
                                        right: 2.w,
                                        top: 5.h,
                                        bottom: 5.h),
                                    child: AppTextWidget(
                                      content: SharedPreferencesController().languageCode == 'en'
                                          ? controller.home.value!.categories!.elementAt(index).nameEn!
                                          : controller.home.value!.categories!.elementAt(index).nameAr!,
                                      fontSize: 16,
                                      color: PRIMARY_TEXT_COLOR,
                                      fontWeight: FontWeight.w500,
                                      line: 1,
                                      // line: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 5.h,),
                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .specials!.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        AppTextWidget(content: 'special_product'.tr,fontSize: 16),],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),


                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .specials!.isNotEmpty,
                  child: SizedBox(
                    height: 280.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.home.value!.categories!
                          .elementAt(index)
                          .specials!
                          .length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 177.w,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            child: ProductWidget(
                              product: controller.home.value!.categories!
                                  .elementAt(this.index)
                                  .specials!
                                  .elementAt(index),
                              onTap: () => Get.to(ProductDetailsScreen(
                                id: controller.home.value!.categories!
                                    .elementAt(this.index)
                                    .specials!
                                    .elementAt(index).id!,)),

                            ),
                          ),
                        );

                      },
                    ),
                  ),
                ),


                SizedBox(height: 5.h,),
                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .offers!.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        AppTextWidget(content: 'offers'.tr,fontSize: 16,),
                        GestureDetector(
                          child: AppTextWidget(content: 'see_more'.tr,textDecoration: TextDecoration.underline,fontSize: 16,),
                          onTap: () {
                            MainScreen.changePageIndex(context: context, index: 2);
                          },
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),


                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .offers!.isNotEmpty,
                  child: SizedBox(
                    height: 280.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.home.value!.categories!
                          .elementAt(index)
                          .offers!
                          .length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 177.w,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 3.h),
                            child: ProductWidget(
                                product: controller.home.value!.categories!
                                    .elementAt(this.index)
                                    .offers!
                                    .elementAt(index),
                                onTap: () => Get.to(ProductDetailsScreen(
                                  id: controller.home.value!.categories!
                                      .elementAt(this.index)
                                      .offers!
                                      .elementAt(index).id!,
                                ),)
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 5.h,),
                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .lastProducts!.isNotEmpty,
                  child: Padding(
                    padding: EdgeInsets.all(10.h),
                    child: Row(
                      children: [
                        AppTextWidget(content: 'last_added'.tr,fontSize: 16,),
                        GestureDetector(child: AppTextWidget(content: 'see_more'.tr,fontSize: 16,textDecoration: TextDecoration.underline),
                            onTap: ()=>Get.to(SubCategoryScreen(categoryId: controller.home.value!.categories!.first.id!))),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.home.value!.categories!
                      .elementAt(index)
                      .lastProducts!.isNotEmpty,
                  child: SizedBox(
                    height: 280.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.home.value!.categories!
                          .elementAt(index)
                          .lastProducts!
                          .length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            width: 177.w,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 3.h),
                              child: ProductWidget(
                                product: controller.home.value!.categories!.elementAt(this.index).lastProducts!.elementAt(index),
                                onTap: () => Get.to(ProductDetailsScreen(id: controller.home.value!.categories!.elementAt(this.index).lastProducts!.elementAt(index).id!,),
                                ),
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ) : const Center(child: NoDataWidget(),);
      },
    );
  }

}
