import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/utiles.dart';
import '../../../../domain/models/product/wooproduct.dart';
import '../../../components/empty.dart';
import '../../../components/myLoading.dart';
import '../../../components/product_widget.dart';
import '../cubit/shop_cubit.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen(
      {Key? key,
      required this.title,
      this.categoryId,
      this.onsale,
      this.showBack = true})
      : super(key: key);
  final String title;
  final int? categoryId;
  final bool? onsale;
  final bool showBack;
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showBackToTopButton = false;
  void _scrollToTop() {
    scrollController.animateTo(0,
        duration: const Duration(microseconds: 1500), curve: Curves.linear);
  }

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    final cubit = ShopCubit.get(context);
    print("errer" + widget.categoryId.toString());
    cubit.pagingController = PagingController<int, WooProduct>(firstPageKey: 1);
    cubit.pagingController.addPageRequestListener((pageKey) async {
      await cubit.fetchPage(
        context,
        catId: widget.categoryId,
        onsale: widget.onsale,
        pageKey: pageKey,
      );
    }); // TODO: implement initState
    super.initState();
  }

  GlobalKey<ScaffoldState> scafoldkey = GlobalKey<ScaffoldState>();

  // SearchModel searchModel = SearchModel();
  @override
  Widget build(BuildContext context) {
    final cubit = ShopCubit.get(context);
    return Scaffold(
      floatingActionButton: widget.title == "shop"
          ? _showBackToTopButton == false
              ? null
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 150, horizontal: 1),
                  child: FloatingActionButton(
                      child: Icon(Icons.arrow_upward), onPressed: _scrollToTop),
                )
          : FloatingActionButton(
              child: Icon(Icons.whatsapp),
              onPressed: () {
                Utiles().openwhatsapp(context);
              },
            ),
      key: scafoldkey,
      //TODO endDrawer: SearchScreen(
      //   oldSearch: cubit.searchModel,
      //   onchange: (s) {
      //     cubit.searchModel = s;
      //     print(s.searchtext);
      //     Navigator.pop(context);
      //     cubit.pagingController.refresh();
      //   },
      // ),
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
        title: NeoText(
          "${widget.title.replaceAll("amp;", "")}".tr(),
          color: AppColors.black,
          size: 22,
          fontWeight: FontWeight.w600,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       scafoldkey.currentState!.openEndDrawer();
        //     },
        //     icon: Icon(Icons.search),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PagedGridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisExtent: 200),
          pagingController: cubit.pagingController,
          builderDelegate: PagedChildBuilderDelegate<WooProduct>(
            firstPageProgressIndicatorBuilder: (context) => Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLoading.loadingWidget(),
                ],
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => SizedBox(
              child: EmptyWidget(),
            ),
            // animateTransitions: true,
            itemBuilder: (_, item, index) {
              return ProductWidget(
                isTrend: false,
                products: item,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
