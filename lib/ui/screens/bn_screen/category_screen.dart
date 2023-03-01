import 'package:dimax/get/category_get_controller.dart';
import 'package:dimax/ui/screens/app/sub_category_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_category_screen.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CategoryGetController>(
      builder: (CategoryGetController controller) {
        return BaseWidget(
          lodgingWidget: const ShimmerCategoryScreen(),
          widget: RefreshIndicator(
            onRefresh: ()=>controller.getCategory(),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              itemCount: controller.categories.length,
              // shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.h,
                childAspectRatio: 1 / 1,
                mainAxisSpacing: 10.w,
              ),
              itemBuilder: (context, index) {
                return CategoryWidget(
                  category: controller.categories[index],
                  onTap: () => Get.to(SubCategoryScreen(categoryId: controller.categories.elementAt(index).id!),),
                );
              },
            ),
          ),
          loading: controller.loading.value,
          complete: controller.complete.value,
        );
      },
    );
  }
}
