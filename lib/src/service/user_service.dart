import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/user_response_model.dart';

class UserUpdate {
  String username;
  String photo;

  UserUpdate({
    required this.username,
    required this.photo,
  });
  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'photo': photo,
    };
  }
}

class UserService {
  final _client = DiscussinApi().getClient();

  Future<UserResponse> getUser() async {
    // const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInVzZXJuYW1lIjoia2Vjb2F0ZXJiYW5nIn0.p1N8r-iqxM2P9epauzy5x-QiIZR2pcLn5g-77rW9nhI';
    // _client.options.headers['Authorization'] = 'Bearer $token';

    try {
      final result = await _client.get('/users/profile');
      return UserResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> updateUser(UserUpdate userUpdate) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQsInVzZXJuYW1lIjoiamFuY29rIn0.WsE7dwjI9j771WsZqRapkGzzqxkEqFjHf2Uac96EPOc';
    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result =
          await _client.put('/users/profile/edit', data: userUpdate.toMap());
      print(result);
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }
}
