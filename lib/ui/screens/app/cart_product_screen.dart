import 'package:dimax/get/auth_get_controller.dart';
import 'package:dimax/get/cart_getx_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/app/confirm_order_screen.dart';
import 'package:dimax/ui/screens/auth/activate_account_screen.dart';
import 'package:dimax/ui/screens/auth/login_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_cart_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/cart_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartProductScreen extends StatefulWidget {
  const CartProductScreen({Key? key}) : super(key: key);


  @override
  State<CartProductScreen> createState() => _CartProductScreenState();
}

class _CartProductScreenState extends State<CartProductScreen> with Helper{

  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      CartGetController.to.getCartProduct();
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'cart'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: GetX<CartGetController>(builder: (controller) {
        return BaseWidget(
            lodgingWidget: const ShimmerCartScreen(),
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return CartWidget(productModel: controller.cartProduct.elementAt(index));
                  },
                    itemCount: controller.cartProduct.length,
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                    shrinkWrap: true,)
                  ,
                ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          AppTextWidget(content: 'items_available'.tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          AppTextWidget(content: '${controller.cartProduct.length}',
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextWidget(content: 'cart_total'.tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          AppTextWidget(content: '${controller.total} ' + 'aed'.tr,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,

                          ),
                        ],
                      ),
                      SizedBox(height: 25.h,),
                      AppElevatedButton(text: 'checkout'.tr, onPressed:()=>checkOut(context)),

                    ],
                  ),
                ),

                SizedBox(height: 50.h,),
              ],
            ),
            loading: controller.loading.value,
            complete: controller.complete.value);
      },)
    );
  }

  void checkOut(BuildContext context) async{

    if(SharedPreferencesController().userModel.activationStatus == null || SharedPreferencesController().userModel.activationStatus == false){
      showAwesomeDialog(context: context,
          title: 'activate_account_dialog_title'.tr,
          desc: 'activate_account_dialog_msg'.tr,
          buttonText: 'send_code'.tr,
          onTap: () {
            AuthGetController.to.sendCodeActivate();
            Get.to(const ActivateAccountScreen());
          }
      );
    }else{
      Get.to(const ConfirmOrderScreen());
    }
  }
}
