import 'package:discussin_mobile/src/screen/profile/profile_screen.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  const ForgetPassword({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<ForgetPassword> {

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
      body: SingleChildScrollView(child: forgetPass()),
    );
  }
}

Widget forgetPass() {
  return Form(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Image.asset(
                      'assets/images/gembok.png',
                      scale: 1,
                    ),
                  ),
            const TextPro("Please enter your email to receive a verification card",
              fontWeight: FontWeight.w600,
            ),
            const SizedBox(height: 20,),
            const TextPro(
              'Email',
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w600,
            ),
            TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFCCD9F9),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 4,
                      ),
                      isDense: true,
                      hintText: 'Your E-mail Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
            const SizedBox(height: 30),
            ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFBEB23),
                      foregroundColor: Colors.black54,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    child: const TextPro(
                      'Send',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF142650),
                    ),
                  ),
          ],
        ),
      ),
    ),
  );
}