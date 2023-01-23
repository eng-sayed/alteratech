import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/profile/cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/utiles.dart';
import '../../../core/utils/validation.dart';
import '../../components/expandable_widget.dart';
import '../../components/loadinganderror.dart';
import '../../components/login_text_failed.dart';
import '../../components/needLogin.dart';
import '../product/widget/expanded_container.dart';
import 'widgets/custom_clipper.dart';
import 'widgets/expanded_card.dart';
import 'widgets/user_data.dart';
import 'cubit/cubit.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Utiles.token.isNotEmpty) {
        ProfileCubit.get(context).getUserDate(context);
      }
    });
    super.initState();
  }

  final passwordContrller = TextEditingController();
  final passwordComContrller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return NeedLogin(
      child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            final cubit = ProfileCubit.get(context);
            return LoadingAndError(
              isError: state is GetCustomerDataErrorState,
              isLoading: state is GetCustomerDataLoadingState,
              child: Scaffold(
                  appBar: AppBar(
                    //  backgroundColor: Colors.transparent,
                    title: NeoText(
                      "profile".tr(),
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      ClipPath(
                        child: Container(
                          color: AppColors.white,
                        ),
                        clipper: getClipper(),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            child: Image.asset(
                              'assets/images/images.png', fit: BoxFit.fill,
                              //  fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Utiles.Username,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          UserDataEdit(),
                          // ExpandCardInSide(
                          //     title: "change pass".tr(),
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Form(
                          //         key: formkey,
                          //         child: Column(
                          //           children: [
                          //             Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 8.0),
                          //               child: LoginTextField(
                          //                 color: AppColors.white,
                          //                 controller: passwordContrller,
                          //                 hintText: "enter new pass".tr(),
                          //                 keyboardType:
                          //                     TextInputType.visiblePassword,
                          //                 validate:
                          //                     Validation().passwordValidation,
                          //               ),
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.symmetric(
                          //                   horizontal: 8.0),
                          //               child: LoginTextField(
                          //                   color: AppColors.white,
                          //                   hintText: "confirm pass".tr(),
                          //                   keyboardType:
                          //                       TextInputType.visiblePassword,
                          //                   validate: (s) {
                          //                     return Validation()
                          //                         .confirmPasswordValidation(s,
                          //                             passwordContrller.text);
                          //                   }),
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: NeoText(
                          //                 "برجاء العلم ان تغير كلمه المرور سيؤدي الي تسجيل الخروج من التطبيق",
                          //                 align: TextAlign.center,
                          //                 color: AppColors.white,
                          //               ),
                          //             ),
                          //             Padding(
                          //               padding: const EdgeInsets.all(8.0),
                          //               child: ElevatedButton(
                          //                 onPressed: () async {
                          //                   if (formkey.currentState!
                          //                       .validate()) {
                          //                     cubit.updateUserPassword(context,
                          //                         passwordContrller.text);
                          //                   }
                          //                 },
                          //                 child: NeoText(
                          //                   "Update Password".tr(),
                          //                   color: AppColors.primiry,
                          //                   fontWeight: FontWeight.w700,
                          //                 ),
                          //                 style: ElevatedButton.styleFrom(
                          //                     primary: AppColors.white,
                          //                     shape: StadiumBorder()),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     )),

                          ExpandedSection(
                            firstChild: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 300.w,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: NeoText(
                                      "change pass".tr(),
                                      size: 18,
                                      color: AppColors.white,
                                    ),
                                  )),
                            ),
                            secChild: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: LoginTextField(
                                      color: AppColors.white,
                                      controller: passwordContrller,
                                      hintText: "enter new pass".tr(),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validate: Validation().passwordValidation,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: LoginTextField(
                                        color: AppColors.white,
                                        hintText: "confirm pass".tr(),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validate: (s) {
                                          return Validation()
                                              .confirmPasswordValidation(
                                                  s, passwordContrller.text);
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          Widget cancelButton = TextButton(
                                            child: Text("لا"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          );
                                          Widget continueButton = TextButton(
                                            child: Text("نعم"),
                                            onPressed: () {
                                              cubit.updateUserPassword(context,
                                                  passwordContrller.text);
                                            },
                                          );

                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(
                                            // title: Text("AlertDialog"),
                                            content: Text(
                                                "لتكملة عمليه تغير كلمه المرور سيتم تسجيل الخروج اولا هل تريد المتابعه ؟"),
                                            actions: [
                                              cancelButton,
                                              continueButton,
                                            ],
                                          );

                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }
                                      },
                                      child: NeoText(
                                        "Update Password".tr(),
                                        color: AppColors.primiry,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: AppColors.white,
                                          shape: StadiumBorder()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ]),
                  )),
            );
          }),
    );
  }
}
