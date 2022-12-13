import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/follow_response_model.dart';

class FollowService {
  final _client = DiscussinApi().getClient();

  Future<FollowResponse> getFollow() async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoieXVraW5vIn0.6GykYja1z9lNSkZfpEL61D7QEv9L3ERDZrIp-wdrGMg';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.get('/posts/followed-posts/all');
      return FollowResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createFollow(int postId) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoieXVraW5vIn0.6GykYja1z9lNSkZfpEL61D7QEv9L3ERDZrIp-wdrGMg';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.post('/posts/followed-posts/$postId');
      print(result);
    } on DioError {
      rethrow;
    }
  }

  Future<void> deleteFollow(int postId) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoieXVraW5vIn0.6GykYja1z9lNSkZfpEL61D7QEv9L3ERDZrIp-wdrGMg';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.delete('/posts/followed-posts/$postId');
      print(result);
    } on DioError {
      rethrow;
    }
  }
}
