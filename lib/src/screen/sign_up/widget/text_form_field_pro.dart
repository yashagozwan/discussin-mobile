import 'package:flutter/material.dart';

class TextFormFieldPro extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final bool obscureText;

  final String? Function(String? value)? validator;

  const TextFormFieldPro({
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffadaaaa).withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
