
import 'package:dimax/get/favorite_get_controller.dart';
import 'package:dimax/ui/screens/app/product_details_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_product_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/product_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  @override
  void initState() {
    FavoriteGetController.to.getFavorite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'favorite'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: GetX<FavoriteGetController>(
        builder: (controller) {
          return BaseWidget(
              lodgingWidget: const ShimmerProductScreen(),
              widget: GridView.builder(
                itemCount: controller.favoriteProduct.length,
                padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.h,
                  childAspectRatio: 1 / 1.6,
                  mainAxisSpacing: 10.w,
                ),
                itemBuilder: (context, index) {
                  return ProductWidget(
                    product: controller.favoriteProduct.elementAt(index),
                    onTap: () =>Get.to(ProductDetailsScreen(id: controller.favoriteProduct.elementAt(index).id!)),
                  );
                },
              ),
              loading: FavoriteGetController.to.loading.value,
              complete: FavoriteGetController.to.complete.value);
        },
      ),
    );
  }
}
