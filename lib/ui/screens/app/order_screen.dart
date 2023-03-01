import 'package:dimax/get/order_get_controller.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_order_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/order_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero,() {
      OrderGetController.to.getOrder();
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
          content: 'order'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),

      body: GetX<OrderGetController>(
        builder: (controller) {
          return BaseWidget(
              widget: RefreshIndicator(
                onRefresh: ()=> controller.getOrder(),
                child: ListView.builder(
                itemCount: controller.orders.length,
                itemBuilder: (context, index) {
                  return OrderWidget(orderModel: controller.orders.elementAt(index));
                },),
              ),
              lodgingWidget: const ShimmerOrderScreen(),
              loading: controller.loading.value,
              complete: controller.complete.value,
          );
        },
      ),

    );
  }
}
