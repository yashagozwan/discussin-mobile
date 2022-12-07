import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/bookmark_response_model.dart';

class BookmarkService {
  final _client = DiscussinApi().getClient();

  Future<BookmarkResponse> getBookmark() async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoieXVraW5vIn0.6GykYja1z9lNSkZfpEL61D7QEv9L3ERDZrIp-wdrGMg';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.get('/posts/bookmarks/all');
      print(result);
      return BookmarkResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createBookmark(int postId) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsInVzZXJuYW1lIjoieXVraW5vIn0.6GykYja1z9lNSkZfpEL61D7QEv9L3ERDZrIp-wdrGMg';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.post(
        '/posts/bookmarks/$postId',
      );
      print(result);
    } on DioError {
      rethrow;
    }
  }
}
