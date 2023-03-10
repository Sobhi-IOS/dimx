import 'package:dimax/get/network_get_controller.dart';
import 'package:dimax/ui/widgets/no_data_widget.dart';
import 'package:dimax/ui/widgets/no_internet_connection_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BaseWidget extends StatelessWidget {
  Widget lodgingWidget;
  Widget widget;
  bool loading;
  bool complete;

  BaseWidget(
    {
      required this.lodgingWidget,
      required this.widget,
      required this.loading,
      required this.complete,
      Key? key,
    })
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<InterNetGetController>(
      builder: (controller) {
        return controller.hasNetwork.value
            ? loading ? lodgingWidget : complete ? widget : const Center(child: NoDataWidget(),)
            : const NoInternetConnectionWidget();
      },
    );
  }
}
