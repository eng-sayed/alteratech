import 'dart:async';

import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';

class TransAuthState extends StatelessWidget {
  TransAuthState(
      {Key? key,
      required this.isSignUp,
      required this.controller,
      required this.fun})
      : super(key: key);
  bool isSignUp;
  AnimationController controller;
  Function(bool) fun;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (isSignUp) {
              if (controller.isCompleted) {
                Timer(Duration(milliseconds: 700), () {
                  isSignUp = false;
                  fun.call(isSignUp);
                  print(isSignUp);
                });
                controller.reverse();
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:
                                isSignUp ? Colors.white : AppColors.primiry))),
                child: NeoText("login".tr(),
                    color: isSignUp ? Colors.black26 : AppColors.primiry)),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (!isSignUp) {
              Timer(Duration(milliseconds: 700), () {
                controller.forward();
              });
              isSignUp = true;
              fun.call(isSignUp);
              print(isSignUp);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color:
                                isSignUp ? AppColors.primiry : Colors.white))),
                child: NeoText("register".tr(),
                    color: isSignUp ? AppColors.primiry : Colors.black26)),
          ),
        ),
      ],
    );
  }
}
