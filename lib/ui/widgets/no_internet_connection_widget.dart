
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/no_connection.png',height: 250,width: 250,),
            SizedBox(height: 20.h,),
            AppTextWidget(content: 'oops'.tr ,color: Colors.black,fontSize: 30),
            SizedBox(height: 8.h,),
            AppTextWidget(
              content: 'no_internet_connection'.tr,
              color: Colors.grey,
              fontSize: 20,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}