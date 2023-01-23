import 'dart:developer';

import 'package:alteratech/domain/endpoints/endpoint.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../core/utils/utiles.dart';

class MyDio {
  static Dio myDio = Dio();
  static String baseUrl = 'https://alteratech-eg.com';
  static void init() {
    myDio = Dio(
      BaseOptions(
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          queryParameters: {
            EndPoints.Api_password: '@lter@Api2022'
          },
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 30000,
          receiveTimeout: 30000,
          sendTimeout: 30000),
    )..interceptors.add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        ),
      );
  }

  static Future<Response?> deleteData(
    BuildContext context, {
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? base,
    bool loading = false,
  }) async {
    myDio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      "X-WC-Store-API-Nonce": Utiles.x_WC_Store
    };

    try {
      if (loading) {
        //  MyLoading.show(context);
      }
      final response =
          await myDio.delete((base ?? baseUrl) + url, queryParameters: query);
      if (loading) {
        // MyLoading.dismis(context);
      }
      return response;
    } on DioError catch (e) {
      getDioError(e: e, context: context);
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> putData(
    BuildContext context, {
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String? token,
    String? base,
    bool loading = false,
    bool isForm = false,
  }) async {
    myDio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      "X-WC-Store-API-Nonce": Utiles.x_WC_Store
    };
    if (token == null) {
      myDio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "X-WC-Store-API-Nonce": Utiles.x_WC_Store
      };
    }
    try {
      if (loading) {
        // MyLoading.show(context);
      }
      final response = await myDio.put((base ?? baseUrl) + url,
          queryParameters: query,
          data: isForm ? FormData.fromMap(body ?? {}) : body);
      if (loading) {
        // MyLoading.dismis(context);
      }
      return response;
    } on DioError catch (e) {
      getDioError(e: e, context: context);
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> getData(
    BuildContext context, {
    required String url,
    Map<String, dynamic>? query,
    String? token,
    String? base,
    bool loading = false,
  }) async {
    if (token == null) {
      myDio.options.headers.addAll({"X-WC-Store-API-Nonce": Utiles.x_WC_Store});
    } else {
      myDio.options.headers.addAll({
        "X-WC-Store-API-Nonce": Utiles.x_WC_Store,
        'Authorization': 'Bearer $token',
      });
    }

    myDio.options.queryParameters.addAll(query ?? {});
    try {
      final response = await myDio.get(((base ?? baseUrl)) + url);
      return response;
    } on DioError catch (e) {
      getDioError(e: e, context: context);
    } catch (e) {
      return null;
    }
  }

  static Future<Response?> postData(
    BuildContext context, {
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String? token,
    String? base,
    bool loading = false,
    bool isForm = false,
  }) async {
    myDio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      "X-WC-Store-API-Nonce": Utiles.x_WC_Store
    };
    if (token == null) {
      myDio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "X-WC-Store-API-Nonce": Utiles.x_WC_Store
      };
    }
    try {
      if (loading) {
        //  MyLoading.show(context);
      }
      final response = await myDio.post((base ?? baseUrl) + url,
          queryParameters: query,
          data: isForm ? FormData.fromMap(body ?? {}) : body);
      if (loading) {
        // MyLoading.dismis(context);
      }
      return response;
    } on DioError catch (e) {
      getDioError(e: e, context: context);
    } catch (e) {
      return null;
    }
  }

  static getDioError({required DioError e, required BuildContext context}) {
    log("---------------autherrr");
    // MyLoading.dismis(context);

    if (DioErrorType.receiveTimeout == e.type ||
        DioErrorType.connectTimeout == e.type) {
      // OverLays.snack(context,
      //     text: "Connetion timeout", state: SnakState.failed);
      log('case 1');
      log('Server is not reachable. Please verify your internet connection and try again');
    } else if (DioErrorType.response == e.type) {
      log('case 2');
      log('Server reachable. Error in resposne');
      // OverLays.snack(context,
      //     text: e.response?.data["message"] ?? "لا يمكن الوصول للسيرفير",
      //     state: SnakState.failed);

      log("hello im errroe");
      if (e.response!.statusCode == 401) {
        // OverLays.snack(context,
        //     text: e.response!.data["message"], state: SnakState.failed);
      }
    } else if (DioErrorType.other == e.type) {
      if (e.message.contains('SocketException')) {
        log('Network error');
        log('case 3');
        // OverLays.snack(context, text: "No Network", state: SnakState.failed);
      }
    } else {
      // show snak server error

      log('case 4');
      log('Problem connecting to the server. Please try again.');
    }
    return null;
  }
}
