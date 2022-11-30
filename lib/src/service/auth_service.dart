import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/login_response_model.dart';
import 'package:discussin_mobile/src/model/sign_in_model.dart';
import 'package:discussin_mobile/src/model/sign_up_model.dart';

class AuthService {
  final _client = DiscussinApi().getClient();

  Future<LoginResponse> login(SignIn signIn) async {
    try {
      final response = await _client.post('/users/login', data: signIn.toMap());
      return LoginResponse.fromMap(response.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> register(SignUp signUp) async {
    try {
      await _client.post('/users/register', data: signUp.toMap());
    } on DioError {
      rethrow;
    }
  }
}
