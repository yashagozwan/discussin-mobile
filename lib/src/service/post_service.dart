import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/api/discussin_api.dart';
import 'package:discussin_mobile/src/model/post_detail_response_model.dart';
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
    const token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODksInVzZXJuYW1lIjoidmVsb2N5cmFwdG9yeiJ9.tSCADlPnQCfoJpa5wAVPO_F4b_mkRQsf4qCC7tnZvIQ';

    _client.options.headers['Authorization'] = 'Bearer $token';
    try {
      final results = await _client.get('/posts/recents');
      return PostResponse.fromMap(results.data);
    } on DioError {
      rethrow;
    }
  }

  Future<PostResponse> getTrendingPost() async {
    try {
      final results = await _client.get('/posts/recents/top');
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

  Future<PostDetailResponse> getPostsById(int postId) async {
    try {
      final result = await _client.get('/posts/$postId');
      return PostDetailResponse.fromMap(result.data);
    } on DioError {
      rethrow;
    }
  }
}
