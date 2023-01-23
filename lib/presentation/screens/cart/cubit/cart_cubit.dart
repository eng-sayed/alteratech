import 'package:alteratech/domain/models/cart/woocart.dart';
import 'package:alteratech/presentation/screens/product/widget/add_to_cart.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/repository/cart_repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  WooCart cart = WooCart();
  getCart(context) async {
    cart = WooCart();
    emit(CartGetDataLoading());
    var response = await CartRepo.getCart(context: context);
    if (response != null) {
      cart = response;
      emit(CartGetDataSuccess());
    } else {
      emit(CartGetDataError());
    }
  }

  String cartTotal() {
    double total = 0;
    cart.wooCartitems?.forEach((element) {
      total +=
          double.parse(element.wooItemPrices?.price ?? "0") * element.quantity!;
    });
    return total.toStringAsFixed(2);
  }

  String cartAmount() {
    int total = 0;
    cart.wooCartitems?.forEach((element) {
      total += element.quantity!;
    });
    return total.toString();
  }

  updateCartItem(context,
      {required String key,
      required int id,
      required WooCartitems product,
      required int quantity}) async {
    final resposne = await CartRepo.updateToCart(context,
        key: key, id: id, product: product, quantity: quantity);
    if (resposne != null) {
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.success,
          message: "addcart".tr());
      cart.wooCartitems!
          .firstWhere((element) => element.id == product.id,
              orElse: (() => WooCartitems()))
          .quantity = quantity;
      emit(CartAddToCartSuccess());
    } else {
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.failure,
          message: "error".tr());
    }
  }

  addToCart(context,
      {required WooProduct product, required int quantity}) async {
    final resposne =
        await CartRepo.addToCart(context, product: product, quantity: quantity);
    if (resposne != null) {
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.success,
          message: "addcart".tr());
    } else {
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.failure,
          message: "error".tr());
    }
  }

  // deleteAllCart(context) async {
  //   final resposne = await CartRepo.deleteAllCart(
  //     context,
  //   );
  //   if (resposne != null) {
  //     Alerts.snak(
  //         context: context,
  //         title: "",
  //         type: ContentType.success,
  //         message: "تمت افراغ بنجاح");
  //   } else {
  //     Alerts.snak(
  //         context: context,
  //         title: "",
  //         type: ContentType.failure,
  //         message: "error".tr());
  //   }
  // }

  removeFromCart(context, {required String key, required int id, index}) async {
    emit(CartGetDataLoading());

    final resposne = await CartRepo.deleteItemCart(context, key: key, id: id);
    if (resposne != null) {
      // OverLays.snack(context,
      //     text: "deletecart".tr(), state: SnakState.success);

      await cart.wooCartitems?.removeAt(index);

      //  cart.wooCartitems!.removeWhere((element) => element.id == id);

      emit(CartRemoveFromCartSuccess());
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.success,
          message: "deletecart".tr());
    } else {
      Alerts.snak(
          context: context,
          title: "",
          type: ContentType.failure,
          message: "error".tr());
    }
  }
}
