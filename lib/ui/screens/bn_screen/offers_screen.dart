
import 'package:dimax/get/offers_get_controller.dart';
import 'package:dimax/ui/screens/app/product_details_screen.dart';
import 'package:dimax/ui/screens/shimmer/shimmer_product_screen.dart';
import 'package:dimax/ui/widgets/base_widget.dart';
import 'package:dimax/ui/widgets/product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class OffersScreen extends StatefulWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    OfferGetController.to.getOffer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetX<OfferGetController>(
      builder: (controller) {
        return BaseWidget(
            lodgingWidget: const ShimmerProductScreen(),
            widget: GridView.builder(
              itemCount: controller.offers.length,
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
                  product: controller.offers.elementAt(index),
                  onTap: () =>Get.to(ProductDetailsScreen(id: controller.offers.elementAt(index).id!)),
                );
              },
            ),
            loading: OfferGetController.to.loading.value,
            complete: OfferGetController.to.complete.value);
      },
    );
  }
}
