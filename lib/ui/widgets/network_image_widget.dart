import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class NetworkImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String image;
  final BoxFit boxFit;

  const NetworkImageWidget({Key? key, required this.height, required this.width, required this.image,this.boxFit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: boxFit,
      height: height,
      width: width,
      imageUrl: image,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: Shimmer.fromColors(
          highlightColor: Colors.grey.shade50,
          baseColor: Colors.grey.shade200,
          child: SizedBox(
            height: 50.h,
            width: 50.h,
            child: SvgPicture.asset(
            'assets/svg/logo.svg',
            height: 40.h,
            width: 40.w,
          ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
