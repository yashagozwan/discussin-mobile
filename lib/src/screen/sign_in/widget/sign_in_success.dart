import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';

class SignInSuccess extends StatelessWidget {
  const SignInSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(
          Icons.check_circle,
          color: greenSuccess,
          size: 50,
        ),
        SizedBox(height: 8),
        TextPro(
          'Sign In Success',
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
