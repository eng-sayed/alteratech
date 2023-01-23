import 'package:alteratech/core/themes/colors.dart';
import 'package:alteratech/core/utils/navigator.dart';
import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';

import '../../../components/adapterlist.dart';
import '../../../components/login_text_failed.dart';
import '../../../components/product_widget.dart';
import '../../../components/shimer_loading_items.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../cart/screens/cart.dart';
import '../../favourite/cubit/cubit.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  FocusNode focusNode = FocusNode();
  double searchFieldSize = 100;
  @override
  void initState() {
    // TODO: implement initState
    final cubit = HomeCubit.get(context);
    final cartCubit = CartCubit.get(context);
    final favCubit = FavouriteCubit.get(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      //cubit.getToken();
      cubit.getHomeData(context);

      cartCubit.getCart(context);
      favCubit.getWishliste(context);
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchFieldSize = 500;
        setState(() {});
      }
      // else if(_focusNode.)
    });
    controller.addListener((() {
      var x = controller.appBar.heightNotifier.value;
      searchFieldSize = x < 100 ? 400 * (x / 100) : 400;
      print(controller.appBar.heightNotifier.value);
      print(controller.offset);
      // print(controller.);
      setState(() {});
    }));
    super.initState();
  }

  final controller = ScrollController();
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = HomeCubit.get(context);

          return Scaffold(
            floatingActionButton: FloatingActionButton(onPressed: () {
              navigate(context: context, route: CartScreen());
            }),
            // appBar: ScrollAppBar(
            //   controller: controller,
            //   centerTitle: true,
            //   title: Column(
            //     children: [
            //       // Image.asset(
            //       //   'assets/images/logo.png',
            //       //   width: 50,
            //       // ),
            //       AnimatedContainer(
            //         height: 80,
            //         duration: const Duration(milliseconds: 500),
            //         width: searchFieldSize,
            //         // padding: EdgeInsets.only(top: 12, right: 18, left: 8),
            //         child: LoginTextField(
            //           //height: 10,
            //           controller: search,
            //           label: 'Search',
            //           focusNode: focusNode,
            //           autofocus: false,
            //           validate: (p0) {},
            //           keyboardType: TextInputType.text,
            //           color: AppColors.white,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),  controller: controller.appBar,
            backgroundColor: AppColors.lightGreybackgound,
            body: ScrollWrapper(
                promptAlignment: Alignment.topCenter,
                promptDuration: const Duration(milliseconds: 400),
                promptTheme: PromptButtonTheme(
                  icon: Icon(Icons.arrow_circle_up, color: Colors.white),
                  color: AppColors.black,
                  iconPadding: EdgeInsets.all(16),
                  //    padding: EdgeInsets.all(85.h)
                ),
                builder: (context, properties) {
                  return NotificationListener<ScrollEndNotification>(
                    onNotification: (s) {
                      if (s.metrics.maxScrollExtent == s.metrics.pixels) {
                        cubit.paginateHome(context);
                      }
                      return true;
                    },
                    child: RefreshIndicator(
                      onRefresh: () async {
                        cubit.getHomeData(context);
                      },
                      child: AdapterGridView(
                          controller: controller,
                          beforeList: [
                            Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    print('object');
                                  },
                                  child: LoginTextField(
                                    //height: 10,
                                    // fun: () {
                                    //   print('object');
                                    // },
                                    enable: false,
                                    controller: search,
                                    label: 'Search',
                                    // focusNode: focusNode,
                                    // autofocus: false,
                                    validate: (p0) {},
                                    keyboardType: TextInputType.text,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    aspectRatio: 3.0,
                                    enlargeCenterPage: true,
                                    height: 200.h,
                                  ),
                                  items: cubit.sliders
                                      .map((item) => ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Center(
                                                child: Image.network(
                                              scale: 2,
                                              item.feature ?? '',
                                              fit: BoxFit.cover,
                                              // width: 50.w,
                                              //  height: 190.h,
                                            )),
                                          ))
                                      .toList(),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Row(
                                    children: <Widget>[
                                      NeoText(
                                        "shop".tr(),
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w700,
                                        size: 30.fs,
                                      ),

                                      // Spacer(),
                                      // PopupMenuButton(
                                      //     offset: (Offset(-30, 40)),
                                      //     itemBuilder: (context) => [
                                      //           PopupMenuItem(
                                      //               child: defaultText("showall".tr()))
                                      //         ])
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                          loadingWidget: ProductsLoadnigItem(),
                          afterList: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                ),
                                CircularProgressIndicator()
                              ],
                            )
                          ],
                          loadingCondition: state is HomePageGetAdsLoadingState,
                          itemBuilder: (context, index) {
                            return
                                // index.isOdd?
                                Column(
                              children: [
                                // SizedBox(
                                //   height: 30,
                                // ),
                                ProductWidget(
                                  products: cubit.shop[index],
                                  isTrend: false,
                                ),
                              ],
                            )
                                // : Column(
                                //     children: [
                                //       ProductWidget(
                                //         products: cubit.shop[index],
                                //         isTrend: false,
                                //       ),
                                //       SizedBox(
                                //         height: 30,
                                //       ),
                                //     ],
                                //   )
                                ;
                          },
                          itemCount: cubit.shop.length),
                    ),
                  );
                }),
          );
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
