import 'package:dimax/ui/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeShimmerScreen extends StatelessWidget {
  const HomeShimmerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ShimmerWidget(height: 150.h, width: double.infinity),

            Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 30.h, width: 60.w),
                  ShimmerWidget(height: 30.h, width: 60.w),
                ],
              ),
            ),


            SizedBox(
              height: 120.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ShimmerWidget(
                      height: 130.h,
                      width: 120.w,
                    ),
                  );
                },
              ),
            ),


            Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 30.h, width: 60.w),
                  ShimmerWidget(height: 30.h, width: 60.w),
                ],
              ),
            ),
            //
            //
            SizedBox(
              height: 206.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ShimmerWidget(
                      height: 206.h,
                      width: 125.w,
                    ),
                  );
                },
              ),
            ),


            Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 30.h, width: 60.w),
                  ShimmerWidget(height: 30.h, width: 60.w),
                ],
              ),
            ),
            //
            //
            SizedBox(
              height: 206.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ShimmerWidget(
                      height: 206.h,
                      width: 125.w,
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShimmerWidget(height: 30.h, width: 60.w),
                  ShimmerWidget(height: 30.h, width: 60.w),
                ],
              ),
            ),
            //
            //
            SizedBox(
              height: 206.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: ShimmerWidget(
                      height: 206.h,
                      width: 125.w,
                    ),
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
