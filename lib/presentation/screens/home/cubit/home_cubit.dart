import 'package:alteratech/data/local/shared.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utiles.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../../domain/models/wooslider.dart/wooslider.dart';
import '../../../../domain/repository/home_repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  List<WooProduct> shop = [];
  List<WooMobileSlider> sliders = [];
  getToken() async {
    Utiles.token = await MyShared.getData(key: "token") ?? "";
    Utiles.UserId = await MyShared.getData(key: "userid") ?? "";
    Utiles.wishListKey = await MyShared.getData(key: "share_key") ?? "";
    Utiles.Username = await MyShared.getData(key: "username") ?? "";
    print(Utiles.token);
  }

  int producpage = 1;

  getProducts(context) async {
    emit(HomePageGetProductsLoadingState());

    final response = await HomeRepository.getProduct(context, page: producpage);
    if (response != null) {
      shop.addAll(response);
      print(shop.first.salePrice);
      print(shop.first.regularPrice);
      print(shop.first.price);
      print(shop.first.onSale);
      emit(HomePageGetProductsSucessState());
    } else {
      emit(HomePageGetProductsErrorState());
    }
  }

  getHomeData(context) async {
    producpage = 1;
    emit(HomePageGetAdsLoadingState());

    final response = await HomeRepository.homeRequest(context);
    if (response != null) {
      shop = response["shop"];

      sliders = response["sliders"];
      // featuerd = response["featured"];
      // cat = response["cat"];
      //getCatories();
      emit(HomePageGetAdsSuccessState());
    } else {
      emit(HomePageGetAdsErrorState());
    }
  }

  paginateHome(context) async {
    producpage++;

    await getProducts(context);
  }
}
