import 'dart:developer';

import 'package:alteratech/presentation/screens/auth/cubit/state.dart';
import 'package:alteratech/presentation/screens/main_screen/screens/main_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';

import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/utiles.dart';
import '../../../../data/hive/hive.dart';
import '../../../../data/local/shared.dart';
import '../../../../domain/models/customer/customer.dart';
import '../../../../domain/repository/auth_repo/auth_repostory.dart.dart';
import '../screens/auth_screen.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  regiser(context, {required WooCustomer customer}) async {
    // emit(RegisterLoadingState());
    final response = await AuthRepository.register(
        context: context, registerRequest: customer);
    if (response != null) {
      Navigator.pop(context);
      navigate(context: context, route: AuthScreen());
      Alerts.snak(
          context: context,
          type: ContentType.success,
          message: "register success".tr());

      emit(RegisterSuccessState());
      return true;
    } else {
      Navigator.pop(context);

      emit(RegisterErrorState());
      return false;
    }
  }

  // sendOtp(context) async {
  //   final response = await AuthRepository.sendOtp(
  //       context: context, phone: registerRequest.phone ?? "");
  //   if (response != null) {
  //     emit(SendOtpSuccessState());
  //   } else {
  //     emit(SendOtpErrorState());
  //   }
  // }

  saveToken() {
    MyShared.saveData(key: "token", value: Utiles.token);
    MyShared.saveData(key: "userid", value: Utiles.UserId);
    MyShared.saveData(key: "username", value: Utiles.Username);
  }

  login(
    context, {
    required String username,
    required String password,
  }) async {
    // emit(LoginLoadingState());
    final response = await AuthRepository.login(
      context: context,
      username: username,
      password: password,
    );

    if (response != null) {
      // HiveLocal.localCart!.isEmpty
      //  ? // navigateReplacement(context: context, route: Home())
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => MainScreen()),
      //     (route) => false)
      //: showDialog(context: context, builder: (context) => UploadCart());
      navigateReplacement(context: context, route: MainScreen());
      saveToken();
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState());
    }
  }

  forgetPassword(context, String email) async {
    final response =
        await AuthRepository.forgetPassword(context: context, email: email);
    if (response == true) {
      emit(ForgotPasswordSuccessState());
      Alerts.snak(
          context: context,
          message: "restpasssent".tr(),
          type: ContentType.success);
    } else {
      Alerts.snak(
          context: context,
          message: "notfndusr".tr(),
          type: ContentType.failure);

      emit(ForgotPasswordErrorState());
    }
  }

  // restPassword(context) async {
  //   final response = await AuthRepository.restPassword(
  //       context: context, forgetPassRequest: forgetPassRequest);
  //   if (response != null) {
  //     emit(ResetPasswordSuccessState());
  //   } else {
  //     emit(ResetPasswordErrorState());
  //   }
  // }
}
