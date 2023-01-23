import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/screens/checkout/widgets/product_order.dart';
import 'package:alteratech/presentation/screens/checkout/widgets/tracking_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/utiles.dart';
import '../../../../domain/models/order/wooorder.dart';
import '../../../components/my+text.dart';

class OrderItemWidget extends StatefulWidget {
  final WooOrder order;
  const OrderItemWidget(
      {Key? key, required this.order, required this.showTrack})
      : super(key: key);
  final bool showTrack;
  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          alignment: Alignment.topLeft,
          children: [
            Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      expanded = !expanded;
                      setState(() {});
                    },
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NeoText("${"orderid".tr()} ${widget.order.id}",
                                fontWeight: FontWeight.bold,
                                color: AppColors.primiry,
                                size: 20.fs),
                            NeoText(
                                "${DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.parse(widget.order.dateCreated!))}",
                                size: 15.fs,
                                color: Colors.grey),
                            if (widget.showTrack)
                              Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                              child: OrderTrackingWidget(
                                                order: widget.order,
                                              ),
                                            ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NeoText("ordertracking".tr(),
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primiry,
                                        size: 12.fs),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            NeoText("total".tr(),
                                fontWeight: FontWeight.bold,
                                color: AppColors.primiry,
                                size: 20.fs),
                            NeoText("${widget.order.total} ${"sr".tr()}",
                                color: Colors.grey, size: 15.fs),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                    firstChild: SizedBox(
                      width: double.infinity,
                    ),
                    secondChild: Column(
                      children: [
                        Column(
                          children: widget.order.lineItems!
                              .map((e) => ProductOrderWidget(
                                    items: e,
                                  ))
                              .toList(),
                        ),
                        if (widget.order.shippingLines != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                NeoText("fee".tr(),
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primiry,
                                    size: 20.fs),
                                Spacer(),
                                NeoText(
                                    "${widget.order.shippingTotal}  ${"sr".tr()}",
                                    color: Colors.grey,
                                    size: 17.fs),
                              ],
                            ),
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              NeoText("total".tr(),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primiry,
                                  size: 20.fs),
                              Spacer(),
                              NeoText("${widget.order.total} ${"sr".tr()}",
                                  color: Colors.grey, size: 17.fs),
                            ],
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: expanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 300))
              ],
            )),
            widget.order.status == null
                ? SizedBox()
                : Positioned(
                    top: -15,
                    left: 15,
                    child: SizedBox(
                        width: 100.w,
                        height: 30,
                        child: Card(
                          color: AppColors.primiry,
                          shape: StadiumBorder(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: NeoText(
                                    "${Utiles.trakingStatus(widget.order.status ?? "")}",
                                    color: AppColors.white,
                                    size: 15.fs)),
                          ),
                        )),
                  )
          ],
        ),
      ],
    );
  }
}
