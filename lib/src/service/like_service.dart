import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';

abstract class PostLikeable {
  Future<bool> doLikePost(int postId);
  Future<bool> doDislikePost(int postId);
}

class LikeService implements PostLikeable {
  final _client = DiscussinApi().getClient();

  @override
  Future<bool> doLikePost(int postId) async {
    try {
      await _client.put('/posts/like/$postId');
      return true;
    } on DioError {
      return false;
    }
  }

  @override
  Future<bool> doDislikePost(int postId) async {
    try {
      await _client.put('/posts/dislike/$postId');
      return true;
    } on DioError {
      return false;
    }
  }
}
