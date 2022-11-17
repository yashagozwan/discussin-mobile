import 'package:discussin_mobile/src/widget/elevated_button_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Image.asset(
                      'assets/images/Discussin_Login_Image.png',
                      scale: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        text: "Alloha!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFf3f2f2),
                      contentPadding: EdgeInsets.all(13),
                      prefixIcon: Icon(Icons.email_outlined),
                      isDense: true,
                      hintText: 'Email ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFf3f2f2),
                      contentPadding: EdgeInsets.all(13),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      isDense: true,
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text.rich(
                      TextSpan(
                        text: "Forget Password?",
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButtonPro(
                    onPressed: () {},
                    title: 'Login',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Stack(
                  //   children: [
                  //     const Divider(
                  //       thickness: 2,
                  //     ),
                  //     Align(
                  //       alignment: Alignment.center,
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         width: 30,
                  //         color: Colors.white,
                  //         child: const Text('Or'),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(text: "New to Discuss.in?", children: [
                        TextSpan(
                          text: " Register",
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
