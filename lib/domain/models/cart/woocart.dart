import '../product/wooproduct.dart';

class WooCart {
  List<WooCartitems>? wooCartitems;
  int? itemsCount;
  int? itemsWeight;
  CartTotals? cartTotals;

  WooCart(
      {this.wooCartitems, this.itemsCount, this.itemsWeight, this.cartTotals});

  WooCart.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      wooCartitems = <WooCartitems>[];
      json['items'].forEach((v) {
        wooCartitems!.add(new WooCartitems.fromJson(v));
      });
    }
    itemsCount = json['items_count'];
    itemsWeight = json['items_weight'];
    cartTotals =
        json['totals'] != null ? new CartTotals.fromJson(json['totals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wooCartitems != null) {
      data['items'] = this.wooCartitems!.map((v) => v.toJson()).toList();
    }
    data['items_count'] = this.itemsCount;
    data['items_weight'] = this.itemsWeight;
    if (this.cartTotals != null) {
      data['totals'] = this.cartTotals!.toJson();
    }
    return data;
  }
}

class WooCartitems {
  String? key;
  int? id;
  int? quantity;
  int? quantityLimit;
  String? name;
  String? shortDescription;
  String? description;
  String? sku;
  String? permalink;
  List<WooProductImage>? wooCartItemImages;
  WooItemPrices? wooItemPrices;
  WooCartItemTotals? wooCartItemTotals;

  WooCartitems(
      {this.key,
      this.id,
      this.quantity,
      this.quantityLimit,
      this.name,
      this.shortDescription,
      this.description,
      this.sku,
      this.permalink,
      this.wooCartItemImages,
      this.wooItemPrices,
      this.wooCartItemTotals});

  WooCartitems.fromJson(Map<dynamic, dynamic> json) {
    key = json['key'];
    id = json['id'];
    quantity = json['quantity'];
    quantityLimit = json['quantity_limit'];
    name = json['name'];
    shortDescription = json['short_description'];
    description = json['description'];
    sku = json['sku'];
    permalink = json['permalink'];
    if (json['images'] != null) {
      wooCartItemImages = <WooProductImage>[];
      json['images'].forEach((v) {
        wooCartItemImages!.add(new WooProductImage.fromJson(v));
      });
    }
    wooItemPrices = json['prices'] != null
        ? new WooItemPrices.fromJson(json['prices'])
        : null;
    wooCartItemTotals = json['totals'] != null
        ? new WooCartItemTotals.fromJson(json['totals'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['quantity_limit'] = this.quantityLimit;
    data['name'] = this.name;
    data['short_description'] = this.shortDescription;
    data['description'] = this.description;
    data['sku'] = this.sku;
    data['permalink'] = this.permalink;
    if (this.wooCartItemImages != null) {
      data['images'] = this.wooCartItemImages!.map((v) => v.toJson()).toList();
    }
    if (this.wooItemPrices != null) {
      data['prices'] = this.wooItemPrices!.toJson();
    }
    if (this.wooCartItemTotals != null) {
      data['totals'] = this.wooCartItemTotals!.toJson();
    }
    return data;
  }
}

class WooCartItemImages {
  int? id;
  String? src;
  String? thumbnail;
  String? srcset;
  String? sizes;
  String? name;
  String? alt;

  WooCartItemImages(
      {this.id,
      this.src,
      this.thumbnail,
      this.srcset,
      this.sizes,
      this.name,
      this.alt});

  WooCartItemImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    thumbnail = json['thumbnail'];
    srcset = json['srcset'];
    sizes = json['sizes'];
    name = json['name'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['thumbnail'] = this.thumbnail;
    data['srcset'] = this.srcset;
    data['sizes'] = this.sizes;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class WooItemPrices {
  String? price;
  String? regularPrice;
  String? salePrice;
  Null? priceRange;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;
  RawPrices? rawPrices;

  WooItemPrices(
      {this.price,
      this.regularPrice,
      this.salePrice,
      this.priceRange,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyDecimalSeparator,
      this.currencyThousandSeparator,
      this.currencyPrefix,
      this.currencySuffix,
      this.rawPrices});

  WooItemPrices.fromJson(Map<dynamic, dynamic> json) {
    price = ((double.tryParse(json['price']) ?? 0) / 100).toString();
    regularPrice =
        ((double.tryParse(json['regular_price']) ?? 0) / 100).toString();
    salePrice = ((double.tryParse(json['sale_price']) ?? 0) / 100).toString();
    priceRange = json['price_range'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
    rawPrices = json['raw_prices'] != null
        ? new RawPrices.fromJson(json['raw_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] =
        ((double.tryParse(this.price ?? "0") ?? 0) * 100).toString();
    data['regular_price'] =
        ((double.tryParse(this.regularPrice ?? "0") ?? 0) * 100).toString();
    data['sale_price'] =
        ((double.tryParse(this.salePrice ?? "0") ?? 0) * 100).toString();
    data['price_range'] = this.priceRange;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    if (this.rawPrices != null) {
      data['raw_prices'] = this.rawPrices!.toJson();
    }
    return data;
  }
}

class RawPrices {
  int? precision;
  String? price;
  String? regularPrice;
  String? salePrice;

  RawPrices({this.precision, this.price, this.regularPrice, this.salePrice});

  RawPrices.fromJson(Map<String, dynamic> json) {
    precision = json['precision'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['precision'] = this.precision;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    return data;
  }
}

class WooCartItemTotals {
  String? lineSubtotal;
  String? lineSubtotalTax;
  String? lineTotal;
  String? lineTotalTax;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  WooCartItemTotals(
      {this.lineSubtotal,
      this.lineSubtotalTax,
      this.lineTotal,
      this.lineTotalTax,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyDecimalSeparator,
      this.currencyThousandSeparator,
      this.currencyPrefix,
      this.currencySuffix});

  WooCartItemTotals.fromJson(Map<String, dynamic> json) {
    lineSubtotal = json['line_subtotal'];
    lineSubtotalTax = json['line_subtotal_tax'];
    lineTotal = json['line_total'].toString().replaceFirst("00", "");
    lineTotalTax = json['line_total_tax'];
    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['line_subtotal'] = this.lineSubtotal;
    data['line_subtotal_tax'] = this.lineSubtotalTax;
    data['line_total'] = this.lineTotal;
    data['line_total_tax'] = this.lineTotalTax;
    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}

class CartTotals {
  String? totalItems;
  String? totalItemsTax;
  String? totalFees;
  String? totalFeesTax;
  String? totalDiscount;
  String? totalDiscountTax;
  String? totalShipping;
  String? totalShippingTax;
  String? totalPrice;
  String? totalTax;
  List<Null>? taxLines;
  String? currencyCode;
  String? currencySymbol;
  int? currencyMinorUnit;
  String? currencyDecimalSeparator;
  String? currencyThousandSeparator;
  String? currencyPrefix;
  String? currencySuffix;

  CartTotals(
      {this.totalItems,
      this.totalItemsTax,
      this.totalFees,
      this.totalFeesTax,
      this.totalDiscount,
      this.totalDiscountTax,
      this.totalShipping,
      this.totalShippingTax,
      this.totalPrice,
      this.totalTax,
      this.taxLines,
      this.currencyCode,
      this.currencySymbol,
      this.currencyMinorUnit,
      this.currencyDecimalSeparator,
      this.currencyThousandSeparator,
      this.currencyPrefix,
      this.currencySuffix});

  CartTotals.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    totalItemsTax = json['total_items_tax'];
    totalFees = json['total_fees'];
    totalFeesTax = json['total_fees_tax'];
    totalDiscount = json['total_discount'];
    totalDiscountTax = json['total_discount_tax'];
    totalShipping = json['total_shipping'].toString().replaceFirst("00", "");

    totalShippingTax = json['total_shipping_tax'];
    totalPrice = json['total_price'].toString().replaceFirst("00", "");
    totalTax = json['total_tax'];

    currencyCode = json['currency_code'];
    currencySymbol = json['currency_symbol'];
    currencyMinorUnit = json['currency_minor_unit'];
    currencyDecimalSeparator = json['currency_decimal_separator'];
    currencyThousandSeparator = json['currency_thousand_separator'];
    currencyPrefix = json['currency_prefix'];
    currencySuffix = json['currency_suffix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    data['total_items_tax'] = this.totalItemsTax;
    data['total_fees'] = this.totalFees;
    data['total_fees_tax'] = this.totalFeesTax;
    data['total_discount'] = this.totalDiscount;
    data['total_discount_tax'] = this.totalDiscountTax;
    data['total_shipping'] = this.totalShipping;
    data['total_shipping_tax'] = this.totalShippingTax;
    data['total_price'] = this.totalPrice;
    data['total_tax'] = this.totalTax;

    data['currency_code'] = this.currencyCode;
    data['currency_symbol'] = this.currencySymbol;
    data['currency_minor_unit'] = this.currencyMinorUnit;
    data['currency_decimal_separator'] = this.currencyDecimalSeparator;
    data['currency_thousand_separator'] = this.currencyThousandSeparator;
    data['currency_prefix'] = this.currencyPrefix;
    data['currency_suffix'] = this.currencySuffix;
    return data;
  }
}
