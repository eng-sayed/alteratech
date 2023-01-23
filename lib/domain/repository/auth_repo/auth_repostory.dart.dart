import 'dart:convert';

import 'package:alteratech/data/api/my_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utiles.dart';
import '../../endpoints/endpoint.dart';
import '../../models/customer/customer.dart';
import '../../models/jwt/jwt.dart';
import '../../models/user/user_model.dart';

class AuthRepository {
  static const String consumerKey =
      'ck_d5f8649bb3448e0c9361b9decff736ca82f33c32';
  static const String consumerSecret =
      'cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce';
  static Future<WooCustomer?> getUserData({
    required BuildContext context,
  }) async {
    final response1 = await MyDio.getData(context,
        url: EndPoints.URL_USER_ME, token: Utiles.token, loading: true);

    if (response1 != null) {
      print("response1.data.runtimeType");
      //print(response1.data.runtimeType);
      return WooCustomer.fromJson(response1.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> login({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    final response = await MyDio.postData(context,
        url: '/wp-json/api/v1/token',
        loading: true,
        query: {
          // "consumer_key": 'ck_d5f8649bb3448e0c9361b9decff736ca82f33c32',
          // "consumer_secret": "cs_52fd8dad5bacf1642721be6a7abf1fbf8a40ddce",
          "api_password": '@lter@Api2022'
        },
        body: {
          "username": username,
          "password": password,
        });

    if (response != null) {
      // print(jsonDecode(response.data)["jwt_token"]);
      Utiles.token = jsonDecode(response.data)["jwt_token"];
      //  Utiles.Username = response.data["user_display_name"].toString();

      // final userDataResponse = await DioHelper.getData(
      //   context,
      //   url: EndPoins.URL_USER_ME,
      //   loading: true,
      //   token: Utiles.token,
      //   query: {
      //     "consumer_key": AuthRepository.consumerKey,
      //     "consumer_secret": AuthRepository.consumerSecret
      //   },
      // );
      // print("userDataResponse.data.runtimeType");
      // print(userDataResponse?.data.runtimeType);

      // //http.get(Uri.parse(this.baseUrl + URL_USER_ME), headers: _urlHeader);

      final customer = await getUserData(context: context);
      print(customer!.id);
      if (customer != null) {
        print(customer.id);
        print(customer.name);
        Utiles.UserId = customer.id.toString();
        Utiles.Username = customer.name!;

        return customer;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> getCustomerData({
    required BuildContext context,
    required String Id,
  }) async {
    final response = await MyDio.getData(
      context,
      url: EndPoints.DEFAULT_WC_API_PATH + 'customers/$Id',
      query: {
        "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
        "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
      },
    );
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> register({
    required BuildContext context,
    required WooCustomer registerRequest,
  }) async {
    final response = await MyDio.postData(context,
        url: EndPoints.DEFAULT_WC_API_PATH + 'customers',
        loading: true,
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        },
        body: registerRequest.toJson());
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<WooCustomer?> updateUserData({
    required BuildContext context,
    required WooCustomer registerRequest,
  }) async {
    final response = await MyDio.putData(context,
        url: EndPoints.DEFAULT_WC_API_PATH + 'customers/${Utiles.UserId}',
        loading: true,
        body: registerRequest.toJson(),
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        });
    if (response != null) {
      return WooCustomer.fromJson(response.data);
    } else {
      return null;
    }
  }

  static Future<bool?> forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    final response = await MyDio.getData(context,
        url: '${EndPoints.DEFAULT_WC_API_PATH}emails/lost-password',
        loading: true,
        query: {"login": email});
    if (response!.data['code'] == '101') {
      return false;
    } else {
      return true;
    }
  }

  // static Future<UserModel?> restPassword({
  //   required BuildContext context,
  //   required String email,
  // }) async {
  //   final response = await MyDio.postData(context,
  //       url: EndPoints.restPass,
  //       loading: true,
  //       query: {'login':email});
  //   if (response != null) {
  //     return UserModel.fromJson(response.data);
  //   } else {
  //     return null;
  //   }
  // }

  static Future<WooCustomer?> deleteUserData(
      {required BuildContext context, required String customerId}) async {
    final response1 = await MyDio.deleteData(context,
        url: EndPoints.DEFAULT_WC_API_PATH +
            EndPoints.deleteCustomer(customerId),
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a",
          "force": true
        },
        token: Utiles.token,
        loading: true);

    if (response1 != null) {
      return WooCustomer.fromJson(response1.data);
    } else {
      return null;
    }
  }
}
