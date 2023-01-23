import 'package:alteratech/data/local/shared.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utiles.dart';
import 'states.dart';

class SplashCubit extends Cubit<SplashStates> {
  SplashCubit() : super(SplashInitial());
  static SplashCubit get(context) => BlocProvider.of(context);

  getToken() async {
    Utiles.token = await MyShared.getData(key: "token") ?? "";
    Utiles.UserId = await MyShared.getData(key: "userid") ?? "";
    Utiles.wishListKey = await MyShared.getData(key: "share_key") ?? "";
    Utiles.Username = await MyShared.getData(key: "username") ?? "";
    print(Utiles.token);
  }

  // Widget navigateDirction() {
  //   Utiles.token = CacheHelper.loadData(key: "token") ?? "";
  //   print(Utiles.token);
  //   if (Utiles.token.isNotEmpty) {
  //     return " Routes.homeLayout";
  //   } else {
  //     return " Routes.loginScreen";
  //   }
  // }
}
