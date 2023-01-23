import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../domain/models/order/wooorder.dart';

class OrderTrackingWidget extends StatelessWidget {
  OrderTrackingWidget({Key? key, required this.order}) : super(key: key);
  WooOrder order;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (order.status == "processing" ||
                order.status == "completed" ||
                order.status == "on-hold")
            ? Stepper(
                steps: [
                  Step(
                      title: NeoText("onhold".tr(),
                          color: AppColors.primiry, size: 18.fs),
                      subtitle: NeoText(
                          "${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(order.dateCreated!))}",
                          color: Colors.grey,
                          size: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: true),
                  Step(
                      title: NeoText("processing".tr(),
                          color: AppColors.primiry, size: 18.fs),
                      subtitle: NeoText("", color: Colors.grey, size: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: (order.status == "processing" ||
                          order.status == "completed")),
                  Step(
                      title: NeoText("completed".tr(),
                          color: AppColors.primiry, size: 18.fs),
                      subtitle: NeoText(
                          "${order.dateCompleted != null ? DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(order.dateCompleted!)) : ""}",
                          color: Colors.grey,
                          size: 12.fs),
                      content: SizedBox(
                        width: double.infinity,
                      ),
                      isActive: order.status == "completed"),
                ],
                controlsBuilder: (context, details) {
                  return SizedBox();
                },
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoText("canceled".tr(),
                      color: AppColors.primiry, size: 18.fs),
                  NeoText(
                      order.dateCompleted != null
                          ? DateFormat('dd-MM-yyyy hh:mm a')
                              .format(DateTime.parse(order.dateCompleted!))
                          : "",
                      color: AppColors.primiry,
                      size: 18.fs),
                ],
              ),
      ],
    );
  }
}
