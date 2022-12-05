import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';

class PostModel {
  String title;
  String photo;
  String body;

  PostModel({
    required this.title,
    this.photo = '',
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'photo': photo,
      'body': body,
    };
  }
}

class PostService {
  final _client = DiscussinApi().getClient();

  Future<PostResponse> getAllPost() async {
    try {
      final results = await _client.get('/posts/recents');
      return PostResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<bool> createPostByTopic(String topicName, PostModel post) async {
    try {
      await _client.post('/posts/create/$topicName', data: post.toMap());
      return true;
    } on DioError {
      rethrow;
    }
  }

  Future<PostResponse> getPostsByTopic(String topicName) async {
    try {
      final results = await _client.get('/posts/all/$topicName');
      return PostResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<void> getPostsById(int postId) async {
    try {
      final result = await _client.get('/posts/$postId');
      print(result);
    } on DioError {
      rethrow;
    }
  }
}
