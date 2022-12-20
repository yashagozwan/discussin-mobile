import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Post Service', () {
    late PostService postService;

    setUpAll(() async {
      postService = PostService();
    });

    test('Create Post', () async {
      try {} on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get All Post', () async {
      try {
        final result = await postService.getAllPost();
        print(result);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Trending Post', () async {
      try {
        final result = await postService.getTrendingPost();
        print(result);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Posts By Topic', () async {
      try {
        const topicName = 'Music';
        final results = await postService.getPostsByTopic(topicName);
        print(results);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Post By Id', () async {
      try {
        const postId = 18;
        final results = await postService.getPostsById(postId);

        print(results);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Update Post', () async {});

    test('Delete Post', () async {});
  });
}
