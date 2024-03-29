import 'package:alteratech/presentation/screens/main_screen/screens/main_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/navigator.dart';
import 'cubit/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final splashCubit = SplashCubit.get(context);
      splashCubit.getToken();
      await _navigateToHome();
    });
    // FireBaseMessaging().initUniLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          "assets/images/logo.png",
          width: 200,
        ),
        // Positioned(
        //   top: -100,
        //   left: -100,
        //   child: CircleAvatar(
        //     radius: 100,
        //   ),
        // ),
        // Positioned(
        //   top: -110,
        //   left: -110,
        //   child: CircleAvatar(
        //     backgroundColor: AppColors.primiry.withOpacity(0.5),
        //     radius: 110,
        //   ),
        // ),
        // Positioned(
        //   bottom: -100,
        //   right: -100,
        //   child: CircleAvatar(
        //     radius: 100,
        //     backgroundColor: AppColors.secondary,
        //   ),
        // ),
        // Positioned(
        //   bottom: -110,
        //   right: -110,
        //   child: CircleAvatar(
        //     backgroundColor: AppColors.secondary.withOpacity(0.5),
        //     radius: 114,
        //   ),
        // )
      ],
    );
  }

  _navigateToHome() async {
    await Future.delayed(
      const Duration(milliseconds: 3000),
      () {},
    );
    navigateReplacement(context: context, route: MainScreen());
  }
}
