import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/validation.dart';
import '../../../../domain/models/customer/customer.dart';
import '../../../components/login_text_failed.dart';
import '../cubit/cubit.dart';
import '../cubit/state.dart';

class Auth extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthState();
  }
}

class AuthState extends State {
  late FlipCardController _controller;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  bool isSignUp = false;
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
  void initState() {
    super.initState();
    _controller = FlipCardController();
  }

// child: FlipCard(
//   controller: _controller,
// )
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Scaffold(
            body: Center(
              child: Stack(children: [
                Positioned(
                  top: 25,
                  right: -90,
                  child: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.deepPurpleAccent,
                            Colors.purpleAccent,
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 100,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: -90,
                  child: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 100,
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: -90,
                  child: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.deepPurpleAccent,
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.deepPurpleAccent,
                    radius: 100,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCard(
                        controller: _controller,
                        flipOnTouch: false,
                        front: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: double.infinity,
                            height: 500,
                            child: Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "login".tr(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 45,
                                    ),
                                    Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: LoginTextField(
                                          controller: username,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validate: !isSignUp
                                              ? (Validation().defaultValidation)
                                              : (f) {},
                                          hintText: "usrname".tr(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: LoginTextField(
                                        controller: password,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validate: !isSignUp
                                            ? (Validation().passwordValidation)
                                            : (f) {},
                                        hintText: "password".tr(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 55),
                                      width: double.infinity,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.blue,
                                              Colors.deepPurpleAccent,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            WooCustomer wooUser = WooCustomer(
                                                email: email.text.trim(),
                                                username: username.text.trim(),
                                                password: password.text.trim());
                                            cubit.login(context,
                                                username: username.text.trim(),
                                                password: password.text.trim());
                                          }
                                        },
                                        child: Text(
                                          "login".tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('or'.tr()),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 55),
                                      width: double.infinity,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              Colors.blue,
                                              Colors.deepPurpleAccent,
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: MaterialButton(
                                        onPressed: () {
                                          isSignUp = true;
                                          setState(() {});
                                          _controller.toggleCard();
                                        },
                                        child: Text(
                                          'register'.tr(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            //fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        back: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.w),
                            width: double.infinity,
                            height: 600.h,
                            child: Card(
                              elevation: 20,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "register".tr(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: LoginTextField(
                                      controller: email,
                                      keyboardType: TextInputType.emailAddress,
                                      validate: isSignUp
                                          ? (Validation().emailValidation)
                                          : (f) {},
                                      // Validation().emailValidation,
                                      suffixIcon: Icon(Icons.email),
                                      hintText: "email".tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: LoginTextField(
                                      controller: username,
                                      keyboardType: TextInputType.emailAddress,
                                      validate: isSignUp
                                          ? (Validation().defaultValidation)
                                          : (f) {},
                                      hintText: "username".tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: LoginTextField(
                                      controller: password,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validate: isSignUp
                                          ? (Validation().passwordValidation)
                                          : (f) {},
                                      hintText: "password".tr(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 55),
                                    width: double.infinity,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue,
                                            Colors.deepPurpleAccent,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          WooCustomer wooUser = WooCustomer(
                                              email: email.text.trim(),
                                              username: username.text.trim(),
                                              password: password.text.trim());
                                          cubit
                                              .regiser(
                                            context,
                                            customer: wooUser,
                                          )
                                              .then((value) {
                                            if (value) {
                                              isSignUp = false;
                                              setState(() {});
                                            }
                                          });
                                        }
                                      },
                                      child: Text(
                                        "register".tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text('or'.tr()),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 55),
                                    width: double.infinity,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Colors.blue,
                                            Colors.deepPurpleAccent,
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: MaterialButton(
                                      onPressed: () {
                                        isSignUp = false;
                                        setState(() {});
                                        _controller.toggleCard();
                                      },
                                      child: Text(
                                        'login'.tr(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: NeoText(
                          'reset'.tr(),
                          color: Colors.blue,
                          size: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          );
        });
  }
}
