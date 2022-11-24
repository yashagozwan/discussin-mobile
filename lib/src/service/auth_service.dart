import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/login_response_model.dart';
import 'package:discussin_mobile/src/model/sign_in_model.dart';
import 'package:discussin_mobile/src/model/sign_up_model.dart';

class AuthService {
  final DiscussinApi _discussinApi = DiscussinApi();

  Future<LoginResponse> login(SignIn signIn) async {
    try {
      final response = await _discussinApi.getClient().post(
            '/api/v1/users/login',
            data: signIn.toMap(),
          );

      return LoginResponse.fromMap(response.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> register(SignUp signUp) async {
    try {
      final data = await _discussinApi.getClient().post(
            '/api/v1/users/register',
            data: signUp.toMap(),
          );

      print(data);
    } on DioError catch (error) {
      print(error.message);
      print(error.response?.data['message']);
    }
  }
}
