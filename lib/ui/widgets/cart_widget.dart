import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/product_details_model.dart';
import 'package:dimax/models/product_model.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartWidget extends StatelessWidget {
  late ProductDetailsModel productModel;

  CartWidget({Key? key, required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 130.h,
          margin: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(0, 3),
                  blurRadius: 7,
                  spreadRadius: 0)
            ],
          ),
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              NetworkImageWidget(height: 80.h, width: 80.h, image: productModel.mainImage!),
              SizedBox(
                width: 15.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 25),
                      child: Column(children: [
                          AppTextWidget(
                            content: SharedPreferencesController().languageCode =='en'?productModel.nameEn!:productModel.nameAr!,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            line: 1,
                          ),

                          AppTextWidget(
                            content: SharedPreferencesController().languageCode =='en'?productModel.descEn!:productModel.descAr!,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            line: 2,
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),



                    SizedBox(height: 4.h,),
                    Row(
                      children: [
                        Text(
                          '${productModel.price!} ' + 'aed'.tr,
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),

                        Spacer(),

                        GestureDetector(
                          onTap: ()=> CartGetController.to.updateCartItem(
                              productId: productModel.id!,
                              quantity: productModel.quantity! - 1 ),
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            padding: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100),
                            child: Icon(Icons.minimize),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          productModel.quantity.toString(),
                          style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        GestureDetector(
                              onTap: ()=> CartGetController.to.updateCartItem(
                              productId: productModel.id!,
                              quantity: productModel.quantity! + 1 ),
                          child: Container(
                            width: 35.w,
                            height: 35.h,
                            padding: EdgeInsets.only(bottom: 0.h),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade100),
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            right: 0.w,
            top: 0.h,
            child:
                IconButton(onPressed: ()=>CartGetController.to.deleteCartItem( productId: productModel.id!), icon: Icon(Icons.cancel_outlined)))
      ],
    );
  }
}
