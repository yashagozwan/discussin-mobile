import 'package:flutter/material.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;

  const TextFieldPassword({
    super.key,
    this.controller,
    this.hintText,
  });

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool isVisible = true;

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
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              obscureText: isVisible,
              controller: widget.controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: widget.hintText,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => setState(() => isVisible = !isVisible),
            child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          ),
        ],
      ),
    );
  }
}