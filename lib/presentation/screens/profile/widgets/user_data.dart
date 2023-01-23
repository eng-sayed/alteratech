import 'package:alteratech/core/utils/responsive.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/validation.dart';
import '../../../components/login_text_failed.dart';
import '../../../components/my+text.dart';
import '../cubit/cubit.dart';

class UserDataEdit extends StatefulWidget {
  const UserDataEdit({
    Key? key,
  }) : super(key: key);

  @override
  State<UserDataEdit> createState() => _UserDataEditState();
}

class _UserDataEditState extends State<UserDataEdit> {
  String? city;
  @override
  void initState() {
    // firstNameBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.firstName ?? "");
    // lastNameBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.lastName ?? "");
    // emailBilling =
    //     TextEditingController(text: WooCommerce.currentCustommer!.email ?? "");
    // adressBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.billing!.address1 ?? "");
    // adressShipping = TextEditingController(
    //     text: WooCommerce.currentCustommer!.shipping!.address1 ?? "");
    // // postCodeBilling = TextEditingController(
    // //     text: WooCommerce.currentCustommer!.billing!.postcode ?? "");
    // phoneNumberBilling = TextEditingController(
    //     text: WooCommerce.currentCustommer!.billing!.phone ?? "");

    // city = WooCommerce.currentCustommer!.billing!.city;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          //  title: "profile".tr(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LoginTextField(
                    label: "lname".tr(),
                    controller: cubit.firstNameBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    hintText: "firstname".tr(),
                    suffixIcon: Icon(Icons.person),
                  ),
                  LoginTextField(
                    label: "fname".tr(),
                    controller: cubit.lastNameBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    hintText: "lastname".tr(),
                  ),
                  // NeoText(, size: 18.fs, color: Colors.black),
                  LoginTextField(
                    suffixIcon: Icon(Icons.email),
                    label: "email".tr(),

                    enable: false,
                    controller: cubit.emailBilling,
                    keyboardType: TextInputType.emailAddress,
                    validate: Validation().emailValidation,
                    // hintText: "xxxx@gmail.com",
                  ),
                  // NeoText(, size: 18.fs, color: Colors.black),
                  LoginTextField(
                    label: "phone".tr(),

                    // enable: false,
                    suffixIcon: Icon(Icons.phone),
                    controller: cubit.phoneNumberBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    // hintText: "01XXXXXXXXX",
                  ),

                  // NeoText("adress".tr(), size: 18.fs, color: Colors.black),
                  LoginTextField(
                    suffixIcon: Icon(Icons.home),
                    label: "adress".tr(),
                    controller: cubit.adressBilling,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    // hintText: "15 st xxxxxxxxx",
                  ),
                  // NeoText(,
                  //     size: 18.fs, color: Colors.black),
                  LoginTextField(
                    suffixIcon: Icon(Icons.delivery_dining_sharp),

                    label: "shippingadress".tr(),
                    controller: cubit.adressShipping,
                    keyboardType: TextInputType.text,
                    validate: (s) {},
                    // hintText: "15 st xxxxxxxxx",
                  ),
                  // NeoText("PostCode /Zip", size: 18.fs, color: Colors.white),
                  // NeoTextField(
                  //   keyboardType: TextInputType.text,
                  //   validate: Validation().defaultValidation,
                  //   hintText: "1355",
                  // ),

                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: AppColors.primiry,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            cubit.updateUserData(context);
                          }
                        },
                        child: NeoText(
                          "save".tr(),
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeLang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            context.locale = Locale('ar', 'EG');
            // navigateReplacement(context: context, route: Home());

            // isarabic = true;
            // setState(() {});
          },
          child: Row(
            children: <Widget>[
              NeoText("العربيه"),
              Spacer(),
              context.locale != Locale('en', 'US')
                  ? Icon(Icons.done)
                  : SizedBox()
            ],
          ),
        ),
        InkWell(
          onTap: () {
            context.locale = Locale('en', 'US');
            // navigateReplacement(context: context, route: Home());
            // isarabic = false;
            // setState(() {});
          },
          child: Row(
            children: <Widget>[
              NeoText("English"),
              Spacer(),
              context.locale == Locale('en', 'US')
                  ? Icon(Icons.done)
                  : SizedBox()
            ],
          ),
        ),
      ],
    );
  }
}
