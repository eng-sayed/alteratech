import 'dart:math';

import 'package:easy_localization/easy_localization.dart' as trans;
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import '../../core/utils/navigator.dart';
import '../../domain/models/product/wooproduct.dart';
import '../screens/favourite_button/fav_button.dart';
import '../screens/product/screens/product.dart';
import 'my+text.dart';
import 'network_image.dart';

class ProductWidget extends StatefulWidget {
  // final int index;
  ProductWidget({Key? key, required this.products, this.isTrend = false})
      : super(key: key);
  final WooProduct products;
  final bool isTrend;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String sale(String sale, String regular) {
    double mySale = double.tryParse(sale) ?? 0;
    double myRegular = double.tryParse(regular) ?? 0;
    var result = 100 - (mySale / myRegular) * 100;
    return '${result.toStringAsFixed(1)} %';
  }

  bool incart = false;
  int count = 1;
  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        navigate(
          context: context,
          route: ProductDetails(
            wooProduct: widget.products,
          ),
        );
      },
      child: Stack(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  decoration: new BoxDecoration(
                      // boxShadow: [
                      //   new BoxShadow(
                      //     color: Colors.grey,
                      //     blurRadius: 10.0,
                      //   ),
                      // ],
                      ),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        // height: 3000,
                        child: Column(
                          mainAxisAlignment: widget.isTrend
                              ? MainAxisAlignment.center
                              : MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                height: widget.isTrend ? 140 : 120,
                                width: double.infinity,
                                child: widget.products.images!.isEmpty
                                    ? Image.asset("assets/images/logo.png")
                                    : NetworkImagesWidgets(
                                        widget.products.images!.first.src!,
                                        fit: BoxFit.contain)),
                            // TODO
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: NeoText(
                                widget.products.name!,
                                size: 15,
                                align: TextAlign.center,
                                maxLines: 1,
                                color: AppColors.black,
                              ),
                            ),
                            if (widget.isTrend)
                              NeoText(
                                "Trending Now",
                                color: Colors.black,
                                size: 13,
                              ),
                            // CustomText("Trending Now",
                            //     style: categoryStyle(color: AppColors.primiry)),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                //TODO
                                //
                                ////  CustomText(mmm[widget.index].price!,
                                //style: mainText(size: 15)),
                                !widget.products.onSale!
                                    ? NeoText(
                                        "${double.tryParse(widget.products.regularPrice ?? '0')} ${"sr".tr()} ",
                                        size: 16,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold)
                                    : Row(
                                        children: [
                                          NeoText(
                                              "${double.tryParse(widget.products.regularPrice ?? '0')} ${"sr".tr()} ",
                                              size: 13,
                                              color: AppColors.greyText,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          NeoText(
                                              "${double.tryParse(widget.products.salePrice ?? '0')} ${"sr".tr()} ",
                                              size: 16,
                                              color: AppColors.red,
                                              fontWeight: FontWeight.w600),
                                          //Spacer(),
                                        ],
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // if (widget.products.onSale!)
                      //   Banner(
                      //     message: sale(widget.products.salePrice!,
                      //         widget.products.regularPrice!),
                      //     location: BannerLocation.topEnd,
                      //     color: Colors.red,
                      //   )
                    ],
                  ),
                ),
              ),
              widget.products.stockStatus == 'outofstock'
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: widget.isTrend ? 40 : 20),
                        child: Container(
                          child: Image.asset(
                            'assets/images/sold.png',
                            width: 150,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent.withOpacity(.0),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Positioned.directional(
              textDirection: context.locale == Locale('en', 'US')
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              top: 20,
              start: 20,
              child:
                  // FavouritButton(
                  //   product: widget.products,
                  // )

                  //   Consumer<WishlListController>(builder: (context, value, child) {
                  // return
                  FavouriteButton(
                product: widget.products,
              )
              //   }),
              ),
        ],
      ),
    );
  }
}

//mixin WishlListController {}
