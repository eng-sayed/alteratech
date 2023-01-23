import 'dart:developer';

import 'package:alteratech/domain/repository/wishlist_repo/wishlist_repo.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/utiles.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/wishlist/woowishlist.dart';

import '../../shop/cubit/shop_cubit.dart';
import 'states.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(FavouriteInitial());
  static FavouriteCubit get(context) => BlocProvider.of(context);
  // List<WooProduct> wishList = [];
  List<WooProduct> wishListProducts = [];

  // toggleWhislist(
  //   context, {
  //   WooProduct? product,
  //   required int productId,
  // }) async {
  //   emit(ToggelFavouriteLoagingState());
  //   if (wishList.any((element) => element.id == productId)) {
  //     final wishListId = wishList
  //         .firstWhere((element) => element.id == productId)
  //         .id;
  //     final response = await WishListRepo.deletWishList(context,
  //         productID: productId, wishListid: wishListId.toString());
  //     if (response != null) {
  //       wishList.removeWhere((element) => element.id == productId);
  //       wishListProducts.removeWhere((element) => element.id == productId);
  //       Alerts.snak(context:context,
  //           message: "deletewishlist".tr(), type: ContentType.success);
  //       emit(ToggelFavouriteDoneState());

  //       return true;
  //     } else {
  //       Alerts.snak(
  //           context: context, message: "error".tr(), type: ContentType.failure);
  //       emit(ToggelFavouriteDoneState());

  //       return false;
  //     }
  //   } else {
  //     final response = await WishListRepo.addToWishList(context, product!);
  //     if (response != null) {
  //       if (Utiles.token.isNotEmpty) {
  //         wishList.add(response);
  //       } else {
  //         getWishliste(context);
  //       }
  //       Alerts.snak(
  //           context: context,
  //           message: "addwishlist".tr(),
  //           type: ContentType.success);
  //       emit(ToggelFavouriteDoneState());

  //       return true;
  //     } else {
  //       Alerts.snak(
  //           context: context, message: "error".tr(), type: ContentType.failure);
  //       emit(ToggelFavouriteDoneState());

  //       return false;
  //     }
  //   }
  // }

  getWishliste(context) async {
    emit(FavouriteGetDataLoading());
    final respose = await WishListRepo.getWishlist(context);

    if (respose != null) {
      wishListProducts = respose.wishList ?? [];
      print(wishListProducts.map((e) => e.id).toList());

      // wishListProducts = await ShopCubit.get(context).getProducts(context, 1,
      //     include: wishList.map((e) => e.productId ?? 0).toList());
      emit(FavouriteGetDataSuccess());
    } else {
      emit(FavouriteGetDataError());
    }
  }

  toggleWhislist(
    context, {
    WooProduct? product,
    required int productId,
  }) async {
    emit(ToggelFavouriteLoagingState());
    print(productId);

    if (wishListProducts.any((element) => element.id == productId)) {
      print('deletewishlist'.tr());
      final wishListId = wishListProducts
          .firstWhere((element) => element.id == productId)
          .WishListId;
      final response = await WishListRepo.deletWishList(context,
          productID: productId, wishListid: wishListId.toString());
      if (response != null) {
        // wishList.removeWhere((element) => element.id == productId);
        wishListProducts.removeWhere((element) => element.id == productId);
        Alerts.snak(
            context: context,
            message: "deletewishlist".tr(),
            title: '',
            type: ContentType.success);

        emit(ToggelFavouriteDoneState());

        return true;
      } else {
        Alerts.snak(
            context: context,
            message: "error".tr(),
            title: '',
            type: ContentType.failure);
        emit(ToggelFavouriteDoneState());

        return false;
      }
    } else {
      final response = await WishListRepo.addToWishList(context, product!);
      if (response != null) {
        //TODO if (Utiles.token.isNotEmpty) {
        //   wishList.add(response);
        // } else {
        getWishliste(context);
        //    }
        Alerts.snak(
            context: context,
            message: "addwishlist".tr(),
            title: '',
            type: ContentType.success);

        emit(ToggelFavouriteDoneState());

        return true;
      } else {
        Alerts.snak(
            context: context,
            message: "error".tr(),
            title: '',
            type: ContentType.failure);

        emit(ToggelFavouriteDoneState());

        return false;
      }
    }
  }
}
