import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/sign_in_model.dart';
import 'package:discussin_mobile/src/model/sign_up_model.dart';
import 'package:discussin_mobile/src/service/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Auth Service', () {
    late final AuthService authService;

    setUpAll(() {
      authService = AuthService();
    });

    test('Login', () async {
      try {
        final result = await authService.login(
          SignIn(email: 'kecoaterbang@gmail.com', password: 'kecoaterbang'),
        );

        print(result.data.token);
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
      }
    });

    test('Register', () async {
      try {
        final result = await authService.register(SignUp(
          username: 'yukino',
          email: 'yukino@gmail.com',
          password: '12345Mantap',
          isAdmin: true,
        ));

        print(result);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });
  });
}
