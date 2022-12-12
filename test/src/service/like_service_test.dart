import 'package:discussin_mobile/src/service/like_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Like Service', () {
    late LikeService likeService;

    setUpAll(() {
      likeService = LikeService();
    });

    test('Do Like', () async {
      const postId = 31;
      final result = await likeService.doLikePost(postId);
      expect(result, true);
    });

    test('Do Dislike', () async {
      const postId = 31;
      final result = await likeService.doDislikePost(postId);
      expect(result, true);
    });
  });
}
