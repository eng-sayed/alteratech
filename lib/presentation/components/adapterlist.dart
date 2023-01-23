import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../core/themes/colors.dart';
import 'login_text_failed.dart';

class AdapterListView extends StatelessWidget {
  const AdapterListView({
    this.afterList = const [],
    this.beforeList = const [],
    required this.itemBuilder,
    required this.itemCount,
    required this.controller,
    Key? key,
  }) : super(key: key);
  final List<Widget> beforeList;
  final List<Widget> afterList;
  final ScrollController controller;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: beforeList,
          ),
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate(itemBuilder, childCount: itemCount)),
        SliverToBoxAdapter(
          child: Column(
            children: afterList,
          ),
        ),
      ],
    );
  }
}

class AdapterGridView extends StatelessWidget {
  const AdapterGridView({
    this.afterList = const [],
    this.beforeList = const [],
    required this.itemBuilder,
    required this.itemCount,
    this.loadingCondition,
    this.loadingWidget,
    this.controller,
    Key? key,
  }) : super(key: key);
  final List<Widget> beforeList;
  final List<Widget> afterList;
  final ScrollController? controller;
  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final Widget? loadingWidget;
  final bool? loadingCondition;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      controller: controller,
      slivers: [
        // SliverAppBar(
        //   backgroundColor: AppColors.secondary,
        //   snap: true,
        //   centerTitle: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(30),
        //     ),
        //   ),
        //   pinned: true,
        //   floating: true,
        //   expandedHeight: 200.0,
        //   flexibleSpace: FlexibleSpaceBar(
        //     // background: Image.asset(
        //     //   'assets/images/logo.png',
        //     //   width: 50,
        //     // ),
        //     title: LoginTextField(
        //       //height: 10,
        //       controller: search,
        //       label: 'Search',
        //       // focusNode: focusNode,
        //       // autofocus: false,
        //       validate: (p0) {},
        //       keyboardType: TextInputType.text,
        //       color: AppColors.white,
        //     ),
        //   ),
        //  SliverAppBar(
        //   backgroundColor: AppColors.secondary,
        //   snap: true,
        //   centerTitle: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.vertical(
        //       bottom: Radius.circular(30),
        //     ),
        //   ),
        //   pinned: true,
        //   floating: true,
        //   expandedHeight: 200.0,
        //   flexibleSpace: FlexibleSpaceBar(
        //     // background: Image.asset(
        //     //   'assets/images/logo.png',
        //     //   width: 50,
        //     // ),
        //     title: LoginTextField(
        //       //height: 10,
        //       controller: search,
        //       label: 'Search',
        //       // focusNode: focusNode,
        //       // autofocus: false,
        //       validate: (p0) {},
        //       keyboardType: TextInputType.text,
        //       color: AppColors.white,
        //     ),
        //   ),
        // ),
        SliverToBoxAdapter(
          child: Column(
            children: beforeList,
          ),
        ),
        loadingCondition ?? false
            ? SliverToBoxAdapter(child: loadingWidget)
            : SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisExtent: 200,
                  // crossAxisCount: 2,
                  // crossAxisSpacing: 2,
                  childAspectRatio: 2,
                  // mainAxisExtent: 200
                ),
                delegate: SliverChildBuilderDelegate(itemBuilder,
                    childCount: itemCount)),
        SliverToBoxAdapter(
          child: Column(
            children: afterList,
          ),
        ),
      ],
    );
  }
}
