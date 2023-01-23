import 'package:alteratech/presentation/components/my+text.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../core/themes/colors.dart';
import '../../auth/screens/auth_screen.dart';
import '../../category/screens/categories.dart';
import '../../favourite/favourite.dart';
import '../../home/cubit/home_cubit.dart';
import '../../home/screens/home.dart';
import '../../shop/screens/shop.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 5, vsync: this, initialIndex: 2);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: NeoText('ALTERA TECH', size: 22, fontWeight: FontWeight.w700),
        actions: [
          Center(
            child: Image.asset('assets/images/logo.png'),
          )
        ],
      ),
      body: TabBarView(
        controller: tabController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ShopScreen(
            title: 'shop'.tr(),
          ),
          Categories(),
          HomeScreen(),
          Favourite(),
          AuthScreen(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          backgroundColor: AppColors.white,
          height: 60,
          buttonBackgroundColor: Color(0xff00BBFF),
          color: Color(0xff00BBFF),
          onTap: (s) {
            switch (s) {
              case 0:
                tabController.animateTo(0);
                break;
              case 1:
                tabController.animateTo(1);
                break;
              case 2:
                tabController.animateTo(2);
                break;
              case 3:
                tabController.animateTo(3);
                break;
              case 4:
                tabController.animateTo(4);
                break;
              default:
            }
          },
          items: <Widget>[
            Icon(Icons.home),
            Icon(Icons.category),
            Icon(Icons.home),
            Icon(Icons.settings),
            Icon(Icons.settings),
          ]),
    );
  }
}
