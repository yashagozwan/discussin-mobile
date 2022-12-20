import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart';

class Model {}

final bookmarks = [];

class TopicService {
  final _client = DiscussinApi().getClient();

  Future<bool> createTopic(Topic topic) async {
    try {
      await _client.post('/topics/create', data: topic.toMap());
      return true;
    } on DioError {
      rethrow;
    }
  }

  Future<TopicResponse> getTopics() async {
    try {
      final results = await _client.get('/topics');
      return TopicResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }
}
