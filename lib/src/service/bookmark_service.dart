import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/bookmark_response_model.dart';

class BookmarkService {
  final _client = DiscussinApi().getClient();

  Future<BookmarkResponse> getBookmark() async {
    try {
      final result = await _client.get('/posts/bookmarks/all');
      return BookmarkResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createBookmark(int postId) async {
    try {
      final result = await _client.post(
        '/posts/bookmarks/$postId',
      );
    } on DioError {
      rethrow;
    }
  }

  Future<void> deleteBookmark(int postId) async {
    try {
      final result = await _client.delete('/posts/bookmarks/delete/$postId');
    } on DioError {
      rethrow;
    }
  }
}
