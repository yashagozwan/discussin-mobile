import 'package:flutter/material.dart';

class ElevatedButtonPro extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const ElevatedButtonPro({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(13, 20, 13, 20),
        backgroundColor: const Color(0xFFC4C4C4),
        foregroundColor: Colors.white.withOpacity(0.5),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
