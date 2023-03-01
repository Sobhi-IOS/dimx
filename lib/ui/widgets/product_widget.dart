import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/product_model.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductWidget extends StatelessWidget with Helper{


  final ProductModel product;
  final void Function() onTap;


  const ProductWidget({Key? key, required this.product, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            elevation: 1,
            margin: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [


                SizedBox(height: 30.h,),
                Expanded(
                  child: NetworkImageWidget(height: 150.h, width: double.infinity, image: product.mainImage??'',
                    boxFit: BoxFit.contain,),
                ),
                SizedBox(
                  height: 10.h,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [


                      SizedBox(
                        height: 50.h,
                        child: AppTextWidget(
                          content: SharedPreferencesController().languageCode == 'en' ?product.nameEn!:product.nameAr!,
                          fontSize: 14,
                          color: Colors.black,
                          line: 2,
                          textAlign: TextAlign.center,

                        ),
                      ),



                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        product.isOffer! == true ? AppTextWidget(
                          content: '${product.price!} ' + 'aed'.tr,
                          fontSize: 14,
                          color: PRIMARY_TEXT_COLOR,
                          fontWeight: FontWeight.bold,
                          textDecoration: TextDecoration.lineThrough,
                        ):
                        AppTextWidget(
                          content: '${product.price} ' + 'aed'.tr,
                          fontSize: 14,
                          color: PRIMARY_TEXT_COLOR,
                          fontWeight: FontWeight.bold,
                        ),

                        SizedBox(width: 5.w,),

                        product.isOffer! == true ? AppTextWidget(
                          content: '${product.offerPrice!} ' + 'aed'.tr,
                          fontSize: 14,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold,
                        ):Container(),

                      ],),

                      SizedBox(height: 20.w,),


                    ],
                  ),
                )
              ],
            ),
          ),
          // Icons.bookmark_border
          PositionedDirectional(
            end: 5.w,
            top: 5.h,
            child: GestureDetector(
              onTap: ()async{
                if(SharedPreferencesController().loggedIn){
                  await FavoriteGetController.to.addFavoriteProducts(product: product);
                }else{
                  showAwesomeDialog(context: context,
                    title: 'login_alert_title'.tr,
                    desc: 'login_alert_desc'.tr,
                    buttonText: 'login'.tr,
                    onTap: ()=>Get.to(const LoginScreen()),
                  );
                }
              },
              child: Container(
                height: 40.h,
                width: 40.h,
                color: Colors.transparent,
                child: product.isFavorite! ?Icon(Icons.bookmark,color: Colors.black,size: 30.h,):Icon(Icons.bookmark_border,color: Colors.grey,size: 30.h,),
                alignment: AlignmentDirectional.topEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
