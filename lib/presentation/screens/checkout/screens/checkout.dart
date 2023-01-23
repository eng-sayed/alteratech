// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:alteratech/core/utils/responsive.dart';

// import '../../../components/loadinganderror.dart';
// import '../../cart/cubit/cart_cubit.dart';

// class Checkout extends StatefulWidget {
//   const Checkout({Key? key}) : super(key: key);

//   @override
//   _CheckoutState createState() => _CheckoutState();
// }

// class _CheckoutState extends State<Checkout> {
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final cubit = CheckOutCubit.get(context);
//       await cubit.iniOrderScreen(context);
//     });
//     super.initState();
//   }

//   bool shipping = false;
//   GlobalKey<FormState> formkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     final cubit = CheckOutCubit.get(context);
//     final cartCubit = CartCubit.get(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("checkout".tr()),
//       ),
//       body: BlocConsumer<CheckOutCubit, CkeckoutStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return LoadingAndError(
//               isError: state is GetCustomerDataErrorState,
//               isLoading: state is GetCustomerDataLoadingState,
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Form(
//                     key: formkey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         OrderItemWidget(
//                           showTrack: false,
//                           order: WooOrder(
//                               id: 0,
//                               dateCreated: DateTime.now().toString(),
//                               total: cartCubit.cartTotal(),
//                               lineItems: cartCubit.cart.wooCartitems!
//                                   .map((e) => LineItems(
//                                       name: e.name,
//                                       price: e.wooItemPrices!.price!,
//                                       quantity: e.quantity,
//                                       subtotal: (double.parse(
//                                                   e.wooItemPrices!.price!) *
//                                               e.quantity!)
//                                           .toString()))
//                                   .toList()),
//                         ),
//                         ExpandCardInSide(
//                           isexpand: true,
//                           titlecolor: AppColors.primiry,
//                           color: AppColors.white,
//                           title: "baillingdetails".tr(),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 CustomText("name".tr(), fontsize: 18.fs),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: LoginTextField(
//                                         controller: cubit.firstNameBilling,
//                                         keyboardType: TextInputType.text,
//                                         validate:
//                                             Validation().defaultValidation,
//                                         hintText: "firstname".tr(),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Expanded(
//                                       child: LoginTextField(
//                                         controller: cubit.lastNameBilling,
//                                         keyboardType: TextInputType.text,
//                                         validate:
//                                             Validation().defaultValidation,
//                                         hintText: "lastname".tr(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 // CustomText("Country", fontsize: 18.fs),
//                                 // DefaultDropdownButton(
//                                 //   selectedItem: "Egypt",
//                                 //   enabled: false,
//                                 // ),
//                                 // if (!shipping)
//                                 SelectPaymentMethode(
//                                   isShipping: false,
//                                 ),
//                                 CustomText("adress".tr(), fontsize: 18.fs),
//                                 LoginTextField(
//                                   controller: cubit.adressBilling,
//                                   keyboardType: TextInputType.text,
//                                   validate: Validation().defaultValidation,
//                                   hintText: "15 st xxxxxxxxx",
//                                 ),
//                                 // CustomText("PostCode /Zip", fontsize: 18.fs),
//                                 // LoginTextField(
//                                 //   keyboardType: TextInputType.text,
//                                 //   validate: Validation().defaultValidation,
//                                 //   hintText: "1355",
//                                 // ),
//                                 CustomText("phone".tr(), fontsize: 18.fs),
//                                 LoginTextField(
//                                   controller: cubit.phoneNumberBilling,
//                                   keyboardType: TextInputType.number,
//                                   validate: Validation().defaultValidation,
//                                   hintText: "010XXXXXXXXX",
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               CustomText("shippingtodiffrent".tr(),
//                                   color: AppColors.primiry),
//                               Spacer(),
//                               Checkbox(
//                                   value: shipping,
//                                   onChanged: (s) {
//                                     shipping = s!;
//                                     setState(() {});
//                                   })
//                             ],
//                           ),
//                         ),
//                         !shipping
//                             ? SizedBox()
//                             : ExpandCardInSide(
//                                 titlecolor: AppColors.primiry,
//                                 color: Colors.white,
//                                 title: "shippingadress".tr(),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       CustomText("Name", fontsize: 18.fs),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: LoginTextField(
//                                               keyboardType: TextInputType.text,
//                                               validate: Validation()
//                                                   .defaultValidation,
//                                               controller:
//                                                   cubit.firstNameShipping,
//                                               hintText: "First Name",
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             width: 10,
//                                           ),
//                                           Expanded(
//                                             child: LoginTextField(
//                                               controller:
//                                                   cubit.lastNameShipping,
//                                               keyboardType: TextInputType.text,
//                                               validate: Validation()
//                                                   .defaultValidation,
//                                               hintText: "Last Name",
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SelectPaymentMethode(isShipping: true),
//                                       CustomText("adress".tr(),
//                                           fontsize: 18.fs),
//                                       LoginTextField(
//                                         keyboardType: TextInputType.text,
//                                         controller: cubit.adressShipping,
//                                         validate:
//                                             Validation().defaultValidation,
//                                         hintText: "15 st xxxxxxxxx",
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                         Card(
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 CustomText("ordernotes".tr(), fontsize: 18.fs),
//                                 LoginTextField(
//                                   border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(15)),
//                                   controller: cubit.notes,
//                                   keyboardType: TextInputType.text,
//                                   validate: (s) {},
//                                   hintText: "notes".tr(),
//                                   maxlines: 6,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     shape: StadiumBorder()),
//                                 onPressed: () async {
//                                   if (formkey.currentState!.validate()) {
//                                     if (cubit.billingShippingZoneMethod ==
//                                         null) {
//                                       OverLays.snack(context,
//                                           text: "Select shipping method".tr(),
//                                           state: SnakState.failed);
//                                     } else {
//                                       if (shipping &&
//                                           cubit.shippingZoneMethod == null) {
//                                         OverLays.snack(context,
//                                             text: "Select shipping method".tr(),
//                                             state: SnakState.failed);
//                                       } else {
//                                         cubit.sendOrder(context, shipping,
//                                             cartCubit.cart.wooCartitems ?? []);
//                                       }
//                                     }
//                                   }
//                                 },
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 30),
//                                   child: CustomText("confirmorder".tr(),
//                                       color: Colors.white),
//                                 )),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
