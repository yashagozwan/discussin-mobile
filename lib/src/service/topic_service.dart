import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart';

class TopicService {
  final _client = DiscussinApi().getClient();

  Future<void> insertOne(Topic topic) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NSwidXNlcm5hbWUiOiJzZXJpemF3YSJ9.snMfk7HMsQNmBl-5yC9sbwTl6F1nFWtLjlTzoENEj7o';
    _client.options.headers['Authorization'] = 'Bearer $token';

    try {
      final results = await _client.post('/topics/create', data: topic.toMap());
      print(results);
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
