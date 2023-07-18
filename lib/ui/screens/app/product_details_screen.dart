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
  List<String>? featuersEn;
  List<String>? featuersAr;
  List<String>? sizes;

  int sizeSelect = 0;
  int colorSelect = 0;
  
  late CarouselController carouselController;




  @override
  void initState() {
    carouselController = CarouselController();
    Future.delayed(Duration.zero, () async {
      await ProductDetailsGetController.to.getProductDetails(productId: widget.id).then((value) {
        if(ProductDetailsGetController.to.productDetails.value!.size != null){
          sizes = ProductDetailsGetController.to.productDetails.value!.size?.split(',').toList();
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
        return controller.loading.value? const ShimmerProductDetailsScreen(): controller.complete.value?
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      height: 380.h,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      scrollPhysics: const NeverScrollableScrollPhysics(),
                      reverse: false,
                      autoPlay: false,
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
                          boxFit: BoxFit.cover
                          ,
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight:  Radius.circular(20.h),topLeft:  Radius.circular(20.h)),
                  boxShadow:  const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0,-3),
                        blurRadius: 2,
                        spreadRadius: 0.1)
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      //row  product name
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
                              height: 42.h,
                              width: 42.w,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: controller.productDetails.value!.isFavorite!?Colors.red:Colors.grey),
                              child: const Icon(Icons.favorite, color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                      Divider(height: 18.h,color: Colors.grey.shade200,),


                      //row product  price
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

                      //row amount
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
                                child: const Icon(Icons.add,color: PRIMARY_COLOR,),
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
                                backgroundColor: Colors.white,)
                            ],
                          )

                        ],
                      ),
                      Divider(height: 10.h,color: Colors.grey.shade200,),


                      Theme(

                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child:ExpansionTile(title: AppTextWidget(
                        content: 'description'.tr,
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: getFontFamily(),
                        fontWeight: FontWeight.w600,
                      ),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero ,
                        iconColor: PRIMARY_COLOR,

                        expandedAlignment: SharedPreferencesController().languageCode == 'en'? Alignment.bottomLeft: Alignment.bottomRight,
                        children: [
                          AppTextWidget(
                            content: SharedPreferencesController().languageCode == 'en'? controller.productDetails.value!.descEn!:controller.productDetails.value!.descAr!,
                            color: Colors.grey,
                            fontSize: 14,
                            textAlign: TextAlign.start,
                            line: 50,
                          ),
                        ],),),



                      //row description

                      Divider(height: 10.h,color: Colors.grey.shade200,),


                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextWidget(
                            content: 'colors'.tr,
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
                            itemCount: controller.productDetails.value!.images!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  setState(() {
                                    colorSelect = index;
                                    carouselController.jumpToPage(index);
                                    print(controller.productDetails.value!.images!.elementAt(colorSelect).src!);
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: index == colorSelect ? Border.all(color: PRIMARY_COLOR,width: 3.h): Border.all(color: Colors.grey.shade300,width: 2.h)

                                  ),
                                  child: NetworkImageWidget(
                                    height: 380.h,
                                    width: double.infinity,
                                    image: controller.productDetails.value!.images!.elementAt(index).src!,
                                    boxFit: BoxFit.cover
                                    ,
                                  ),
                                ),
                              );
                            },),
                          Divider(height: 18.h,color: Colors.grey.shade200,),
                        ],
                      ),

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


                          Wrap(
                            children: sizes!.map((e) =>
                                GestureDetector(
                                  onTap: (){
                                    sizeSelect = sizes!.indexOf(e);
                                    setState(() {});
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                                    margin: EdgeInsetsDirectional.only(end:5.h ,top: 2.h),
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
                          Divider(height: 10.h,color: Colors.grey.shade200,),
                        ],
                      ):Container(),

                      getfetuers() != null ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppTextWidget(
                            content: 'features'.tr,
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          Wrap(
                            children: getfetuers()!.map((e) =>
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
                                  margin: EdgeInsetsDirectional.only(end:5.h,top: 2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.h),
                                      border: Border.all(color: Colors.grey.shade200),
                                      color: PRIMARY_COLOR
                                  ),
                                  child: AppTextWidget(content: e ,fontSize: 12,color: Colors.white,fontWeight: FontWeight.normal,fontFamily: getFontFamily(),),
                                )
                            ).toList(),
                          ),
                          Divider(height: 10.h,color: Colors.grey.shade200,),
                        ],
                      ): Container(),



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
                              color: controller.productDetails.value!.images!.elementAt(colorSelect).src!,
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
        ):Container();
      }),
    );
  }

  
  List<String>? getfetuers(){
    if(featuersEn != null && featuersAr!=null){
      return SharedPreferencesController().languageCode == 'en' ? featuersEn:featuersAr;
    }
    return null;
  }
}
