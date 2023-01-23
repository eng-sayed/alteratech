import 'package:alteratech/core/utils/navigator.dart';
import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/cart/cubit/cart_cubit.dart';
import 'package:alteratech/presentation/screens/cart/screens/cart.dart';
import 'package:alteratech/presentation/screens/product/cubit/product_cubit.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/themes/colors.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../components/network_image.dart';
import '../../favourite_button/fav_button.dart';
import '../widget/add_to_cart.dart';
import '../widget/expanded_container.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({required this.wooProduct});
  WooProduct wooProduct;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ProductDetails> {
  CarouselController imagesController = CarouselController();

  // Widget smallImage({required String? imageUrl, required int index}) {
  //   return GestureDetector(
  //     onTap: () {
  //       imagesController.animateToPage(index);
  //       setState(() {});
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //           border: Border.all(
  //             color: AppColors.primiry,
  //           ),
  //           borderRadius: BorderRadius.all(Radius.circular(10))),
  //       height: 40,
  //       width: 40,
  //       child: ClipRRect(
  //           borderRadius: BorderRadius.circular(10),
  //           child: Image.network(imageUrl ?? "", fit: BoxFit.contain)),
  //     ),
  //   );
  // }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final cartCubit = CartCubit.get(context);
    return BlocConsumer<ProductCubit, ProductState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            extendBody: true,
            appBar: AppBar(
              backgroundColor: Colors.grey.shade100,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.lightGrey)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: AppColors.lightGrey)),
                      child: Badge(
                        badgeContent: NeoText(
                          cartCubit.cartAmount(),
                          color: Colors.white,
                        ),
                        showBadge: true,
                        shape: BadgeShape.circle,
                        badgeColor: AppColors.primiry,
                        elevation: 4,
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        position: BadgePosition.topEnd(),
                        animationType: BadgeAnimationType.scale,
                        toAnimate: true,
                        child: IconButton(
                          icon: Icon(
                            Icons.shopping_cart_outlined,
                            color: AppColors.primiry,
                            size: 30,
                          ),
                          onPressed: () {
                            navigate(context: context, route: CartScreen());
                          },
                        ),
                      )),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey.shade100,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 250.h,
                                    width: double.infinity,
                                    child: CarouselSlider(
                                        carouselController: imagesController,
                                        items: widget.wooProduct.images!
                                            .map(
                                              (e) => NetworkImagesWidgets(
                                                  e.src ?? ''),
                                            )
                                            .toList(),
                                        options: CarouselOptions(
                                          viewportFraction: 1,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          },
                                        )),
                                    //   NetworkImagesWidgets(url: url, fit: BoxFit.fill),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: widget.wooProduct.images!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      return GestureDetector(
                                        onTap: () => imagesController
                                            .animateToPage(entry.key),
                                        child: Container(
                                          width: 12.0,
                                          height: 12.0,
                                          margin: EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 4.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: (Theme.of(context)
                                                              .brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : Colors.black)
                                                  .withOpacity(
                                                      _current == entry.key
                                                          ? 0.9
                                                          : 0.4)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              if (widget.wooProduct.stockStatus == 'outstock')
                                Container(
                                  height: 250.h,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Image.asset(
                                              'assets/images/sold.png')),
                                    ],
                                  ),
                                ),
                              Positioned(
                                top: 10,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        border: Border.all(
                                            color: AppColors.lightGrey)),
                                    child: FavouriteButton(
                                      product: widget.wooProduct,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          //  shape: BoxShape.circle,
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 250.w,
                                  child: NeoText(widget.wooProduct.name!,
                                      // size: 18,
                                      color: AppColors.black,
                                      size: 22.fs,
                                      fontWeight: FontWeight.bold),
                                ),
                                !(widget.wooProduct.onSale ?? false)
                                    ? NeoText(
                                        '${widget.wooProduct.regularPrice!}' +
                                            "sr".tr(),
                                        fontWeight: FontWeight.w400,
                                        size: 23.fs)
                                    : Column(
                                        children: [
                                          NeoText(
                                              "${double.tryParse(widget.wooProduct.regularPrice ?? "0")} " +
                                                  "sr".tr(),
                                              size: 18.fs,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                          SizedBox(width: 3.w),
                                          NeoText(
                                            "${double.tryParse(widget.wooProduct.salePrice ?? "0")} " +
                                                "sr".tr(),
                                            size: 23.fs,
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HtmlWidget(
                                widget.wooProduct.description == ''
                                    ? 'No Details For This Item'
                                    : widget.wooProduct.description ?? "",
                                textStyle: TextStyle(fontSize: 19.fs),
                                onTapUrl: (s) {
                              launchUrl(Uri.parse(s),
                                  mode: LaunchMode.externalApplication);
                              return true;
                            }),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SingleChildScrollView(
              child: Container(
                color: AppColors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ExpandedSection(
                      firstChild: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 300.w,
                          decoration: BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: NeoText(
                            "Add to Cart",
                            size: 18,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      secChild: AddToCart(
                        wooProduct: widget.wooProduct,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Image.asset("images/back_button.png"),
          Text("MEN'S ORIGINAL",
              style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16)),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: CarouselSlider(
                carouselController: imagesController,
                items: widget.wooProduct.images!
                    .map(
                      (e) => NetworkImagesWidgets(e.src ?? ''),
                    )
                    .toList(),
                options: CarouselOptions(viewportFraction: 1)),
          ),
        ],
      ),
    );
  }

  Widget hero() {
    return Container(
      child: Stack(
        children: [
          Positioned(
              bottom: 50,
              right: 20,
              child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () {
                    setState(() {
                      //    isFavourite = !isFavourite;
                    });
                  },
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )))
        ],
      ),
    );
  }

  Widget section() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          HtmlWidget(
              widget.wooProduct.description == ''
                  ? 'No Details For This Item'
                  : widget.wooProduct.description ?? "",
              textStyle: TextStyle(fontSize: 15.fs), onTapUrl: (s) {
            launchUrl(Uri.parse(s), mode: LaunchMode.externalApplication);
            return true;
          }),
          SizedBox(height: 20),
          // property()
        ],
      ),
    );
  }

  // Widget property() {
  //   return Container(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Color",
  //                 style: TextStyle(
  //                     color: AppColors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16)),
  //             SizedBox(height: 10),
  //             Row(
  //               children: List.generate(
  //                   4,
  //                   (index) => GestureDetector(
  //                         onTap: () {
  //                           print("index $index clicked");
  //                           setState(() {
  //                             // selectedColor = colors[index];
  //                           });
  //                         },
  //                         child: Container(
  //                           padding: EdgeInsets.all(8),
  //                           margin: EdgeInsets.only(right: 10),
  //                           height: 34,
  //                           width: 34,
  //                           child: selectedColor == colors[index]
  //                               ? Image.asset("images/checker.png")
  //                               : SizedBox(),
  //                           decoration: BoxDecoration(
  //                               color: colors[index],
  //                               borderRadius: BorderRadius.circular(17)),
  //                         ),
  //                       )),
  //             )
  //           ],
  //         ),
  //         Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text("Size",
  //                 style: TextStyle(
  //                     color: AppColors.black,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 16)),
  //             SizedBox(height: 10),
  //             Container(
  //                 padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
  //                 color: AppColors.greyText.withOpacity(0.10),
  //                 child: Text(
  //                   "10.2",
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ))
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget bottomButton() {
    return Container(
      padding: EdgeInsets.only(right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FlatButton(
              onPressed: () {},
              child: Text(
                "Add to Bag +",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              )),
          Text(r"$95",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 28))
        ],
      ),
    );
  }
}
