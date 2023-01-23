import 'package:alteratech/core/themes/colors.dart';
import 'package:flutter/material.dart';

class NeoText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextAlign? align;
  final TextDecoration? decoration;
  final VoidCallback? onClick;

  NeoText(
    this.text, {
    this.size,
    this.decoration,
    this.align,
    this.fontWeight,
    this.color,
    this.onClick,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: onClick == null
          ? Text(
              text,
              overflow: TextOverflow.ellipsis,
              textAlign: align ?? TextAlign.center,
              maxLines: maxLines ?? 1,
              style: TextStyle(
                decoration: decoration ?? TextDecoration.none,
                fontSize: size ?? 17,
                fontWeight: fontWeight ?? FontWeight.normal,
                color: color ?? AppColors.black,
              ),
            )
          : TextButton(
              onPressed: () {
                onClick?.call();
              },
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                textAlign: align ?? TextAlign.center,
                maxLines: maxLines ?? 1,
                style: TextStyle(
                  decoration: decoration ?? TextDecoration.none,
                  fontSize: size ?? 17,
                  fontWeight: fontWeight ?? FontWeight.normal,
                  color: color ?? AppColors.black,
                ),
              ),
            ),
    );
  }
}
