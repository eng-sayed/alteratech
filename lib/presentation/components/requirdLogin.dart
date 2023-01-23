import 'package:alteratech/core/themes/colors.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/auth/screens/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/utils/navigator.dart';

//TODO

class RequirdLogin extends StatelessWidget {
  const RequirdLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      // title: Text('Login'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: NeoText(
              "mustlogin".tr(),
            ),
          )
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  navigate(context: context, route: Auth());
                },
                child: (NeoText(
                  "login".tr(),
                  color: AppColors.white,
                ))),
          ],
        ),
      ],
    );
  }
}
