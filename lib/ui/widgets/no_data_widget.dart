
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.h),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_data.png',height: 250,width: 250,),
            SizedBox(height: 20.h,),
            AppTextWidget(
              content: 'no_data'.tr,
              color: Colors.grey,
              fontSize: 14,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}