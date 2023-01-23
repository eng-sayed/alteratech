import 'dart:developer';

import 'package:alteratech/presentation/screens/main_screen/screens/main_screen.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/navigator.dart';
import '../../../../core/utils/utiles.dart';
import '../../../../domain/models/customer/customer.dart';
import '../../../../domain/models/order/wooorder_payload.dart';
import '../../../../domain/models/zones/shippingzone.dart';
import '../../../../domain/models/zones/zone_model.dart';
import '../../../../domain/repository/auth_repo/auth_repostory.dart.dart';

import 'states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  TextEditingController firstNameBilling = TextEditingController();
  TextEditingController lastNameBilling = TextEditingController();
  TextEditingController emailBilling = TextEditingController();
  TextEditingController adressBilling = TextEditingController();
  TextEditingController adressShipping = TextEditingController();
  //  TextEditingController postCodeBilling;
  TextEditingController phoneNumberBilling = TextEditingController();
  List<WooZonesModel> zones = [];
  getUserDate(context) async {
    emit(GetCustomerDataLoadingState());
    final response = await AuthRepository.getCustomerData(
        context: context, Id: Utiles.UserId);

    if (response != null) {
      firstNameBilling.text = response.firstName ?? "";
      lastNameBilling.text = response.lastName ?? "";
      emailBilling.text = response.email ?? "";
      adressBilling.text = response.billing?.address1 ?? "";
      phoneNumberBilling.text = response.billing?.phone ?? "";

      adressShipping.text = response.shipping?.address1 ?? "";

      emit(GetCustomerDataSuccessState());
    } else {
      emit(GetCustomerDataErrorState());
    }
  }

  updateUserData(context) async {
    emit(UpdateCustomerDataLoadingState());
    final response = await AuthRepository.updateUserData(
        context: context,
        registerRequest: WooCustomer(
          firstName: firstNameBilling.text,
          lastName: lastNameBilling.text,
          email: emailBilling.text,
          billing: Billing(
            address1: adressBilling.text,
            phone: phoneNumberBilling.text,
            firstName: firstNameBilling.text,
            lastName: lastNameBilling.text,
          ),
        ));
    if (response != null) {
      emit(UpdateCustomerDataSuccessState());
      Alerts.snak(
          context: context,
          message: "تم تعديل البيانات بنجاح",
          type: ContentType.success);
    } else {
      emit(UpdateCustomerDataErrorState());
    }
  }

  updateUserPassword(context, String password) async {
    emit(UpdateCustomerDataLoadingState());
    final response = await AuthRepository.updateUserData(
        context: context,
        registerRequest: WooCustomer(
          password: password,
        ));
    if (response != null) {
      Utiles.logout();
      navigateReplacement(context: context, route: MainScreen());
      emit(UpdateCustomerDataSuccessState());
    } else {
      emit(UpdateCustomerDataErrorState());
    }
  }

  deleteUser(context) async {
    emit(DeleteCustomerDataLoadingState());
    final response = await AuthRepository.deleteUserData(
        context: context, customerId: Utiles.UserId);
    if (response != null) {
      Utiles.logout();
      navigateReplacement(context: context, route: MainScreen());
      emit(DeleteCustomerDataSuccessState());
    } else {
      Alerts.snak(
          context: context, message: "error".tr(), type: ContentType.failure);
      emit(DeleteCustomerDataErrorState());
    }
  }
}
