import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/search/cubit/search_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../core/themes/colors.dart';
import '../../../domain/models/product/wooproduct.dart';
import '../../components/empty.dart';
import '../../components/login_text_failed.dart';
import '../../components/myLoading.dart';
import '../../components/product_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = TextEditingController();
  // List<WooProduct> trend = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final cubit = SearchCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: NeoText(
              'Search',
              color: AppColors.white,
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 80,
                child: LoginTextField(
                  height: 80,
                  controller: search,
                  label: 'Search',
                  validate: (p0) {},
                  onChange: (s) {
                    cubit.getProducts(context, s);
                  },
                  keyboardType: TextInputType.text,
                  color: AppColors.white,
                ),
              ),
              if (state is SearchEmpty) EmptyWidget(),
              if (state is SearchSuceed)
                Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 200,
                        ),
                        itemCount: cubit.searchList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductWidget(
                            products: cubit.searchList[index],
                            isTrend: false,
                          );
                        })),
            ],
          ),
        );
      },
    );
  }
}

class SearchModel {
  RangeValues? rangeValues;
  Sortstate? sortstate;
  String? searchtext;
  SearchModel({
    this.rangeValues,
    this.sortstate,
    this.searchtext,
  });
}

enum Sortstate { recent, priceHTM, priceMTH }

Sortstate? searchSortstate;

class SortingItem extends StatelessWidget {
  SortingItem(
      {Key? key,
      required this.title,
      required this.sortstate,
      required this.firstStat})
      : super(key: key);
  String title;
  Sortstate sortstate;
  Sortstate firstStat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NeoText(title, size: 15.fs, color: AppColors.primiry),
        Spacer(),
        Icon(
          sortstate == firstStat
              ? Icons.radio_button_on
              : Icons.radio_button_off,
          color: AppColors.primiry,
          size: 15,
        ),
      ],
    );
  }
}

class PriceSlider extends StatefulWidget {
  PriceSlider({
    Key? key,
    required this.onChange,
    required this.initValuse,
  }) : super(key: key);
  Function(RangeValues)? onChange;
  RangeValues initValuse;
  @override
  State<PriceSlider> createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  // RangeValues values = RangeValues(10, 1000);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            NeoText("price".tr(),
                fontWeight: FontWeight.bold,
                size: 16.fs,
                color: AppColors.primiry),
            Row(
              children: [
                NeoText("${("sr").tr()} ${widget.initValuse.start.toInt()}",
                    size: 14.fs, color: AppColors.primiry),
                Spacer(),
                NeoText("${("sr").tr()} ${widget.initValuse.end.toInt()}",
                    size: 14.fs, color: AppColors.primiry),
              ],
            ),
            RangeSlider(
                values: widget.initValuse,
                min: 0,
                max: 10000,
                onChanged: (s) {
                  widget.onChange!(s);
                  widget.initValuse = s;
                  setState(() {});
                })
          ],
        ),
      ),
    );
  }
}
