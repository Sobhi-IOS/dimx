import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerAddressScreen extends StatelessWidget {
  const ShimmerAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.h),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Container(
          // clipBehavior: Clip.antiAlias,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          // elevation: 0.5,
          margin: EdgeInsets.symmetric(vertical: 5.h),
          child: ShimmerWidget(height: 60.h, width: double.infinity),
        );
      },
    );
  }
}
