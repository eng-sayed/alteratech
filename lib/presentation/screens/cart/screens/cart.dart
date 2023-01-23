// ignore_for_file: sort_child_properties_last

import 'package:alteratech/core/utils/responsive.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utiles.dart';
import '../../../components/my+text.dart';
import '../cubit/cart_cubit.dart';
import '../widget/cart_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    final cubit = CartCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await cubit.getCart(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = CartCubit.get(context);
          final myContext = context;
          return Scaffold(
              extendBody: true,
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: NeoText(
                  'cart'.tr(),
                  size: 18,
                  color: AppColors.black,
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.black,
                  ),
                ),
              ),
              body: state is CartGetDataLoading
                  ? Center(
                      child: Lottie.asset(
                        "assets/json/loading.json",
                        width: 150,
                        height: 150,
                      ),
                    ) //assets\json\empty.json
                  : cubit.cart.wooCartitems!.isEmpty
                      ? Center(
                          child: Lottie.asset(
                            "assets/json/empty.json",
                            width: 300,
                            height: 300,
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            itemCount: cubit.cart.wooCartitems?.length ?? 0,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Dismissible(
                                key: Key(cubit.cart.wooCartitems![index].id
                                    .toString()),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) async {
                                  // print(cubit.cart.wooCartitems![index].key!);
                                  await CartCubit.get(context).removeFromCart(
                                      myContext,
                                      key:
                                          cubit.cart.wooCartitems?[index].key ??
                                              '',
                                      id: cubit.cart.wooCartitems?[index].id ??
                                          0,
                                      index: index);

                                  // cubit.cart.wooCartitems?.removeAt(index);
                                },
                                background: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFE6E6),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      SvgPicture.asset(
                                          "assets/icons/Trash.svg"),
                                    ],
                                  ),
                                ),
                                child: CartCard(
                                    cart: cubit.cart.wooCartitems![index]),
                              ),
                            ),
                          ),
                        ),
              bottomNavigationBar: Container(
                color: Colors.grey.shade100,
                height: 150.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: NeoText(
                              "Amount".tr(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: NeoText(
                              cubit.cartAmount(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: NeoText(
                              "total".tr(),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 30),
                            child: NeoText(
                              cubit.cartTotal(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (Utiles.token.isNotEmpty) {
                          if (cubit.cart.wooCartitems!.length > 0) {
                            //TODO navigate(context: context, route: Checkout());
                          } else {
                            Alerts.snak(
                                context: context,
                                message: "emptycart".tr(),
                                type: ContentType.failure);
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Container());
                          //TODO RequirdLogin());
                        }
                      },
                      color: AppColors.primiry,
                      padding: EdgeInsets.only(
                          top: 12, left: 60, right: 60, bottom: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                      child: NeoText(
                        "checkout".tr(),
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(top: 16, bottom: 20),
              ));
        });
  }
}
