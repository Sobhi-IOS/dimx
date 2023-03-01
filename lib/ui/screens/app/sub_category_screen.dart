import 'package:dimax/get/product_get_controller.dart';
import 'package:dimax/get/sub_category_get_controller.dart';
import 'package:dimax/ui/screens/app/product_details_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_product_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_sub_category_screen.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/no_data_widget.dart';
import 'package:dimax/ui/widgets/product_widget.dart';
import 'package:dimax/ui/widgets/sub_category_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SubCategoryScreen extends StatefulWidget {
  late int categoryId;

  SubCategoryScreen({Key? key, required this.categoryId}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {


  @override
  void initState() {
    SubCategoryGetController.to.getSubCategories(categoryId: widget.categoryId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'products'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),

      body: Column(
        children: [
          SizedBox(
            height: 55.h,
            child: GetX<SubCategoryGetController>(
              builder: (controller) {
                return !controller.loading.value
                  ? ListView.builder(
                    itemCount: controller.subCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SubCategoryWidget(
                        subCategory: controller.subCategories.elementAt(index),
                        onTap: () => controller.changeState(controller.subCategories.elementAt(index).id!),
                      );
                    },
                  )
                : const ShimmerSubCategoryScreen();
              },
            ),
          ),


          GetX<ProductGetController>(
            builder: (controller) {
              return !controller.loading.value
                  ? !controller.complete.value?const Expanded(child: Center(child: NoDataWidget(),)):Expanded(
                    child: GridView.builder(
                      itemCount: controller.products.length,
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
                          product: controller.products.elementAt(index),
                          onTap: () =>Get.to(ProductDetailsScreen(id: controller.products.elementAt(index).id!)),
                        );
                      },
                ),
              )
                  : const Expanded(
                     child: ShimmerProductScreen(),
              );
            },
          ),


        ],
      ),

    );
  }
}
