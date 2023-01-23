import 'package:alteratech/domain/models/product/wooproduct.dart';

class WooWishList {
  List<WooProduct>? wishList;

  WooWishList({this.wishList});

  WooWishList.fromJson(Map<String, dynamic> json) {
    if (json['WishList'] != null) {
      wishList = <WooProduct>[];
      json['WishList'].forEach((v) {
        wishList!.add(new WooProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wishList != null) {
      data['WishList'] = this.wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishListItem {
  int? itemId;
  int? productId;
  int? variationId;
  List<Null>? meta;
  String? dateAdded;
  String? name;
  String? price;
  String? saLePrice;
  bool? inStock;
  bool? onSale;
  String? image;

  WishListItem(
      {this.itemId,
      this.productId,
      this.variationId,
      this.meta,
      this.dateAdded,
      this.name,
      this.price,
      this.saLePrice,
      this.onSale,
      this.inStock,
      this.image});

  WishListItem.fromJson(Map<dynamic, dynamic> json) {
    itemId = json['item_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];

    name = json['name'];
    dateAdded = json['date_added'];
    price = json['price'];
    onSale = json['on_sale'];
    saLePrice = json['sale_price'];
    inStock = json['in_stock'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_id'] = this.itemId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['date_added'] = this.dateAdded;
    data['price'] = this.price;
    data['sale_price'] = this.saLePrice;
    data['on_sale'] = this.onSale;

    data['in_stock'] = this.inStock;
    return data;
  }
}
