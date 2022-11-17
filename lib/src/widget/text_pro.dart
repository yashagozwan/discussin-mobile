import 'package:flutter/material.dart';

class TextPro extends StatelessWidget {
  final String data;

  const TextPro(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
