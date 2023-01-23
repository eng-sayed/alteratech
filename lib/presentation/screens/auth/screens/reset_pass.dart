import 'package:alteratech/core/utils/responsive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/validation.dart';

import '../../../components/login_text_failed.dart';
import '../cubit/cubit.dart';

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  @override
  void dispose() {
    email.dispose();

    super.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final cubit = AuthCubit.get(context);

    return Scaffold(
      backgroundColor: AppColors.primiry,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: Image.asset("assets/images/logo.png").image,
              radius: 80.fs,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.passthrough,
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 5),
                      ],
                    ),
                    curve: Curves.bounceInOut,
                    //  color: Colors.white,
                    duration: Duration(milliseconds: 1000),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: LoginTextField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validate: Validation().emailValidation,
                            suffixIcon: Icon(Icons.email),
                            hintText: "email".tr(),
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -35.fs,
                    child: Container(
                      height: 70,
                      width: 70,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: GestureDetector(
                        onTap: () async {
                          // value.login(email.text, password.text);
                          if (_formKey.currentState!.validate()) {
                            cubit.forgetPassword(context, email.text.trim());
                            // loading = true;
                            // setState(() {});
                            // if (await WooCommerce()
                            //     .lostPassword(email.text.trim())) {
                            //   showSnack(context, "restpasssent".tr());
                            // } else {
                            //   showSnack(context, "notfndusr".tr());
                            // }
                            // loading = false;
                            // setState(() {});
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primiry,
                                  Colors.orange
                                  // Color.fromARGB(255, 255, 82, 2)
                                ],
                              ),
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20.fs,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
