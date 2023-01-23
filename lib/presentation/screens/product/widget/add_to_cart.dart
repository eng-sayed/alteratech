import 'package:alteratech/core/utils/alerts.dart';
import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../../../../core/themes/colors.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../cart/cubit/cart_cubit.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key? key, required this.wooProduct}) : super(key: key);
  WooProduct wooProduct;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  int count = 1;
  double? price;
  @override
  void initState() {
    price = double.parse(widget.wooProduct.price ?? '0');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NeoText('total'.tr(),
                  size: 18.fs,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NeoText(price.toString(),
                    size: 18.fs,
                    color: AppColors.greyText,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    count > 1 ? count-- : null;

                    price =
                        double.parse(widget.wooProduct.price ?? "0") * count;
                  });
                },
                icon: Icon(
                  Icons.remove,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.only(
                    bottom: 2, right: 12, left: 12, top: 2),
                child: Text(
                  count.toString(),
                ),
              ),
              IconButton(
                onPressed: () {
                  count++;
                  //     price = int.parse(widget.wooProduct!.price!);
                  price = double.parse(widget.wooProduct.price ?? "0") * count;
                  setState(() {});

                  print(price);
                },
                icon: Icon(
                  Icons.add,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
              )
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), primary: AppColors.secondary),
              onPressed: () async {
                if (widget.wooProduct.stockStatus == 'instock') {
                  await CartCubit.get(context).addToCart(context,
                      product: widget.wooProduct, quantity: count);
                } else {
                  Alerts.snak(
                      context: context,
                      title: "",
                      type: ContentType.failure,
                      message: "outstock".tr());
                }
              },
              child: NeoText(
                'addtocart'.tr(),
                color: AppColors.white,
              ))
        ]),
      ),
    );
  }
}
