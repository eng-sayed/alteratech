import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/themes/colors.dart';
import '../../../domain/models/product/wooproduct.dart';
import '../favourite/cubit/cubit.dart';
import '../favourite/cubit/states.dart';

class FavouriteButton extends StatefulWidget {
  FavouriteButton({
    Key? key,
    required this.product,
  }) : super(key: key);
  final WooProduct product;
  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool isFavourite = false;

  @override
  void initState() {
    final cubit = FavouriteCubit.get(context);
    isFavourite = cubit.wishListProducts
        .any((element) => element.id == widget.product.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteCubit, FavouriteStates>(
        listener: (context, state) {
      final cubit = FavouriteCubit.get(context);

      isFavourite = cubit.wishListProducts
          .any((element) => element.id == widget.product.id);
    }, builder: (context, state) {
      final cubit = FavouriteCubit.get(context);

      return IconButton(
        onPressed: () async {
          //cubit.getWishliste(context);
          final value = await cubit.toggleWhislist(context,
              productId: widget.product.id ?? 0, product: widget.product);
          print(value);
          if (value) {
            setState(() {
              isFavourite = !isFavourite;
            });
          }
        },
        icon: Icon(
          isFavourite ? Icons.favorite : Icons.favorite_border,
          color: Color.fromARGB(255, 248, 34, 19),
        ),
      );
    });
  }
}
