import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerOrderScreen extends StatelessWidget {
  const ShimmerOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.all(8.h),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          elevation: 1,
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ShimmerWidget(height: 30.h, width: 80.w,),
                    const Spacer(),
                    ShimmerWidget(height: 30.h, width: 80.w,)

                  ],
                ),


                SizedBox(height: 20.h,),

                ShimmerWidget(height: 30.h, width: 180.w,),
                SizedBox(
                  height: 15.h,
                ),
                Row(
                  children: [
                    ShimmerWidget(height: 30.h, width: 120.w,),

                    const Spacer(),

                    ShimmerWidget(height: 30.h, width: 80.w,)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
