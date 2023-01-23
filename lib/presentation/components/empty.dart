import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset("assets/json/empty.json"),
          SizedBox(
            height: 20,
          ),
          NeoText(
            "noDATA".tr(),
            size: 18,
          ),
        ],
      ),
    );
  }
}
