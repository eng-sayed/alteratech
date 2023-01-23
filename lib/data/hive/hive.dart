import 'package:hive_flutter/hive_flutter.dart';

class HiveLocal {
  static Box? localCart;
  static Box? localWishList;

  static init() async {
    await Hive.initFlutter();
    localCart = await Hive.openBox('cart');
    localWishList = await Hive.openBox('wishList');
  }
}
