import 'package:discussin_mobile/src/screen/sign_up/widget/text_field_password.dart';
import 'package:discussin_mobile/src/screen/sign_up/widget/text_form_field_pro.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _title(),
                const SizedBox(height: 32),
                _buildFields(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const TextPro(
          'Create account',
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        const SizedBox(height: 8),
        Text.rich(
          TextSpan(
            text: 'Enter your account details below or ',
            children: [
              TextSpan(
                text: 'Log In',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pop(context);
                  },
                style: const TextStyle(
                  color: Color(0xFF285FE7),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF142650),
          ),
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const TextPro(
          'Email',
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFormFieldPro(
          controller: _emailController,
          hintText: 'Your E-mail Address',
          validator: (input) => input!.isValidEmail() ? null : "Check your email",
        ),
        const SizedBox(height: 16),
        const TextPro(
          'Username',
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFormFieldPro(
          controller: _usernameController,
          hintText: 'Your username',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter username';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const TextPro(
          'Password',
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFieldPassword(
          controller: _passwordController,
          hintText: 'Your password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter username';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
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
            'Create Account',
            fontWeight: FontWeight.w700,
            color: Color(0xFF142650),
          ),
        ),
      ],
    );
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

