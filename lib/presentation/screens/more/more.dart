import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:alteratech/presentation/screens/main_screen/screens/main_screen.dart';
import 'package:alteratech/presentation/screens/more/shipping_policy.dart';
import 'package:alteratech/presentation/screens/more/terms_conditions.dart';
import 'package:alteratech/presentation/screens/more/widgets/square_btn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/navigator.dart';
import '../../../core/utils/utiles.dart';
import '../../components/requirdLogin.dart';
import '../profile/profile.dart';
import '../shop/screens/shop.dart';
import 'about_us.dart';
import 'contact.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: SizedBox(
                height: 300.0.h,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 400.w,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                color: AppColors.lightGrey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      DrawerItem(
                          text: "first drawer".tr(),
                          icon: Icons.money_off_csred_sharp,
                          onTap: () {
                            navigate(
                                context: context,
                                route: ShopScreen(
                                  onsale: true,
                                  title: "first drawer",
                                ));
                          }),
                      DrawerItem(
                          text: "newarrival".tr(),
                          icon: Icons.fiber_new_rounded,
                          onTap: () {
                            navigate(
                              context: context,
                              route: ShopScreen(
                                title: "newarrival".tr(),
                              ),
                            );
                          }),
                      DrawerItem(
                        icon: Icons.person,
                        text: "Profile",
                        onTap: () {
                          Utiles.token.isNotEmpty
                              ? navigate(
                                  context: context, route: ProfileScreen())
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      RequirdLogin());
                        },
                        //   route: Profile(),
                      ),
                      DrawerItem(
                        text: "About US".tr(),
                        icon: Icons.info,
                        onTap: () {
                          navigate(context: context, route: AboutUs());
                        },
                      ),
                      // DrawerItem(
                      //   text: "Contact Us".tr(),
                      //   icon: Icons.mail,
                      //   onTap: () {
                      //     navigate(context: context, route: Contact());
                      //   },
                      // ),
                      DrawerItem(
                        text: "Shipping & Returns Policy".tr(),
                        icon: Icons.delivery_dining,
                        onTap: () {
                          navigate(context: context, route: ShippingPolicy());
                        },
                      ),
                      DrawerItem(
                        text: "Terms & Conditions".tr(),
                        icon: Icons.contact_support_sharp,
                        onTap: () {
                          navigate(
                              context: context, route: TermsAndConditions());
                        },
                      ),
                      if (Utiles.token.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InkWell(
                            onTap: () async {
                              await Utiles.logout();
                              navigateReplacement(
                                  context: context, route: MainScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.logout,
                                      color: AppColors.primiry,
                                      size: 30.fs,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    NeoText(
                                      'Logout',
                                      color: AppColors.black,
                                      align: TextAlign.justify,
                                      size: 20,
                                      fontWeight: FontWeight.w600,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // SqureButton(
          //   icon: Icons.shopping_cart,
          //   text: "Cart",
          // ),.
        ],
      ),
    );
  }
}
