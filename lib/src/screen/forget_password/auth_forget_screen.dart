import 'package:discussin_mobile/src/screen/forget_password/new_password_screen.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

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
        elevation: 0,
      ),
      body: SingleChildScrollView(child: codePass()),
    );
  }

  Widget codePass() {
    return Form(
    child: Center(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TextPro("Enter code sent to your email",
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: 20),
            const TextPro("Already sent to email : tes_email@gmail.com"),
            SizedBox(height: 80),
            OtpTextField(
                    mainAxisAlignment: MainAxisAlignment.center,
                    numberOfFields: 4,
                    fieldWidth: 40,
                    borderColor: Color.fromARGB(255, 0, 0, 0),
                    borderWidth: 2,
                    filled: true,
                    textStyle: TextStyle(fontSize: 20),
                    enabledBorderColor: Color.fromARGB(255, 0, 0, 0),
                    margin: const EdgeInsets.only(right: 35),
                    showFieldAsBox: false, 
                    onCodeChanged: (String code) {
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                        showDialog(
                            context: context,
                            builder: (context){
                            return AlertDialog(
                                title: Text("Verification Code"),
                                content: Text('Code entered is $verificationCode'),
                            );
                            }
                        );
                    }, // end onSubmit
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    TextPro("Didn’t receive code?",
                    ),
                    TextPro(" Request again",
                    fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const NewPass();
                                  },
                                ),
                              );
                    },
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
                      'Continue',
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
  }