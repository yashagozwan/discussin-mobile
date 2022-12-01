import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCode extends ConsumerStatefulWidget {
  const AuthCode({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCodeState();
}

class _AuthCodeState extends ConsumerState<AuthCode> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const TextPro("Forgot Password",
        fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
      body: TextPro("Hello"),
    );;
  }
}