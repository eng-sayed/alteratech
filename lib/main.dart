import 'package:alteratech/core/themes/colors.dart';
import 'package:alteratech/data/api/my_dio.dart';
import 'package:alteratech/data/hive/hive.dart';
import 'package:alteratech/data/local/shared.dart';
import 'package:alteratech/presentation/screens/auth/cubit/cubit.dart';
import 'package:alteratech/presentation/screens/cart/cubit/cart_cubit.dart';
import 'package:alteratech/presentation/screens/category/cubit/category_cubit.dart';
import 'package:alteratech/presentation/screens/favourite/cubit/cubit.dart';
import 'package:alteratech/presentation/screens/product/cubit/product_cubit.dart';
import 'package:alteratech/presentation/screens/shop/cubit/shop_cubit.dart';
import 'package:alteratech/presentation/screens/splash/cubit/cubit.dart';
import 'package:alteratech/presentation/screens/splash/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_color_gen/material_color_gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/screens/home/cubit/home_cubit.dart';
import 'presentation/screens/home/screens/home.dart';
import 'presentation/screens/main_screen/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HiveLocal.init();
  MyShared.init();
  MyDio.init();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  runApp(EasyLocalization(
      startLocale: Locale('en', 'US'),
      supportedLocales: [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      saveLocale: true,
      path: 'assets/translations',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
          create: (context) => SplashCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) => FavouriteCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
        BlocProvider<ShopCubit>(
          create: (context) => ShopCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (context) => CategoryCubit(),
        ),
        BlocProvider<CartCubit>(
          create: (context) => CartCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(),
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: "AlteraTech",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: "cairo",
              primarySwatch: AppColors.primiry.toMaterialColor(),
              scaffoldBackgroundColor: AppColors.white.toMaterialColor()),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
