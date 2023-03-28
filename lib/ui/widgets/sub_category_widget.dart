import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/sub_category_model.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryWidget extends StatelessWidget with Helper{
  final SubCategoryModel subCategory;
  final void Function() onTap;

  SubCategoryWidget({Key? key, required this.subCategory, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        margin: EdgeInsets.symmetric(vertical: 6.h,horizontal: 3.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.h),
            border: Border.all(color: PRIMARY_COLOR),
            color: subCategory.isSelect ? PRIMARY_COLOR.withOpacity(0.5):Colors.white,
        ),
        child: AppTextWidget(content: SharedPreferencesController().languageCode =='en' ?subCategory.nameEn! : subCategory.nameAr!,fontFamily: getFontFamily(),fontSize: 16,color: subCategory.isSelect ? Colors.white:Colors.black,fontWeight: subCategory.isSelect? FontWeight.bold:FontWeight.normal,),
      ),
    );
  }
}
