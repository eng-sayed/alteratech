import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  PagingController<int, WooProduct> pagingController =
      PagingController<int, WooProduct>(firstPageKey: 1);

  fetchPage(
    BuildContext context, {
    required int pageKey,
    bool? onsale,
    int? catId,
  }) async {
    var newList =
        await getProducts(context, pageKey, categoryID: catId, onSale: onsale);

    if (newList != null) {
      var isLastPage = newList.isEmpty;

      if (isLastPage) {
        // stop
        pagingController.appendLastPage(newList ?? []);
      } else {
        // increase count to reach new page
        var nextPageKey = pageKey + 1;
        pagingController.appendPage(newList ?? [], nextPageKey);
      }
    }
  }

  getProducts(context, int Page,
      {int? categoryID, bool? onSale, List<int>? include}) async {
    if (Page == 1) {
      emit(ShopLoadingState());
    }
    final response = await HomeRepository.getProduct(
      context,
      page: Page, categorie: categoryID, onSale: onSale,
      // maxPrice: searchModel.rangeValues != null
      //     ? searchModel.rangeValues!.end.toString()
      //     : null,
      // minPrice: searchModel.rangeValues != null
      //     ? searchModel.rangeValues!.start.toString()
      //     : null,
      // incloud: include,
      // search: searchModel.searchtext,
      // orderBy: (searchModel.sortstate == Sortstate.priceMTH ||
      //         searchModel.sortstate == Sortstate.priceHTM)
      //     ? "price"
      //     : "date",
      // perPage: include != null ? 100 : null,
      // order: searchModel.sortstate == Sortstate.priceHTM ? "desc" : "asc"
    );
    if (response != null) {
      emit(ShopSuccessState());
      return response;
    } else {}
  }
}
