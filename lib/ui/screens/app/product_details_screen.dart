import 'package:carousel_slider/carousel_slider.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/get/product_details_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/product_details_model.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_product_details_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;


  const ProductDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with Helper{

  ProductDetailsGetController productGetController = Get.put(ProductDetailsGetController());

  int cardIncrement = 1;

  List<String>? colorsEn;
  List<String>? colorsAr;
  List<String>? featuersEn;
  List<String>? featuersAr;
  List<String>? sizes;

  int sizeSelect = 0;
  int colorSelect = 0;


  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      await ProductDetailsGetController.to.getProductDetails(productId: widget.id).then((value) {
        if(ProductDetailsGetController.to.productDetails.value!.size != null){
          sizes = ProductDetailsGetController.to.productDetails.value!.size?.split(',').toList();
        }
        if(ProductDetailsGetController.to.productDetails.value!.colorAr != null
        &&ProductDetailsGetController.to.productDetails.value!.colorAr != null){
          colorsEn = ProductDetailsGetController.to.productDetails.value!.colorEn!.split(',').toList();
          colorsAr = ProductDetailsGetController.to.productDetails.value!.colorAr!.split(',').toList();
        }
        if(ProductDetailsGetController.to.productDetails.value!.descAdvanceAr != null
            &&ProductDetailsGetController.to.productDetails.value!.descAdvanceEn != null){
          featuersAr = ProductDetailsGetController.to.productDetails.value!.descAdvanceAr!.split(',').toList();
          featuersEn = ProductDetailsGetController.to.productDetails.value!.descAdvanceEn!.split(',').toList();
        }
      }
      );

    });
    super.initState();
  }

  @override
  void dispose() {
    productGetController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
        appBar: AppBar(),
        body: GetX<ProductDetailsGetController>(builder: (ProductDetailsGetController controller) {
          return controller.loading.value? const ShimmerProductDetailsScreen():
              controller.complete.value?
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 380.h,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                            height: 380.h,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true
                        ),
                        items: controller.productDetails.value!.images?.map((AppImages image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return NetworkImageWidget(
                                height: 380.h, width: double.infinity, image: image.src!,
                                boxFit: BoxFit.contain
                                ,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topRight:  Radius.circular(20.h),topLeft:  Radius.circular(20.h)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(0.1, 2),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ],
                        ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 25.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Expanded(
                                    child: AppTextWidget(
                                      content: SharedPreferencesController().languageCode == 'en'?controller.productDetails.value!.nameEn!:controller.productDetails.value!.nameAr!,
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      line: 2,
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () async {
                                      if(SharedPreferencesController().loggedIn){
                                        await ProductDetailsGetController.to.addFavoriteProducts(product: controller.productDetails.value!, context: context);
                                      }else{
                                        showAwesomeDialog(
                                            context: context,
                                            title: 'login_alert_title'.tr,
                                            desc: 'login_alert_desc'.tr,
                                            buttonText: 'login'.tr,
                                            onTap: ()=>Get.to(const LoginScreen())
                                        );
                                      }
                                      },
                                    child: Container(
                                      height: 52.h,
                                      width: 52.w,
                                      decoration: BoxDecoration(shape: BoxShape.circle, color: controller.productDetails.value!.isFavorite!?Colors.red:Colors.grey),
                                      child: const Icon(Icons.favorite, color: Colors.white,),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h,),
                              controller.productDetails.value!.isOffer! ?
                              AppTextWidget(
                                content: '${(controller.productDetails.value!.offerPrice!)} ' + 'aed'.tr,
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: getFontFamily(),
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                              ):
                              AppTextWidget(
                                content: '${controller.productDetails.value!.price} ' + 'aed'.tr,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.start,
                                decorationColor: Colors.red,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  AppTextWidget(
                                    content: '$cardIncrement '+'pc'.tr,
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    textAlign: TextAlign.start,
                                  ),


                                  Row(
                                    children: [
                                      FloatingActionButton.small(
                                        heroTag: "btn1",
                                        onPressed: (){
                                          setState(() {
                                            cardIncrement++;
                                          });
                                        },
                                        child: Icon(Icons.add,color: PRIMARY_COLOR,),
                                        backgroundColor: Colors.white,
                                      ),
                                      Container(
                                        width: 25.w,
                                        child: AppTextWidget(content: cardIncrement.toString(),),
                                        alignment: Alignment.center,
                                      ),
                                      FloatingActionButton.small(
                                        heroTag: "btn2",
                                        onPressed: (){
                                          setState(() {
                                            if(cardIncrement> 1){
                                              cardIncrement--;
                                            }
                                          });
                                        },
                                        child: const Icon(Icons.remove,color: PRIMARY_COLOR,),
                                        backgroundColor: Colors.white,
                                      )
                                    ],
                                  )

                                ],
                              ),

                              Divider(height: 25.h,color: Colors.grey.shade200,),


                              AppTextWidget(
                                content: 'description'.tr,
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: getFontFamily(),
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(height: 5.h,),

                                AppTextWidget(
                                  content: SharedPreferencesController().languageCode == 'en'? controller.productDetails.value!.descEn!:controller.productDetails.value!.descAr!,
                                  color: Colors.grey,
                                  fontSize: 14,
                                  textAlign: TextAlign.start,
                                ),

                              Divider(height: 25.h,color: Colors.grey.shade200,),


                              sizes!= null ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextWidget(
                                    content: 'sizes'.tr,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Row(
                                    children: sizes!.map((e) =>
                                        GestureDetector(
                                          onTap: (){
                                            sizeSelect = sizes!.indexOf(e);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20.w),
                                            margin: EdgeInsetsDirectional.only(end:5.h),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.h),
                                                border: Border.all(color: Colors.grey.shade200),
                                                color: sizes!.indexOf(e) == sizeSelect ? PRIMARY_COLOR :Colors.white
                                            ),
                                            child: AppTextWidget(content: e ,fontSize: 12,color:sizes!.indexOf(e) == sizeSelect ? Colors.white :Colors.black,fontWeight: FontWeight.normal,),
                                          ),
                                        )
                                    ).toList(),
                                  ),
                                  Divider(height: 25.h,color: Colors.grey.shade200,),
                                ],
                              ):Container(),

                              getColor() != null ?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextWidget(
                                    content: 'colors'.tr,
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                   Row(
                                    children: getColor()!.map((e) =>
                                        GestureDetector(
                                          onTap: (){
                                            colorSelect = getColor()!.indexOf(e);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                                            margin: EdgeInsetsDirectional.only(end:5.h),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8.h),
                                                border: Border.all(color: Colors.grey.shade200),
                                                color:getColor()!.indexOf(e) == colorSelect ? PRIMARY_COLOR :Colors.white
                                            ),
                                            child: AppTextWidget(content: e ,fontSize: 12,color:getColor()!.indexOf(e) == colorSelect ? Colors.white :Colors.black,fontWeight: FontWeight.normal,fontFamily: getFontFamily(),),
                                          ),
                                        )
                                    ).toList(),
                                  ),
                                  Divider(height: 25.h,color: Colors.grey.shade200,),
                                ],
                              ):Container(),

                              getfetuers() != null ?
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  AppTextWidget(
                                    content: 'featuers',
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  Row(
                                    children: getfetuers()!.map((e) =>
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                                          margin: EdgeInsetsDirectional.only(end:5.h),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.h),
                                              border: Border.all(color: Colors.grey.shade200),
                                              color: PRIMARY_COLOR
                                          ),
                                          child: AppTextWidget(content: e ,fontSize: 12,color: Colors.white,fontWeight: FontWeight.normal,fontFamily: getFontFamily(),),
                                        )
                                    ).toList(),
                                  ),
                                  Divider(height: 25.h,color: Colors.grey.shade200,),
                                ],
                              ):
                                Container(),



                              Row(children: [

                                AppTextWidget(
                                  content: 'total_amount'.tr +' :',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),

                                controller.productDetails.value!.isOffer! ?
                                AppTextWidget(
                                  content: '${controller.productDetails.value!.offerPrice! * cardIncrement} ' + 'aed'.tr,
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                ):
                                AppTextWidget(
                                  content: '${controller.productDetails.value!.price! * cardIncrement} ' + 'aed'.tr,
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  textAlign: TextAlign.start,
                                ),


                              ],),



                              SizedBox(
                                height: 40.h,
                              ),

                              AppElevatedButton(
                                onPressed: () {
                                  if(SharedPreferencesController().loggedIn){
                                    controller.productDetails.value!.quantity = cardIncrement;
                                    CartGetController.to.addItemToCart(
                                        productId: controller.productDetails.value!.id!,
                                        quantity: cardIncrement,
                                        productModel: controller.productDetails.value!,
                                      size: sizes!= null ?sizes![sizeSelect]:null,
                                      color: getColor() != null ? getColor()!.elementAt(colorSelect):null,
                                    );
                                  }else{
                                    showAwesomeDialog(context: context,
                                        title: 'login_alert_title'.tr,
                                        desc: 'login_alert_desc'.tr,
                                        buttonText: 'login'.tr,
                                        onTap: ()=>Get.to(const LoginScreen()),
                                    );
                                  }

                                },
                                text: 'add_to_cart'.tr,
                                fontWeight: FontWeight.bold,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ):Container();
        }),
    );
  }


  List<String>? getColor(){
    if(colorsEn != null && colorsAr!=null){
      return SharedPreferencesController().languageCode == 'en' ? colorsEn:colorsAr;
    }
    return null;
  }

  List<String>? getfetuers(){
    if(featuersEn != null && featuersAr!=null){
      return SharedPreferencesController().languageCode == 'en' ? featuersEn:featuersAr;
    }
    return null;
  }
}
