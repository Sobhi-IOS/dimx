import 'package:dimax/get/policy_get_controller.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CondationScreen extends StatelessWidget {
  const CondationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          content: 'terms_and_conditions'.tr,
          color: PRIMARY_TEXT_COLOR,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: Html(data:PolicyGetController.to.conditional??'',style: {
            "p": Style(
              fontSize: FontSize(14.sp),),

            "h1": Style(
              fontSize: FontSize(26.sp),),

            "h2": Style(
              fontSize: FontSize(24.sp),),

            "h3": Style(
              fontSize: FontSize(22.sp),),

            "h4": Style(
              fontSize: FontSize(20.sp),),

            "h5": Style(
              fontSize: FontSize(18.sp),),

            "h6": Style(
              fontSize: FontSize(16.sp),),


          },),
        ),
      ),
    );
  }
}
