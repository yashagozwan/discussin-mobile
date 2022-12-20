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
    try {
      final result = await _client.get('/users/profile');
      return UserResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> updateUser(UserUpdate userUpdate) async {
    try {
      final result =
          await _client.put('/users/profile/edit', data: userUpdate.toMap());
      print(result);
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }
}
