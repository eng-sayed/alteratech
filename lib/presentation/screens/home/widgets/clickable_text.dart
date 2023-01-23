import 'package:alteratech/presentation/components/my+text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ClickableText extends StatefulWidget {
  ClickableText(
      {Key? key, required this.text, required this.color, required this.ontap})
      : super(key: key);
  String? text;
  final VoidCallback? ontap;
  Color? color;
  @override
  State<ClickableText> createState() => _ClickableTextState();
}

class _ClickableTextState extends State<ClickableText> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.ontap,
        child: NeoText(
          widget.text!,
          color: widget.color,
          fontWeight: FontWeight.w600,
          size: 18,
        ));
  }
}

enum select { trend, feature }
