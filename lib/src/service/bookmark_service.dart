import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/bookmark_response_model.dart';

class BookmarkService {
  final _client = DiscussinApi().getClient();

  Future<BookmarkResponse> getBookmark() async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODksInVzZXJuYW1lIjoidmVsb2N5cmFwdG9yeiJ9.tSCADlPnQCfoJpa5wAVPO_F4b_mkRQsf4qCC7tnZvIQ';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.get('/posts/bookmarks/all');
      return BookmarkResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> createBookmark(int postId) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODksInVzZXJuYW1lIjoidmVsb2N5cmFwdG9yeiJ9.tSCADlPnQCfoJpa5wAVPO_F4b_mkRQsf4qCC7tnZvIQ';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.post(
        '/posts/bookmarks/$postId',
      );
    } on DioError {
      rethrow;
    }
  }

  Future<void> deleteBookmark(int postId) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODksInVzZXJuYW1lIjoidmVsb2N5cmFwdG9yeiJ9.tSCADlPnQCfoJpa5wAVPO_F4b_mkRQsf4qCC7tnZvIQ';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final result = await _client.delete('/posts/bookmarks/delete/$postId');
    } on DioError {
      rethrow;
    }
  }
}
