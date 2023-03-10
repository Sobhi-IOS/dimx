import 'package:dimax/helpers/helper.dart';
import 'package:dimax/local_storage/shared_preferences.dart';
import 'package:flutter/material.dart';


class AppTextWidget extends StatelessWidget with Helper{
  final String content;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;
  final String? fontFamily;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final Color decorationColor;
  final int? line;

   AppTextWidget({Key? key,
    required this.content,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 14,
    this.textAlign = TextAlign.start,
    this.textDecoration = TextDecoration.none,
    this.decorationColor = Colors.transparent,
    this.line,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: textAlign,
      maxLines: line,
      style: TextStyle(
        height: getTextHeight(),
        decoration: textDecoration,
        decorationColor: decorationColor,
        color: color,
        fontWeight: fontWeight,
        fontSize: getFontSize(fontSize),
        fontFamily: getFontFamily(fontFamily: fontFamily),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }


  double getTextHeight(){
    return SharedPreferencesController().languageCode == 'en' ? 1.2:1.5;
  }
}
