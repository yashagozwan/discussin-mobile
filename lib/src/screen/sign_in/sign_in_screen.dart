import 'dart:async';

import 'package:discussin_mobile/src/model/sign_in_model.dart';
import 'package:discussin_mobile/src/screen/home/home_screen.dart';
import 'package:discussin_mobile/src/screen/sign_in/widget/sign_in_failure.dart';
import 'package:discussin_mobile/src/screen/sign_in/widget/sign_in_success.dart';
import 'package:discussin_mobile/src/screen/sign_in/widget/text_field_password.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/view_model/sign_in_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../sign_up/sign_up_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  late SignInNotifier viewModel;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _initial() async {
    Future(() {
      viewModel = ref.read(signInViewModel);
    });
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

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
                      child: TextPro(
                        'Aloha!',
                        fontSize: 32,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFCCD9F9),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 4,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          'assets/icons/at.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      isDense: true,
                      hintText: 'Email ID',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldPassword(
                    controller: _passwordController,
                    hintText: 'Password',
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
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF285FE7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _loginAction,
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
                      'Login',
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF142650),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(text: "New to Diskusi.in?", children: [
                        TextSpan(
                          text: " Register",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SignUpScreen();
                                  },
                                ),
                              );
                            },
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF285FE7),
                          ),
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

  void _loginAction() async {
    final signIn = SignIn(
      email: _emailController.text,
      password: _passwordController.text,
    );

    viewModel.signIn(signIn);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(signInViewModel);

              switch (viewModel.actionState) {
                case StateAction.none:
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomeScreen();
                        },
                      ),
                      (route) => false,
                    );
                  });
                  return const SignInSuccess();
                case StateAction.loading:
                  return _signInLoading();
                case StateAction.error:
                  return SignInFailure(
                    message: viewModel.errorMessage ?? '',
                    onPressed: () => Navigator.pop(context),
                  );
              }
            },
          ),
        );
      },
    );
  }

  Widget _signInLoading() {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
