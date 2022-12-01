import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart';

class Model {}

final bookmarks = [];

class TopicService {
  final _client = DiscussinApi().getClient();

  Future<bool> createTopic(Topic topic) async {
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NzAwMDE0NDMsImlkIjoxMSwidXNlcm5hbWUiOiJ5dWtpbm8ifQ.rW7otzk5Gg_tgTylBOoNJQNFUeSTlLkbFgjOSje3xag';

    _client.options.headers['Authorization'] = 'Bearer $token';

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
