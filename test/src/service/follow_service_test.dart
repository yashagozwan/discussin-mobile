import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/service/follow_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Follow Service', () {
    late FollowService followService;

    setUpAll(() {
      followService = FollowService();
    });

    test('Create Follow', () async {
      try {
        const postId = 30;
        await followService.createFollow(postId);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Delete Followed', () async {
      try {
        const postId = 30;
        await followService.deleteFollow(postId);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Followed Post', () async {
      try {
        final result = await followService.getFollow();
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });
  });
}
