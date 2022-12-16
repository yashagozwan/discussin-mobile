import 'package:discussin_mobile/src/screen/home/home_screen.dart';
import 'package:discussin_mobile/src/screen/sign_in/sign_in_screen.dart';
import 'package:discussin_mobile/src/view_model/splash_view_model.dart';
import 'package:discussin_mobile/src/widget/text_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> _initial() async {
    final viewModel = ref.read(splashViewModel);
    final token = await viewModel.getToken();

    await Future.delayed(
      const Duration(milliseconds: 4000),
    );

    if (token != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 3000),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/discussin_logo.svg',
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(height: 16),
                  const TextPro(
                    'Discuss.in',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
