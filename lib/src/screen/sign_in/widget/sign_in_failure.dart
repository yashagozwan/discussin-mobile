import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';

class SignInFailure extends StatelessWidget {
  final void Function() onPressed;
  final String message;
  const SignInFailure({
    super.key,
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.warning_amber_rounded,
          color: redDanger,
          size: 50,
        ),
        const SizedBox(height: 8),
        const TextPro(
          'Whoops!',
          fontSize: 16,
          color: deepBlue,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        TextPro(
          message,
          fontSize: 13,
        ),
        const SizedBox(height: 4),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: redDanger,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8 * 3,
            ),
          ),
          onPressed: onPressed,
          child: const TextPro(
            'Try Again',
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
