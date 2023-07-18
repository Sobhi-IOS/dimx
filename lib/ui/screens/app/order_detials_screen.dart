import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/ui/screens/bn_screen/main_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_order_details_screen.dart';
import 'package:dimax/ui/widgets/app_elevated_button.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/no_data_widget.dart';
import 'package:dimax/ui/widgets/order_details_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatefulWidget {

  final int id;
  const OrderDetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> with Helper{


  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      OrderGetController.to.getOrderDetails(id: widget.id);
    },);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'order_details'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: GetX<OrderGetController>(
        builder: (controller) {
          return controller.loadingOrderDetails.value ? const ShimmerOrderDetailsScreen():
          controller.completeOrderDetails.value ?  Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 0.1,
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.date_range),
                          SizedBox(width: 5.w,),
                          AppTextWidget(
                            content: OrderGetController.to.orderDetailsModel!.order!.createdAt??'',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),

                      Row(
                        children: [

                          const Icon(Icons.info_outline),
                          SizedBox(width: 5.w,),
                          AppTextWidget(
                            content: 'order_id'.tr +': #',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),

                          AppTextWidget(
                            content: OrderGetController.to.orderDetailsModel!.order!.invoiceNumber??'unlisted'.tr,
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),


                      OrderGetController.to.orderDetailsModel!.order!.delegateNumber!= null?Row(
                        children: [

                          const Icon(Icons.phone_android),
                          SizedBox(width: 5.w,),
                          AppTextWidget(
                            content: 'sales_representative'.tr +': ',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),

                          AppTextWidget(
                            content: OrderGetController.to.orderDetailsModel!.order!.delegateNumber.toString(),
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),
                        ],
                      ):Container(),
                      SizedBox(height: OrderGetController.to.orderDetailsModel!.order!.delegateNumber!= null ?10.h:0,),

                      Row(
                        children: [
                          const Icon(Icons.shopping_cart),
                          SizedBox(width: 5.w,),
                          AppTextWidget(
                            content: 'items'.tr +': ',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),

                          AppTextWidget(
                            content: '${OrderGetController.to.productOrderCount}',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),



                      // ====
                      Visibility(
                        visible: SharedPreferencesController().isMarketed,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.phone_rounded),
                                SizedBox(width: 5.w,),
                                AppTextWidget(
                                  content: 'mobile'.tr +': ',
                                  fontSize: 16,
                                  color: PRIMARY_TEXT_COLOR,
                                  fontWeight: FontWeight.w500,
                                  // line: 2,
                                ),

                                AppTextWidget(
                                  content: '${OrderGetController.to.orderDetailsModel!.order!.userModel!.mobile}',
                                  fontSize: 16,
                                  color: PRIMARY_TEXT_COLOR,
                                  fontWeight: FontWeight.w500,
                                  // line: 2,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                          ],
                        ),
                      ),

                      // ====
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          SizedBox(width: 5.w,),
                          AppTextWidget(
                            content: 'address'.tr + ': ',
                            fontSize: 16,
                            color: PRIMARY_TEXT_COLOR,
                            fontWeight: FontWeight.w500,
                            // line: 2,
                          ),
                          Expanded(
                            child: AppTextWidget(
                              content: OrderGetController.to.orderDetailsModel!.order!.address??'',
                              fontSize: 14,
                              color: PRIMARY_TEXT_COLOR,
                              line: 3,
                              fontWeight: FontWeight.w500,
                              // line: 2,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10.h,),

                      Visibility(
                        visible: OrderGetController.to.orderDetailsModel!.order!.note != null,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.event_note_sharp),
                                SizedBox(width: 5.w,),
                                AppTextWidget(
                                  content: 'note'.tr + ': ',
                                  fontSize: 16,
                                  color: PRIMARY_TEXT_COLOR,
                                  fontWeight: FontWeight.w500,
                                  // line: 2,
                                ),
                                Expanded(
                                  child: AppTextWidget(
                                    content: OrderGetController.to.orderDetailsModel!.order!.note??'',
                                    fontSize: 14,
                                    color: PRIMARY_TEXT_COLOR,
                                    line: 3,
                                    fontWeight: FontWeight.w500,
                                    // line: 2,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: controller.orderDetailsModel!.orderProducts!.length,
                  padding: EdgeInsets.all(5.h),
                  itemBuilder: (context, index) {
                    return OrderDetailsWidget(orderProducts: controller.orderDetailsModel!.orderProducts!.elementAt(index),);
                  },),
              ),

              Padding(
                padding:  EdgeInsets.all(15.h),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              content: 'total'.tr +' : ',
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              // line: 2,
                            ),

                            AppTextWidget(
                              content: controller.orderDetailsModel!.order!.generalTotal.toString() + ' '+'aed'.tr,
                              fontSize: 14,
                              color: PRIMARY_TEXT_COLOR,
                              fontWeight: FontWeight.bold,
                              // line: 2,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            AppTextWidget(
                              content: 'discount'.tr +' : ',
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              // line: 2,
                            ),

                            AppTextWidget(
                              content: (controller.orderDetailsModel!.order!.generalTotal! - controller.orderDetailsModel!.order!.fainalTotal!).round().toString()+' '+'aed'.tr,
                              fontSize: 14,
                              color: PRIMARY_TEXT_COLOR,
                              fontWeight: FontWeight.bold,
                              // line: 2,
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            AppTextWidget(
                              content: 'deserved_amount'.tr +' : ',
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              // line: 2,
                            ),

                            AppTextWidget(
                              content: (controller.orderDetailsModel!.order!.fainalTotal!).round().toString() +' '+'aed'.tr,
                              fontSize: 14,
                              color: PRIMARY_TEXT_COLOR,
                              fontWeight: FontWeight.bold,
                              // line: 2,
                            ),
                          ],
                        ),

                      ],
                    ),
                    const Spacer(),
                    Visibility(
                      visible: (SharedPreferencesController().isUser && controller.orderDetailsModel!.order!.invoiceNumber == null),
                      child: SizedBox(child: AppElevatedButton(text: 'cancel_order'.tr,fontSize: 14, onPressed: ()async{
                        String status = await OrderGetController.to.cancelOrder(id: controller.orderDetailsModel!.order!.id!);
                        showAwesomeDialog(
                            context: context,
                            title: 'cancel_order'.tr,
                            desc: status,
                            buttonText: 'cancel'.tr,
                            dialogType: DialogType.info,
                            onTap: ()=>Get.offAll(const MainScreen())
                        );

                      }),width: 130.w,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h,)
            ],
          ) : const Center(child: NoDataWidget(),);
        },
      ),
    );
  }


}
