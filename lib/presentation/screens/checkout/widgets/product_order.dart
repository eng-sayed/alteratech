import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/themes/colors.dart';
import '../../../../domain/models/order/wooorder.dart';

class ProductOrderWidget extends StatelessWidget {
  const ProductOrderWidget({Key? key, required this.items}) : super(key: key);
  final LineItems items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            // leading: Container(
            //   clipBehavior: Clip.hardEdge,
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            //   width: 100.w,
            //   height: 100.h,
            //   child: NetworkImagesWidgets(
            //     url: fruitsdemo.first,
            //   ),
            // ),
            title: NeoText(items.name!,
                size: 15.fs,
                color: AppColors.primiry,
                fontWeight: FontWeight.bold),
            subtitle: Row(
              children: [
                SizedBox(width: 3.w),
                NeoText("${items.price} ${"sr".tr()}",
                    size: 16.fs,
                    color: AppColors.primiry,
                    fontWeight: FontWeight.bold),
              ],
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                NeoText("${items.subtotal} ${"sr".tr()}",
                    color: AppColors.primiry,
                    fontWeight: FontWeight.bold,
                    size: 17.fs),
                NeoText("x ${items.quantity} ", color: Colors.grey, size: 15.fs)
              ],
            )),
        Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}
