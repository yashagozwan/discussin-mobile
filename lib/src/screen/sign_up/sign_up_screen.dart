import 'package:discussin_mobile/src/model/sign_up_model.dart';
import 'package:discussin_mobile/src/screen/sign_up/widget/text_field_password.dart';
import 'package:discussin_mobile/src/screen/sign_up/widget/text_form_field_pro.dart';
import 'package:discussin_mobile/src/util/colors.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:discussin_mobile/src/util/util.dart';
import 'package:discussin_mobile/src/view_model/sign_up_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  late SignUpNotifier viewModel;

  Future<void> _initial() async {
    Future(() {
      viewModel = ref.read(signUpViewModel);
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
          'Username',
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFormFieldPro(
          controller: _usernameController,
          hintText: 'Your username',
          validator: (value) {
            if (value!.isEmpty) {
              _showSnackBar('Please enter username');
              return '';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const TextPro(
          'Email',
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(height: 8),
        TextFormFieldPro(
          controller: _emailController,
          hintText: 'Your E-mail Address',
          validator: (value) {
            if (!(value!.isValidEmail())) {
              _showSnackBar('Check your email');
              return '';
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
            if (value!.isEmpty) {
              _showSnackBar('Please enter password');
              return '';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _registerAction,
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

  void _registerAction() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _showAlertDialog();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showAlertDialog() {
    final signUp = SignUp(
      username: _usernameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    viewModel.register(signUp);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Consumer(
            builder: (context, ref, child) {
              final viewModel = ref.watch(signUpViewModel);

              switch (viewModel.actionState) {
                case StateAction.none:
                  return _signUpSuccess(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                case StateAction.loading:
                  return _signUpLoading();
                case StateAction.error:
                  return _signUpFailure(
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

  Widget _signUpFailure({
    required String message,
    required void Function() onPressed,
  }) {
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

  Widget _signUpSuccess({
    required void Function() onPressed,
  }) {
    return Column(
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
          'Yippee',
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
          onPressed: onPressed,
          child: const TextPro(
            'Login Now',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _signUpLoading() {
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
