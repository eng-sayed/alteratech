import 'package:alteratech/domain/endpoints/endpoint.dart';

import '../../../core/utils/utiles.dart';
import '../../../data/api/my_dio.dart';
import '../../models/category/woocategory.dart';
import '../../models/product/wooproduct.dart';
import '../../models/wooslider.dart/wooslider.dart';

class HomeRepository {
  static Future<List<WooProduct>?> getProduct(context,
      {int page = 1,
      String? search,
      String? orderBy,
      String? maxPrice,
      bool? onSale,
      perPage = 20,
      String? minPrice,
      List<int>? incloud,
      String? order,
      int? categorie,
      bool? featured}) async {
    Map<String, dynamic> payload = {
      "consumer_key": Utiles.consumer_key,
      "consumer_secret": Utiles.consumer_secret
    };

    ({
      'page': page,
      'per_page': perPage,
      'search': search,
      'order': order,
      'orderby': orderBy,
      'featured': featured,
      'category': categorie,
      "status": "publish",
      'on_sale': onSale,
      'min_price': minPrice,
      "include": incloud,
      'max_price': maxPrice,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await MyDio.getData(context,
        url: EndPoints.URL_STORE_API_PATH + EndPoints.URL_Get_Products,
        query: payload);
    //  products.addAll(theResposne);
    if (response != null) {
      List<WooProduct> list = [];
      for (var o in response.data["Products"]) {
        var order = WooProduct.fromJson(o);
        list.add(order);
      }
      return list;
    }

    return null;
  }

  static Future<List<WooProductCategory>?> getCategory(
    context, {
    int page = 1,
    String? search,
    String? orderBy,
  }) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': 100,
      'search': search,
      'orderby': orderBy,
      'hide_empty': true,
      'parent': 0,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await MyDio.getData(context,
        url: EndPoints.URL_STORE_API_PATH + EndPoints.URL_Get_Category,
        query: payload);
    if (response != null) {
      List<WooProductCategory> allCategory = [];
      for (var o in response.data['Categories']) {
        var order = WooProductCategory.fromJson(o);
        allCategory.add(order);
      }
      return allCategory;
    }

    return null;
  }

  static Future<List<WooProductCategory>?> getSubCategory(
    context, {
    int page = 1,
    String? search,
    String? orderBy,
    required int? parent,
  }) async {
    Map<String, dynamic> payload = {};

    ({
      'page': page,
      'per_page': 100,
      'search': search,
      'orderby': orderBy,
      'hide_empty': true,
      'id': parent,
    }).forEach((k, v) {
      if (v != null) payload[k] = v.toString();
    });
    final response = await MyDio.getData(context,
        url: EndPoints.URL_STORE_API_PATH + EndPoints.URL_Get_SubCategory,
        query: payload);
    //  products.addAll(theResposne);
    if (response != null) {
      List<WooProductCategory> list = [];
      for (var o in response.data['Sub-Categories']) {
        var order = WooProductCategory.fromJson(o);
        list.add(order);
      }
      return list;
    }

    return null;
  }

  static Future<WooProduct?> singelProduct(context, String id) async {
    final response = await MyDio.getData(context,
        url: EndPoints.URL_STORE_API_PATH + EndPoints.URL_Get_SingleProduct,
        query: {"id": id});
    //  products.addAll(theResposne);
    if (response != null) {
      return WooProduct.fromJson(response.data['Product'][0]);
    }
  }

  static Future<Map<String, dynamic>?> homeRequest(context) async {
    final response = await MyDio.getData(context,
        url: EndPoints.URL_STORE_API_PATH + EndPoints.URL_All_data,
        query: {
          "consumer_key": Utiles.consumer_key,
          "consumer_secret": Utiles.consumer_secret,
          'page': 1
        });
    List<WooProduct> featuerdProduct = [];
    List<WooProduct> trendingProduct = [];
    List<WooMobileSlider> sliders = [];
    List<WooProduct> shop = [];
    List<WooProductCategory> cat = [];
    if (response != null) {
      (response.data["All"]["Featured-Products"] ?? []).forEach((element) {
        featuerdProduct.add(WooProduct.fromJson(element));
        print(element.toString());
      });
      (response.data["All"]["Trending-Products"] ?? []).forEach((element) {
        trendingProduct.add(WooProduct.fromJson(element));
        print(element.toString());
      });
      (response.data["All"]["All-Products"] ?? []).forEach((element) {
        shop.add(WooProduct.fromJson(element));
        print(element.toString());
      });
      (response.data["All"]["Categories"] ?? []).forEach((element) {
        cat.add(WooProductCategory.fromJson(element));
        print(element.toString());
      });

      (response.data["All"]["Sliders"] ?? []).forEach((element) {
        sliders.add(WooMobileSlider.fromJson(element));
      });
      return {
        "featured": featuerdProduct,
        "sliders": sliders,
        "shop": shop,
        "cat": cat,
        'trend': trendingProduct
      };
    }
  }
}
