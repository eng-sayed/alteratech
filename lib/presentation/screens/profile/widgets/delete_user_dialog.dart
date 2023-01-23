import 'package:alteratech/presentation/components/my+text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/loadinganderror.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class DeleteUserDialog extends StatelessWidget {
  const DeleteUserDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return LoadingAndError(
            isLoading: state is DeleteCustomerDataLoadingState,
            isError: state is DeleteCustomerDataSuccessState,
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: Image.asset(
                "assets/images/logo.png",
                height: 100,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  NeoText("acceptDeleteAccount".tr(),
                      fontWeight: FontWeight.bold),
                  NeoText("deleteAccountnote".tr(), color: Colors.red),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    await cubit.deleteUser(context);
                  },
                  child: NeoText("yes".tr(), fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: NeoText("no".tr(), fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        });
  }
}
