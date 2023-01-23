import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../core/themes/colors.dart';

import '../../../core/utils/utiles.dart';
import '../../components/empty.dart';
import '../../components/loadinganderror.dart';
import '../../components/product_widget.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
import 'widgets/favourit_item.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite>
//with AutomaticKeepAliveClientMixin
{
  @override
  void initState() {
    final cubit = FavouriteCubit.get(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      cubit.getWishliste(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = FavouriteCubit.get(context);
          return LoadingAndError(
            isError: state is FavouriteGetDataError,
            isLoading: state is FavouriteGetDataLoading,
            child: Scaffold(
              appBar: AppBar(
                  title: NeoText(
                "WhishList".tr(),
                color: AppColors.white,
                size: 19,
              )),
              body: cubit.wishListProducts.isEmpty
                  ? EmptyWidget()
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return CreateWhishListItem(
                          product: cubit.wishListProducts[index],
                        );
                      },
                      itemCount: cubit.wishListProducts.length,
                    ),
            ),
          );
        });
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}
