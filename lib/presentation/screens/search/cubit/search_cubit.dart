import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  List<WooProduct> searchList = [];

  getProducts(
    context,
    String search,
  ) async {
    searchList = [];
    // if (Page == 1) {
    emit(SearchEmpty());
    // }
    final response = await HomeRepository.getProduct(
      context,
      search: search,
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
      searchList = response;
      emit(SearchSuceed());
      return response;
    } else {}
  }
}
