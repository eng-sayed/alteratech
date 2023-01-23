import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/auth/screens/auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/themes/colors.dart';

import '../../core/utils/navigator.dart';
import '../../core/utils/utiles.dart';
import '../screens/auth/screens/auth_screen.dart';
//TODO

class NeedLogin extends StatelessWidget {
  const NeedLogin({
    Key? key,
    required this.child,
    this.showAppBar = true,
  }) : super(key: key);
  final Widget child;
  final bool showAppBar;
  @override
  Widget build(BuildContext context) {
    return Utiles.token.isNotEmpty
        ? child
        : Scaffold(
            appBar: showAppBar ? AppBar() : null,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset(
                      "assets/json/login.json",
                      height: 150,
                      width: 150,
                    ),
                    NeoText(
                      "mustlogin".tr(),
                      color: AppColors.primiry,
                      size: 24.fs,
                      fontWeight: FontWeight.bold,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          navigate(context: context, route: Auth());
                        },
                        style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                        child: NeoText(
                          "login".tr(),
                          color: AppColors.white,
                        )),
                  ],
                ),
              ),
            ));
  }
}
