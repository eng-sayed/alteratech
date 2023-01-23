import 'dart:math';

import 'package:alteratech/core/utils/alerts.dart';
import 'package:alteratech/data/api/my_dio.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/utils/utiles.dart';
import '../../../data/hive/hive.dart';
import '../../endpoints/endpoint.dart';
import '../../models/product/wooproduct.dart';
import '../../models/wishlist/woowishlist.dart';

class WishListRepo {
  static addToWishList(context, WooProduct product) async {
    if (Utiles.token.isNotEmpty) {
      Utiles.wishListKey.isEmpty ? await getWishlistKey(context) : null;
      print('Utiles.wishListKey');
      print(Utiles.wishListKey);

      final response = await MyDio.postData(context,
          loading: true,
          url: EndPoints.DEFAULT_WC_API_PATH +
              'wishlist/${Utiles.wishListKey}/add_product',
          query: {
            "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
            "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
          },
          token: Utiles.token,
          body: {'product_id': product.id.toString()});
      if (response != null) {
        return WooProduct.fromJson(response.data.first);
      }
    } else {
      HiveLocal.localWishList!.put(
          product.id,
          WooProduct(
                  images: product.images!.isEmpty ? [] : product.images,
                  id: product.id,
                  price: product.regularPrice,
                  salePrice: product.salePrice,
                  onSale: product.onSale,
                  stockStatus: product.stockStatus,
                  name: product.name)
              .toJson());
      return true;
    }
  }

  static Future<WooWishList?> getWishlist(context) async {
    if (Utiles.token.isNotEmpty) {
      print("Utiles.wishListKey");
      print(Utiles.wishListKey);
      //  Utiles.wishListKey.isEmpty ? await getWishlistKey(context) : null;

      final response = await MyDio.getData(context,
          url: EndPoints.URL_STORE_API_PATH + 'getWishtListForUserID',
          query: {'id': Utiles.UserId});
      if (response != null) {
        return WooWishList.fromJson({"WishList": response.data['WishList']});
      } else {
        return null;
      }
    } else {
      List<WooProduct> items = [];

      HiveLocal.localWishList!.values.forEach((element) {
        print(element);
        items.add(WooProduct.fromJson(element));
      });
      return WooWishList(wishList: items);
    }
  }

  static getWishlistKey(context) async {
    final response = await MyDio.getData(context,
        token: Utiles.token,
        url: EndPoints.DEFAULT_WC_API_PATH +
            'wishlist/get_by_user/${Utiles.UserId}',
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        });
    if (response != null) {
      Utiles.wishListKey = response.data.first["share_key"];
      return true;
    }
  }

  static deletWishList(context,
      {required int productID, required String wishListid}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await MyDio.getData(context,
          loading: true,
          url: EndPoints.DEFAULT_WC_API_PATH +
              'wishlist/remove_product/$wishListid',
          query: {
            "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
            "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
          },
          token: Utiles.token);
      if (response != null) {
        return true;
      }
    } else {
      HiveLocal.localWishList!.delete(productID);
      return true;
    }
  }
}
