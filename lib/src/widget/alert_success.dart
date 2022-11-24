import 'package:discussin_mobile/src/widget/elevated_button_pro.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';

class AlertSuccess extends StatelessWidget {
  const AlertSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(21),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF00CD15),
            size: 60,
          ),
          const SizedBox(height: 8 * 2),
          const TextPro(
            'Rick',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          const SizedBox(height: 8),
          const TextPro(
            'Your account has been successfully created, please login',
            fontSize: 13,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFBEB23),
              elevation: 0,
              foregroundColor: Colors.black54,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8 * 4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const TextPro(
              'Login Now',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
