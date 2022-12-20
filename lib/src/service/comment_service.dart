import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/comment_response_model.dart';

class CommentModel {
  String body;

  CommentModel({
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'body': body,
    };
  }
}

class CommentService {
  final _client = DiscussinApi().getClient();

  Future<CommentResponse> getCommentsById(int postId) async {
    try {
      final results = await _client.get('/posts/comments/$postId');
      return CommentResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<bool> createComment(int postId, CommentModel comment) async {
    try {
      await _client.post('/posts/comments/create/$postId',
          data: comment.toMap());
      return true;
    } on DioError {
      rethrow;
    }
  }
}
