import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/service/comment_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Comment Service', () {
    late CommentService commentService;

    setUpAll(() async {
      commentService = CommentService();
    });

    test('Create Comment', () async {
      try {
        final comment = CommentModel(
          body: 'postingannya menarik sekali',
        );

        final results = await commentService.createComment(18, comment);

        print(results);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Comment By Id', () async {
      try {
        const postId = 18;
        final result = await commentService.getCommentsById(postId);
        print(result);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Single Comment', () async {});

    test('Update Comment', () async {});

    test('Delete Comment', () async {});
  });
}
