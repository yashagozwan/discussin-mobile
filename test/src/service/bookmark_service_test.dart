import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/service/bookmark_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Bookmark Service', () {
    late BookmarkService bookmarkService;

    setUpAll(() async {
      bookmarkService = BookmarkService();
    });

    test('Create Bookmark', () async {
      try {
        const postId = 31;
        final result = await bookmarkService.createBookmark(postId);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Bookmark', () async {
      try {
        final result = await bookmarkService.getBookmark();
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });
  });
}
