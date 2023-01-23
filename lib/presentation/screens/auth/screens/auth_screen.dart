import 'dart:async';

import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/validation.dart';
import '../../../../domain/models/customer/customer.dart';

import '../../../components/login_text_failed.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';
import '../widget/trans_auth_state.dart';
import 'reset_pass.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isSignUp = false;

  AnimationController? controller;
  Animation<Offset>? offset;
  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    offset = Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.bounceOut));
    super.initState();
  }

  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPass.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context);
    final cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: AppColors.primiry,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          Image.asset("assets/images/logo.png").image,
                      radius: 80.fs,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        clipBehavior: Clip.none,
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Column(
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
                                    children: <Widget>[
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TransAuthState(
                                        isSignUp: isSignUp,
                                        fun: (s) {
                                          setState(() {
                                            isSignUp = s;
                                          });
                                        },
                                        controller: controller!,
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.spaceEvenly,
                                      //   children: <Widget>[
                                      //     GestureDetector(
                                      //       onTap: () {
                                      //         if (isSignUp) {
                                      //           if (controller!.isCompleted) {
                                      //             Timer(
                                      //                 Duration(
                                      //                     milliseconds: 700),
                                      //                 () {
                                      //               isSignUp = false;
                                      //               setState(() {});
                                      //             });
                                      //             controller!.reverse();
                                      //           }
                                      //         }
                                      //       },
                                      //       child: Padding(
                                      //         padding:
                                      //             const EdgeInsets.all(8.0),
                                      //         child: DecoratedBox(
                                      //             decoration: BoxDecoration(
                                      //                 border: Border(
                                      //                     bottom: BorderSide(
                                      //                         color: isSignUp
                                      //                             ? Colors.white
                                      //                             : AppColors
                                      //                                 .primiry))),
                                      //             child: CustomText(
                                      //                 "login".tr(),
                                      //                 color: isSignUp
                                      //                     ? Colors.black26
                                      //                     : AppColors.primiry)),
                                      //       ),
                                      //     ),
                                      //     GestureDetector(
                                      //       onTap: () {
                                      //         if (!isSignUp) {
                                      //           Timer(
                                      //               Duration(milliseconds: 700),
                                      //               () {
                                      //             controller!.forward();
                                      //           });
                                      //           isSignUp = true;
                                      //           setState(() {});
                                      //         }
                                      //       },
                                      //       child: Padding(
                                      //         padding:
                                      //             const EdgeInsets.all(8.0),
                                      //         child: DecoratedBox(
                                      //             decoration: BoxDecoration(
                                      //                 border: Border(
                                      //                     bottom: BorderSide(
                                      //                         color: isSignUp
                                      //                             ? AppColors
                                      //                                 .primiry
                                      //                             : Colors
                                      //                                 .white))),
                                      //             child: CustomText(
                                      //                 "register".tr(),
                                      //                 color: isSignUp
                                      //                     ? AppColors.primiry
                                      //                     : Colors.black26)),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      AnimatedCrossFade(
                                          firstChild: SizedBox(
                                            width: double.infinity,
                                          ),
                                          secondChild: Container(
                                            color: AppColors.primiry,
                                            child: SlideTransition(
                                              position: offset!,
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: LoginTextField(
                                                    controller: username,
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    validate: isSignUp
                                                        ? (Validation()
                                                            .defaultValidation)
                                                        : (f) {},
                                                    hintText: "usrname".tr(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          crossFadeState: isSignUp
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          duration:
                                              Duration(milliseconds: 300)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: LoginTextField(
                                          controller: email,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validate: (s) {},
                                          // Validation().emailValidation,
                                          suffixIcon: Icon(Icons.email),
                                          hintText: "email".tr(),
                                        ),
                                      ),
                                      // buildTextField(Icons.email, "Enter Your Email",
                                      //     false, TextInputType.text),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: LoginTextField(
                                          controller: password,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          validate:
                                              Validation().passwordValidation,
                                          hintText: "password".tr(),
                                        ),
                                      ),
                                      AnimatedCrossFade(
                                          firstChild: SizedBox(
                                            width: double.infinity,
                                          ),
                                          secondChild: Container(
                                            color: AppColors.primiry,
                                            child: SlideTransition(
                                              position: offset!,
                                              child: Container(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: LoginTextField(
                                                    controller: confirmPass,
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    validate: isSignUp
                                                        ? (s) {
                                                            return Validation()
                                                                .confirmPasswordValidation(
                                                                    s,
                                                                    password
                                                                        .text);
                                                          }
                                                        : (f) {},
                                                    hintText:
                                                        "confirm pass".tr(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          crossFadeState: isSignUp
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          duration:
                                              Duration(milliseconds: 300)),

                                      SizedBox(
                                        height: 40.h,
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 70,
                              )
                            ],
                          ),
                          Positioned(
                            bottom: 45,
                            height: 70,
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: AppColors.white,
                              child: GestureDetector(
                                onTap: () {
                                  print("clicked");

                                  if (_formKey.currentState!.validate()) {
                                    WooCustomer wooUser = WooCustomer(
                                        email: email.text.trim(),
                                        username: username.text.trim(),
                                        password: password.text.trim());
                                    isSignUp
                                        ? cubit
                                            .regiser(
                                            context,
                                            customer: wooUser,
                                          )
                                            .then((value) {
                                            if (value) {
                                              isSignUp = false;
                                              setState(() {});
                                            }
                                          })
                                        : cubit.login(context,
                                            username: email.text.trim(),
                                            password: password.text.trim());
                                  }
                                },
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(colors: [
                                        AppColors.primiry,
                                        Colors.orange
                                      ])),
                                  child: Center(
                                    child: NeoText("OK",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 30.h,
                    // ),

                    InkWell(
                      onTap: () {
                        navigate(context: context, route: ResetPass());
                      },
                      child: NeoText(
                        'forget'.tr(),
                        size: 18.fs,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
