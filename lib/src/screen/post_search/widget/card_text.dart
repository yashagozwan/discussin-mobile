import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';

class CardText extends StatelessWidget {
  final String headTitle;
  final String bodyTitle;
  final String subTitle;

  const CardText({
    super.key,
    required this.headTitle,
    required this.bodyTitle,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black12,
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextPro(headTitle),
          const SizedBox(height: 4),
          TextPro(
            bodyTitle,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 4),
          TextPro(
            subTitle,
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
