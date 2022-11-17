import 'package:flutter/material.dart';

class TextPro extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextAlign? textAlign;
  final double? height;
  final Color? color;

  const TextPro(
    this.data, {
    super.key,
    this.fontWeight,
    this.fontSize,
    this.textAlign,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        color: color,
      ),
    );
  }
}
