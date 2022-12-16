import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart';
import 'package:discussin_mobile/src/service/topic_service.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> main() async {
  group('Topic Service', () {
    late final TopicService topicService;

    setUpAll(() {
      topicService = TopicService();
    });

    test('Create Topic', () async {
      try {
        final topic = Topic(
          name: 'Game',
          description: 'Game is my favorite GTA',
        );

        final results = await topicService.createTopic(topic);

        print(results);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });

    test('Get Topics', () async {
      try {
        final results = await topicService.getTopics();
        print(results);
        expect(results.data, isNotEmpty);
      } on DioError catch (error) {
        print(error.message);
        print(error.response?.data);
      }
    });
  });
}
