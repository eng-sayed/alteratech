import 'package:alteratech/core/utils/responsive.dart';
import 'package:alteratech/presentation/components/my+text.dart';
import 'package:flutter/material.dart';

import '../../../../core/themes/colors.dart';
import '../../../../core/utils/navigator.dart';

class SqureButton extends StatelessWidget {
  const SqureButton(
      {Key? key, required this.icon, this.onTap, required this.text})
      : super(key: key);
  final VoidCallback? onTap;
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.primiry,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.all(12.0.fs),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25.fs,
              ),
            ),
          ),
        ),
        NeoText(text, size: 13.fs)
      ],
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({Key? key, required this.icon, required this.text, this.onTap})
      : super(
          key: key,
        );
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Icon(
              icon,
              color: AppColors.primiry,
              size: 30.fs,
            ),
            SizedBox(
              width: 15,
            ),
            NeoText(
              text,
              color: AppColors.black,
              align: TextAlign.justify,
              size: 20,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
