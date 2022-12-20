import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/follow_response_model.dart';

class FollowService {
  final _client = DiscussinApi().getClient();

  Future<FollowResponse> getFollow() async {
    try {
      final result = await _client.get('/posts/followed-posts/all');
      return FollowResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createFollow(int postId) async {
    try {
      final result = await _client.post('/posts/followed-posts/$postId');
      print(result);
    } on DioError {
      rethrow;
    }
  }

  Future<void> deleteFollow(int postId) async {
    try {
      final result = await _client.delete('/posts/followed-posts/$postId');
      print(result);
    } on DioError {
      rethrow;
    }
  }
}
