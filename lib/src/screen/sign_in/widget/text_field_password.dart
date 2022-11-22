import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? Function(String? value)? validator;
  
  const TextFieldPassword({
    super.key,
    this.controller,
    this.hintText,
    this.validator
  });

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isVisible,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFCCD9F9),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 4,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(
            'assets/icons/lock.png',
            width: 20,
            height: 20,
            fit: BoxFit.fill,
          ),
        ),
        isDense: true,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: () => setState(() => isVisible = !isVisible),
          child: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
