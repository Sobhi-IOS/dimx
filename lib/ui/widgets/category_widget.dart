import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:dimax/models/category_model.dart';
import 'package:dimax/ui/widgets/app_text_widget.dart';
import 'package:dimax/ui/widgets/network_image_widget.dart';
import 'package:dimax/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryWidget extends StatelessWidget {
  final CategoryModel category;
  final void Function() onTap;

  const CategoryWidget({Key? key, required this.category, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.h),
              child: NetworkImageWidget(
                  height: 110.h,
                  width: double.infinity,
                  boxFit: BoxFit.contain,
                  image: category.image!,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 2.w,right: 2.w,top: 5.h,bottom: 5.h),
              child: AppTextWidget(
                content: SharedPreferencesController().languageCode == 'en' ? category.nameEn! : category.nameAr!,
                fontSize: 16,
                color: PRIMARY_TEXT_COLOR,
                fontWeight: FontWeight.w500,
                // line: 2,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
