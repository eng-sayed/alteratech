import 'package:alteratech/data/api/my_dio.dart';
import '../../../core/utils/utiles.dart';
import '../../endpoints/endpoint.dart';
import '../../models/order/wooorder.dart';
import '../../models/order/wooorder_payload.dart';
import '../../models/zones/shippingzone.dart';
import '../../models/zones/zone_model.dart';

class OrderRepo {
  static createOrder(context, {required WooOrderPayload orderPayload}) async {
    final response = await MyDio.postData(context,
        url: EndPoints.DEFAULT_WC_API_PATH + 'orders',
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        },
        loading: true,
        body: orderPayload.toJson());
    if (response != null) {
      return true;
    }
  }

  static Future<List<WooOrder>?> getOrders(context) async {
    final response = await MyDio.getData(context,
        url: EndPoints.DEFAULT_WC_API_PATH + 'orders',
        query: {
          "page": 1,
          "perPage": 100,
          "customer": Utiles.UserId,
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        });
    if (response != null) {
      List<WooOrder> list = [];
      for (var o in response.data) {
        var order = WooOrder.fromJson(o);
        list.add(order);
      }
      return list;
    }
  }

  static Future<List<WooZonesModel>?> getZones(context) async {
    final response = await MyDio.getData(context,
        url: '/wp-json/wc/v3/shipping/zones',
        token: Utiles.token,
        query: {
          "consumer_key": "ck_6fa8aba3d2b7a2dc08138bb34d5c4656bb37b5ea",
          "consumer_secret": "cs_40b46d56bbca9be9ce1332ebe1e8a16fd6315a5a"
        });
    if (response != null) {
      List<WooZonesModel> zones = [];
      for (var o in response.data) {
        var order = WooZonesModel.fromJson(o);
        zones.add(order);
      }
      return zones;
    }
  }

  static Future<List<WooShippingZoneMethod>?> getShippingforZone(
      context, int id) async {
    final response = await MyDio.getData(
      context,
      loading: true,
      url: EndPoints.DEFAULT_WC_API_PATH +
          'shipping/zones/' +
          id.toString() +
          '/methods',
      query: {
        "consumer_key": "ck_ab3b6b639b4a824e36e8381b37533ac0efebe534",
        "consumer_secret": "cs_c3bc5b2bc5509e024d90db4e6824d0715df32951"
      },
    );
    if (response != null) {
      List<WooShippingZoneMethod> zones = [];
      for (var o in response.data) {
        var order = WooShippingZoneMethod.fromJson(o);
        zones.add(order);
      }
      return zones;
    }
  }
}
