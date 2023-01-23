import 'package:alteratech/core/themes/colors.dart';
import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/domain/models/cart/woocart.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../cubit/cart_cubit.dart';

class CartCard extends StatefulWidget {
  CartCard({
    Key? key,
    required this.cart,
  }) : super(key: key);

  WooCartitems cart;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late int count;

  late double price;

  double? totalPrice;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    count = widget.cart.quantity!;
    price = double.parse(widget.cart.wooItemPrices!.price!);
    totalPrice = count * price;
    super.initState();
  }

  refreshTotalPrice() {
    setState(() {
      totalPrice = count * price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(children: [
      SizedBox(
        width: 88,
        child: AspectRatio(
          aspectRatio: 0.88,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network(widget.cart.wooCartItemImages![0].src!),
          ),
        ),
      ),
      SizedBox(width: 20),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 250.w,
          child: NeoText(
            widget.cart.name!,
            color: Colors.black,
            size: 16,
            maxLines: 1,
            align: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                NeoText(
                  widget.cart.wooItemPrices!.salePrice ??
                      "${widget.cart.wooItemPrices!.regularPrice} " + 'sr'.tr(),
                  fontWeight: FontWeight.w600,
                  color: AppColors.greyText,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: NeoText(
                    (totalPrice)!.toStringAsFixed(2) + " " + "sr".tr(),
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        count > 1 ? count-- : null;
                        refreshTotalPrice();
                      },
                      icon: Icon(
                        Icons.remove,
                        size: 20,
                        color: AppColors.primiry,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 2, right: 12, left: 12, top: 2),
                      child: NeoText(
                        count.toString(),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        count++;
                        refreshTotalPrice();
                      },
                      icon: Icon(
                        Icons.add,
                        size: 20,
                        color: AppColors.primiry,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    count == widget.cart.quantity!
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Card(
                              shape: StadiumBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: AppColors.greyText,
                              child: InkWell(
                                onTap: () {
                                  CartCubit.get(context).updateCartItem(context,
                                      key: widget.cart.key ?? "",
                                      id: widget.cart.id ?? 0,
                                      product: widget.cart,
                                      quantity: count);
                                },
                                customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: SizedBox(
                                  width: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NeoText("confirm".tr(),
                                        align: TextAlign.center,
                                        color: Colors.white,
                                        size: 16.fs),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              ],
            ),
          ],
        ),
      ])
    ]));
  }
}
