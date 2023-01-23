// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';

// part 'check_out_state.dart';

// class CheckOutCubit extends Cubit<CheckOutState> {
//   CheckOutCubit() : super(CheckOutInitial());
//   static CheckOutCubit get(context) => BlocProvider.of(context);
//   TextEditingController firstNameBilling = TextEditingController();
//   TextEditingController lastNameBilling = TextEditingController();
//   TextEditingController emailBilling = TextEditingController();
//   TextEditingController adressBilling = TextEditingController();
//   TextEditingController phoneNumberBilling = TextEditingController();
//   TextEditingController firstNameShipping = TextEditingController();
//   TextEditingController lastNameShipping = TextEditingController();
//   TextEditingController emailShipping = TextEditingController();
//   TextEditingController adressShipping = TextEditingController();
//   TextEditingController phoneNumberShipping = TextEditingController();
//   TextEditingController notes = TextEditingController();

//   final response = await AuthRepository.getCustomerData(
//         context: context, Id: Utiles.UserId);
//     final response2 = await OrderRepo.getZones(context);
//     if (response != null && response2 != null) {
//       firstNameBilling.text = response.firstName ?? "";
//       lastNameBilling.text = response.lastName ?? "";
//       emailBilling.text = response.email ?? "";
//       adressBilling.text = response.billing?.address1 ?? "";
//       phoneNumberBilling.text = response.billing?.phone ?? "";
//       firstNameShipping.text = response.firstName ?? "";
//       lastNameShipping.text = response.lastName ?? "";
//       emailShipping.text = response.email ?? "";
//       adressShipping.text = response.shipping?.address1 ?? "";
//       zones = response2;
//       emit(GetCustomerDataSuccessState());
//     } else {
//       emit(GetCustomerDataErrorState());
//     }
//   }

// }
