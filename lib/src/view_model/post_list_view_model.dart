import 'package:dio/dio.dart';
import 'package:discussin_mobile/src/model/post_response_model.dart';
import 'package:discussin_mobile/src/model/topic_response_model.dart' as tpc;
import 'package:discussin_mobile/src/service/post_service.dart';
import 'package:discussin_mobile/src/service/topic_service.dart';
import 'package:discussin_mobile/src/util/finite_state.dart';
import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListNotifier extends ChangeNotifier with FiniteState {
  final _postService = PostService();
  final _topicService = TopicService();

  String _selectedTopic = 'All';
  String get selectedTopic => _selectedTopic;

  Iterable<PostData> get posts => _posts;
  Iterable<PostData> _posts = [];

  Future<void> getAllPost() async {
    try {
      final result = await _postService.getAllPost();
      _posts = result.data;
      notifyListeners();
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }

  Iterable<tpc.Topic> get topics => _topics;
  Iterable<tpc.Topic> _topics = [];

  Future<void> getTopics() async {
    try {
      final result = await _topicService.getTopics();
      _topics = {tpc.Topic(name: 'All', description: ''), ...result.data};
      notifyListeners();
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }

  Future<void> getPostByTopic(String topic) async {
    try {
      if (topic == 'All') {
        final result = await _postService.getAllPost();
        _posts = result.data;
      } else {
        final result = await _postService.getPostsByTopic(topic);
        _posts = result.data;
      }
      notifyListeners();
    } on DioError catch (error) {
      print(error.response?.data);
    }
  }

  void setSelectedTopic(String newTopic) {
    _selectedTopic = newTopic;
    notifyListeners();
  }
}

final postListViewModel = ChangeNotifierProvider(
  (ref) {
    return PostListNotifier();
  },
);
