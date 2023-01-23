import 'package:alteratech/data/api/my_dio.dart';
import 'package:alteratech/domain/models/cart/woocart.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/utiles.dart';
import '../../../data/hive/hive.dart';
import '../../endpoints/endpoint.dart';
import '../../models/product/wooproduct.dart';

class CartRepo {
  static deleteItemCart(context, {required key, required id}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await MyDio.deleteData(context,
          url: EndPoints.URL_Default_Api_path + 'cart/items/$key',
          loading: true,
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      HiveLocal.localCart!.delete(id);
      return true;
    }
  }

  static Future<WooCart?> getCart({
    required BuildContext context,
  }) async {
    if (Utiles.token.isNotEmpty) {
      final response = await MyDio.getData(context,
          url: EndPoints.URL_Default_Api_path + 'cart',
          query: {
            "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
            "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
          },
          // loading: true,
          token: Utiles.token);
      if (response != null) {
        print('aaaaaaaaaaaaa');
        print(response.headers.value("x-wc-store-api-nonce"));
        Utiles.x_WC_Store =
            response.headers.value("x-wc-store-api-nonce") ?? "";

        return WooCart.fromJson(response.data);
      } else {
        return WooCart.fromJson({'items': []});
      }
    } else {
      List<WooCartitems>? localItems = [];
      double totalCartPrice = 0.0;
      int count = 0;
      HiveLocal.localCart?.values.forEach((element) {
        final model = WooCartitems.fromJson(element);
        localItems.add(model);
        totalCartPrice +=
            double.parse(model.wooItemPrices!.price!) * model.quantity!;
        count += model.quantity!;
      });
      localItems;
      return WooCart(
          itemsCount: count,
          wooCartitems: localItems,
          cartTotals: CartTotals(
              totalPrice: totalCartPrice.toString(), totalShipping: "10"));
    }
  }

  static addToCart(context,
      {required WooProduct product, required quantity}) async {
    if (Utiles.token.isNotEmpty) {
      final response = await MyDio.postData(context,
          loading: true,
          body: {
            "id": product.id,
            "quantity": quantity,
          },
          query: {
            "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
            "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
          },
          url: EndPoints.URL_Default_Api_path + 'cart/add-item',
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      final selectedProduct = HiveLocal.localCart!.get(product.id);
      if (selectedProduct == null) {
        await HiveLocal.localCart!.put(
            product.id,
            WooCartitems(
                    name: product.name,
                    id: product.id,
                    quantity: quantity,
                    wooItemPrices: WooItemPrices(
                        regularPrice: product.price,
                        price: product.price,
                        salePrice: product.salePrice ?? ""),
                    wooCartItemImages: product.images)
                .toJson());
        return true;
      } else {
        WooCartitems model = WooCartitems.fromJson(selectedProduct);
        HiveLocal.localCart!.put(
            product.id,
            WooCartitems(
                    name: product.name,
                    id: product.id,
                    quantity: quantity + model.quantity!,
                    wooItemPrices: WooItemPrices(
                        price: product.price, salePrice: product.salePrice),
                    wooCartItemImages: product.images)
                .toJson());
        return true;
      }
    }
  }

  static updateToCart(context,
      {required id,
      required WooCartitems product,
      required quantity,
      required key}) async {
    if (Utiles.token.isNotEmpty) {
      print('object');
      final response = await MyDio.putData(context,
          loading: true,
          body: {
            "id": id,
            "key": key,
            "quantity": quantity,
          },
          url: EndPoints.URL_Default_Api_path + 'cart/items/$key',
          token: Utiles.token);
      if (response != null) {
        return true;
      } else {
        return null;
      }
    } else {
      await HiveLocal.localCart!.put(
          product.id,
          WooCartitems(
                  name: product.name,
                  id: product.id,
                  quantity: quantity,
                  wooItemPrices: product.wooItemPrices,
                  wooCartItemImages: product.wooCartItemImages)
              .toJson());
      return true;
    }
  }
}
